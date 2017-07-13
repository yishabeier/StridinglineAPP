//
//  MHMHealthDataTool.m
//  MyHealthModule
//
//  Created by L on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMHealthManager.h"
#import "UtilsMacro.h"
#import "MHMHealthModel.h"
#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
#import "MHMHelper.h"

@interface MHMHealthManager ()
@property (nonatomic, strong) HKHealthStore *healthStore;
@end

@implementation MHMHealthManager

- (BOOL)isHealthDataAvailable {
    return [HKHealthStore isHealthDataAvailable];
}

- (void)authorizateHealthKit:(void (^)(BOOL isAuthorizateSuccess))resultBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSSet *readObjectTypes = [NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], nil];
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (resultBlock) {
                resultBlock(success);
            }
        }];
    });
}

- (void)fetchHealthDataForUnit:(MHMHealthIntervalUnit)unit
              queryResultBlock:(void (^)(NSDictionary *queryResultDict))queryResultBlock {
    NSMutableDictionary *tempDict = @{}.mutableCopy;
    
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    
    __block NSDate *endDate = [NSDate date];
    __block NSCalendarUnit calendarUnit;
    __block NSCalendar *calendar;
    
#ifdef IOS8
    calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
#else
    calendar = [NSCalendar calendarWithIdentifier:NSGregorianCalendar];
#endif
    __block NSInteger value = 0;//根据该值计算查询开始时间
    NSDateComponents *currentComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:endDate];
    NSTimeInterval currentInterval = currentComponents.hour * 3600 + currentComponents.minute * 60 + currentComponents.second;
    
    switch (unit) {
        case MHMHealthIntervalUnitDay:
            intervalComponents.hour = 1;
            calendarUnit = NSCalendarUnitHour;
            value = currentComponents.hour;
            endDate = [NSDate dateWithTimeIntervalSinceNow: - (currentComponents.minute * 60 + currentComponents.second)];
            break;
        case MHMHealthIntervalUnitWeek:
            value = 6;
            intervalComponents.day = 1;
            endDate = [NSDate dateWithTimeIntervalSinceNow:- (currentInterval + 24 * 3600)];
            calendarUnit = NSCalendarUnitDay;
            break;
        case MHMHealthIntervalUnitMonth:
            value = 29;
            intervalComponents.day = 1;
            endDate = [NSDate dateWithTimeIntervalSinceNow:- (currentInterval + 24 * 3600)];
            calendarUnit = NSCalendarUnitDay;
            break;
        case MHMHealthIntervalUnitYear:
            value = 12;
            intervalComponents.month = 1;
            calendarUnit = NSCalendarUnitMonth;
            break;
    }
    
    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                     fromDate:endDate];
    
    [self executeQueryForQuantityType:quantityType
                            predicate:nil
                           anchorDate:[calendar dateFromComponents:anchorComponents]
                   intervalComponents:intervalComponents
                       callBackResult:^(HKStatisticsCollection * _Nullable result, NSError *error) {
        if (error) {
            LQLog(@"an error occurred while calculating the statistics %@",error.localizedDescription);
        } else {
            
            NSDate *startDate = [calendar dateByAddingUnit:calendarUnit
                                                     value:-value
                                                    toDate:endDate
                                                   options:0];
            
            __block NSMutableArray *tempArray = @[].mutableCopy;
            __block NSInteger maxStepCount = 0;//最大步行数
            __block NSInteger minStepCount = 0;//最小步行数
            __block double totalStepCount = 0;//总步行数
            
            [result enumerateStatisticsFromDate:startDate toDate:endDate withBlock:^(HKStatistics * _Nonnull statistic, BOOL * _Nonnull stop) {
                for (HKSource *source in statistic.sources) {                    if ([source.name isEqualToString:[UIDevice currentDevice].name]) {//只取设备的步数，过滤其他第三方应用的
                        double stepCount = [[statistic sumQuantityForSource:source] doubleValueForUnit:[HKUnit countUnit]];
                        if (stepCount > 0) {//手动从健康应用中获取添加数据，设备步数为0，这里做过滤操作
                            //初始化最小步数为第一个值，方便之后计算最小步数
                            if (minStepCount == 0) {
                                minStepCount = stepCount;
                            }
                            maxStepCount = MAX(maxStepCount, stepCount);
                            minStepCount = MIN(minStepCount, stepCount);
                            totalStepCount += stepCount;
                            
                            @autoreleasepool {
                                //数据封装
                                MHMHealthModel *healthModel = [[MHMHealthModel alloc] init];
                                healthModel.startDateComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                              fromDate:statistic.startDate];
                                healthModel.endDateComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                            fromDate:statistic.endDate];
                                healthModel.stepCount = stepCount;
                                
                                [tempArray addObject:healthModel];
                            }
                            break;
                        }
                    }
                }
            }];
            
            [tempDict setObject:tempArray forKey:kResultModelsKey];
            [tempDict setObject:@(maxStepCount) forKey:kMaxStepCountKey];
            [tempDict setObject:@(minStepCount) forKey:kMinStepCountKey];
            [tempDict setObject:@(totalStepCount) forKey:kTotalStepCountKey];
            
            if (queryResultBlock) {
                queryResultBlock(tempDict);
            }
        }
    }];
}

