//
//  MHMHealthDataTool.h
//  MyHealthModule
//
//  Created by L on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MHMHealthIntervalUnit) {
    MHMHealthIntervalUnitDay,
    MHMHealthIntervalUnitWeek,
    MHMHealthIntervalUnitMonth,
    MHMHealthIntervalUnitYear,
};

@interface MHMHealthManager : NSObject

/**
 *  判断设备是否支持健康应用
 *
 *  @return YES 支持  NO 不支持
 */
- (BOOL)isHealthDataAvailable;

/**
 *  应用授权
 */
- (void)authorizateHealthKit:(void (^)(BOOL isAuthorizateSuccess))resultBlock;

/**
 *  获取健康应用步数信息
 *
 *  @param unit             数据段类型
 *  @param queryResultBlock 结果返回block 以字典形式返回数据：resultModels：查询后封装的model数组 ； maxStepCount：最大步数；minStepCount：最小步数；totalStepCount：总步数
 */
- (void)fetchHealthDataForUnit:(MHMHealthIntervalUnit)unit
              queryResultBlock:(void (^)(NSDictionary *queryResultDict))queryResultBlock;

/**
 *  按天获取所有健康数据
 */
- (void)fetchAllHealthDataByDay:(void (^)(NSArray *modelArray))queryResultBlock;

- (void)fetchHealthDataFordistance:(MHMHealthIntervalUnit)unit
                  queryResultBlock:(void (^)(NSDictionary *queryResultDict))queryResultBlock;
@end