- (void)fetchHealthDataFordistance:(MHMHealthIntervalUnit)unit
              queryResultBlock:(void (^)(NSDictionary *queryResultDict))queryResultBlock {
    NSMutableDictionary *tempDict = @{}.mutableCopy;
    
//    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    
    __block NSDate *endDate = [NSDate date];
    __block NSCalendarUnit calendarUnit;
    __block NSCalendar *calendar;
    
#ifdef IOS8
    calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
#else
    calendar = [NSCalendar calendarWithIdentifier:NSGregorianCalendar];
#endif
    __block NSInteger value = 0;//根据该值计算查询开始时间
    NSDateComponents *currentComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:endDate];
    NSTimeInterval currentInterval = currentComponents.hour * 3600 + currentComponents.minute * 60 + currentComponents.second;
    
    switch (unit) {
        case MHMHealthIntervalUnitDay:
            intervalComponents.hour = 1;
            calendarUnit = NSCalendarUnitHour;
            value = currentComponents.hour;
            endDate = [NSDate dateWithTimeIntervalSinceNow: - (currentComponents.minute * 60 + currentComponents.second)];
            break;
        case MHMHealthIntervalUnitWeek:
            value = 6;
            intervalComponents.day = 1;
            endDate = [NSDate dateWithTimeIntervalSinceNow:- (currentInterval + 24 * 3600)];
            calendarUnit = NSCalendarUnitDay;
            break;
        case MHMHealthIntervalUnitMonth:
            value = 29;
            intervalComponents.day = 1;
            endDate = [NSDate dateWithTimeIntervalSinceNow:- (currentInterval + 24 * 3600)];
            calendarUnit = NSCalendarUnitDay;
            break;
        case MHMHealthIntervalUnitYear:
            value = 12;
            intervalComponents.month = 1;
            calendarUnit = NSCalendarUnitMonth;
            break;
    }
    
    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                     fromDate:endDate];
    
    [self executeQueryForQuantityType:distanceType
                            predicate:nil
                           anchorDate:[calendar dateFromComponents:anchorComponents]
                   intervalComponents:intervalComponents
                       callBackResult:^(HKStatisticsCollection * _Nullable result, NSError *error) {
                           if (error) {
                               LQLog(@"an error occurred while calculating the statistics %@",error.localizedDescription);
                           } else {
                               
                               NSDate *startDate = [calendar dateByAddingUnit:calendarUnit
                                                                        value:-value
                                                                       toDate:endDate
                                                                      options:0];
                               
                               __block NSMutableArray *tempArray = @[].mutableCopy;
                               __block NSInteger maxStepCount = 0;//最大步行数
                               __block NSInteger minStepCount = 0;//最小步行数
                               __block double totalStepCount = 0;//总步行数
                               __block double totleDistance = 0; //总距离
                               
                               [result enumerateStatisticsFromDate:startDate toDate:endDate withBlock:^(HKStatistics * _Nonnull statistic, BOOL * _Nonnull stop) {
                                   for (HKSource *source in statistic.sources) {
                                       if ([source.name isEqualToString:[UIDevice currentDevice].name]) {//只取设备的步数，过滤其他第三方应用的
//                                           double stepCount = [[statistic sumQuantityForSource:source] doubleValueForUnit:[HKUnit countUnit]];
                                           double distanceCount =[[statistic sumQuantityForSource:source]doubleValueForUnit:[HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo]];
//                                           double usersHeight = [[statistic sumQuantityForSource:source]doubleValueForUnit:distanceCount] ;
//                                           totleSteps += usersHeight;
//                                           
                                           
                                           
                                           if (distanceCount > 0) {//手动从健康应用中获取添加数据，设备步数为0，这里做过滤操作
                                               //初始化最小步数为第一个值，方便之后计算最小步数
//                                               if (minStepCount == 0) {
//                                                   minStepCount = stepCount;
//                                               }
//                                               maxStepCount = MAX(maxStepCount, stepCount);
//                                               minStepCount = MIN(minStepCount, stepCount);
//                                               totalStepCount += stepCount;
                                              totleDistance += distanceCount;
                                               @autoreleasepool {
                                                   //数据封装
                                                   MHMHealthModel *healthModel = [[MHMHealthModel alloc] init];
                                                   healthModel.startDateComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                                                 fromDate:statistic.startDate];
                                                   healthModel.endDateComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                                               fromDate:statistic.endDate];
                                                   healthModel.distanceCount = distanceCount;
                                                   NSMutableArray *array=[NSMutableArray array];
                                                   
                                                   [tempArray addObject:healthModel];
                                               }
                                               break;
                                           }
                                       }
                                   }
                               }];
                               
                               [tempDict setObject:tempArray forKey:kResultModelsKey];
                               [tempDict setObject:@(maxStepCount) forKey:kMaxStepCountKey];
                               [tempDict setObject:@(minStepCount) forKey:kMinStepCountKey];
//                               [tempDict setObject:@(totalStepCount) forKey:kTotalStepCountKey];
                               [tempDict setObject:@(totleDistance) forKey:distanceCountKey];
                               
                               if (queryResultBlock) {
                                   queryResultBlock(tempDict);
                               }
                           }
                       }];
}

- (void)fetchAllHealthDataByDay:(void (^)(NSArray *modelArray))queryResultBlock {
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.day = 1;
    
    __block NSCalendar *calendar;
    
#ifdef IOS8
    calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
#else
    calendar = [NSCalendar calendarWithIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *currentComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow: - (currentComponents.hour * 3600 + currentComponents.minute * 60 + currentComponents.second)];

    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                     fromDate:endDate];
    
    [self executeQueryForQuantityType:quantityType
                            predicate:nil
                           anchorDate:[calendar dateFromComponents:anchorComponents]
                   intervalComponents:intervalComponents
                       callBackResult:^(HKStatisticsCollection * _Nullable result, NSError *error) {
        if (error) {
            LQLog(@"an error occurred while calculating the statistics %@",error.localizedDescription);
        } else {
            
            __block NSMutableArray *tempArray = @[].mutableCopy;
            
            [result.statistics enumerateObjectsUsingBlock:^(HKStatistics * _Nonnull statistics, NSUInteger idx, BOOL * _Nonnull statisticsStop) {
                [statistics.sources enumerateObjectsUsingBlock:^(HKSource * _Nonnull source, NSUInteger idx, BOOL * _Nonnull sourceStop) {
//                    if ([source.name isEqualToString:[UIDevice currentDevice].name]) {//只取设备的步数，过滤其他第三方应用的
                        double stepCount = [[statistics sumQuantityForSource:source] doubleValueForUnit:[HKUnit countUnit]];
                        
                        @autoreleasepool {
                            //数据封装
                            MHMHealthModel *healthModel = [[MHMHealthModel alloc] init];
                            healthModel.startDateComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                          fromDate:statistics.startDate];
                            healthModel.endDateComponents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                        fromDate:statistics.endDate];
                            healthModel.stepCount = stepCount;
                            [tempArray insertObject:healthModel atIndex:0];//倒序
                        }
                        *sourceStop = YES;
//                    }
                }];
            }];
            
            if (queryResultBlock) {
                queryResultBlock(tempArray);
            }
        }
    }];
}

//查询
- (void)executeQueryForQuantityType:(HKQuantityType *)quantityType
                          predicate:(nullable NSPredicate *)quantitySamplePredicate
                         anchorDate:(NSDate *)anchorDate
                 intervalComponents:(NSDateComponents *)intervalComponents
                     callBackResult:(void (^)(HKStatisticsCollection * __nullable result, NSError *error))queryResult {
    
    HKStatisticsCollectionQuery *collectionQuery =
    [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
                                      quantitySamplePredicate:quantitySamplePredicate
                                                      options:HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource
                                                   anchorDate:anchorDate
                                           intervalComponents:intervalComponents];
    
    collectionQuery.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection * __nullable result, NSError * __nullable error){
        if (queryResult) {
            queryResult(result, error);
        }
    };
    [self.healthStore executeQuery:collectionQuery];
}

#pragma mark - getter
- (HKHealthStore *)healthStore {
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return _healthStore;
}

@end
