//
//  HistoryViewController.m
//  MyHealth
//
//  Created by L on 2017/4/6.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "HistoryViewController.h"
#import "AppDelegate.h"
#import "ASDayPicker.h"
#import "Head.h"
#import <HealthKit/HealthKit.h>

@interface HistoryViewController ()

@property(strong,nonatomic) ASDayPicker *dayPicker;
@property(strong,nonatomic)  UILabel *selectedDayLabel;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIView *footCountView;
@property (weak, nonatomic) IBOutlet UIView *floorView;
@property (weak, nonatomic) IBOutlet UIView *kaLuLiView;
@property (weak, nonatomic) IBOutlet UILabel *footDisCountLab;
@property (weak, nonatomic) IBOutlet UILabel *footCountLab;
@property (weak, nonatomic) IBOutlet UILabel *floorCountLab;
@property (weak, nonatomic) IBOutlet UILabel *kaLuLiLab;
@property (weak, nonatomic) IBOutlet UILabel *hourLab;

@property(nonatomic,strong)HKHealthStore *healthStore;

@end

@implementation HistoryViewController
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"newNaBarBackgroundImage.png"] forBarMetrics:UIBarMetricsDefault];
    self.title=@"健身历史";
    [self initCalendar]; //日历界面
    [self initImageView]; //设置view的圆角
    [self queryStepCount];//
    
//    NSString *str =[NSString stringWithFormat:@"%ld", (long)_model.stepCount];
//    self.footCountLab.text=str;
    
   }
-(void)initCalendar{
    self.selectedDayLabel =[[UILabel alloc]initWithFrame:CGRectMake(WScreen/3.4, WScreen*0.19, WScreen/2, 35)];
    self.dayPicker=[[ASDayPicker alloc]initWithFrame:CGRectMake(0, 10, WScreen, WScreen*0.17)];
    NSDateComponents *weeks = [[NSDateComponents alloc] init];
    weeks.week = 4;
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:weeks toDate:[NSDate date] options:0];
    self.dayPicker.selectedDateBackgroundImage = [UIImage imageNamed:@"消息圆点"];
    [self.dayPicker setStartDate:[NSDate date] endDate:endDate];
    
    [self.dayPicker addObserver:self forKeyPath:@"selectedDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.dayPicker];
    [self.view addSubview:self.selectedDayLabel];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSDate *day = change[NSKeyValueChangeNewKey];
    self.selectedDayLabel.text =  [NSDateFormatter localizedStringFromDate:day dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}
-(void)initRemarkView{
    
}
-(void)initImageView{
    
    self.footView.layer.cornerRadius = 8.0f;
    self.footView.layer.masksToBounds = YES;
    self.footCountView.layer.cornerRadius = 8.0f;
    self.footCountView.layer.masksToBounds = YES;
    self.floorView.layer.cornerRadius = 8.0f;
    self.floorView.layer.masksToBounds = YES;
    self.kaLuLiView.layer.cornerRadius = 8.0f;
    self.kaLuLiView.layer.masksToBounds = YES;

    
}
- (void)queryStepCount

{
    if (![HKHealthStore isHealthDataAvailable])
    {
        NSLog(@"设备不支持healthKit");
        return;

    }
    _healthStore = [[HKHealthStore alloc] init];
    HKObjectType *type1 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]; // 步数
    HKObjectType *type2 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]; // 步行+跑步距离
    HKObjectType *type3 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];     // 已爬楼层
    HKObjectType *tyep4 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]; // 活动能量
    HKObjectType *type5 = [HKObjectType activitySummaryType];// 健身记录
    NSSet *set = [NSSet setWithObjects:type1, type2, type3, tyep4, type5, nil]; // 读集合
    __weak typeof (&*self) weakSelf = self;
    [_healthStore requestAuthorizationToShareTypes:nil readTypes:set completion:^(BOOL success, NSError * _Nullable error) {
        
        if (success)
            
        {
            [weakSelf readStepCount];
            
        } else
        {
            NSLog(@"healthkit不允许读写");
        }
    }];
    
}
//查询数据

- (void)readStepCount
{
    
    HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptors用来告诉healthStore怎么样将结果排序。
    
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    
    NSSortDescriptor *end   = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];

    /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个
     
     HKSample类所以对应的查询类就是HKSampleQuery。
     
     下面的limit参数传1表示查询最近一条数据,查询多条数据只要设置limit的参数值就可以了
     
     */
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
//   NSDateComponents *dateCom = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *dateCom =[calendar components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond fromDate:[NSDate date]];
    NSDate *startDate, *endDate;
    endDate = [calendar dateFromComponents:dateCom];
    [dateCom setHour:0];
    [dateCom setMinute:0];
    [dateCom setSecond:0];
    
    
    
    startDate = [calendar dateFromComponents:dateCom];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];

    __weak typeof (&*_healthStore)weakHealthStore = _healthStore;
    HKSampleQuery *q1 = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        double sum = 0;
        double sumTime = 0;
        NSLog(@"步数结果=%@", results);
        for (HKQuantitySample *res in results)
        {
            sum += [res.quantity doubleValueForUnit:[HKUnit countUnit]];

            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            
            NSInteger interval = [zone secondsFromGMTForDate:res.endDate];
            
            NSDate *startDate = [res.startDate dateByAddingTimeInterval:interval];
            
            NSDate *endDate   = [res.endDate dateByAddingTimeInterval:interval];
            
            
            
            sumTime += [endDate timeIntervalSinceDate:startDate];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                //查询是在多线程中进行的，如果要对UI进行刷新，要回到主线程中

                
            }];
            
        }
        
        int h = sumTime / 3600;
        int m = ((long)sumTime % 3600)/60;
        NSLog(@"运动时长：%@小时%@分", @(h), @(m));
        NSString *kaluliCount=[NSString stringWithFormat:@"%@",@(m).stringValue];
        NSString *hour =[NSString stringWithFormat:@"%@",@(h).stringValue];
        _kaLuLiLab.text=kaluliCount;
        _hourLab.text =hour;
        NSLog(@"运动步数：%@步", @(sum));
        NSString *footCount =[NSString stringWithFormat:@"%@",@(sum).stringValue];
        _footCountLab.text =footCount;
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:footCount forKey:@"footCount"];

        if(error) NSLog(@"1error==%@", error);
        [weakHealthStore stopQuery:query];
//        NSLog(@"\n\n");
//        
    }];
 
    HKSampleType *timeSampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    HKSampleQuery *q2 = [[HKSampleQuery alloc] initWithSampleType:timeSampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        double time = 0;
        
        for (HKQuantitySample *res in results)
            
        {
            
            time += [res.quantity doubleValueForUnit:[HKUnit meterUnit]];
            
        }
        
        NSLog(@"运动距离===%@米", @((long)time));
        NSString *footDisCount=[NSString stringWithFormat:@"%@",@((long)time).stringValue];
        _footDisCountLab.text=footDisCount;
        if(error) NSLog(@"2error==%@", error);
        
        [weakHealthStore stopQuery:query];
        
    }];
    HKSampleType *type3 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    HKSampleQuery *q3 = [[HKSampleQuery alloc] initWithSampleType:type3 predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        double num = 0;
        for (HKQuantitySample *res in results)
        {
            num += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
        }
        NSLog(@"楼层===%@层", @(num));
        NSString *floorCount=[NSString stringWithFormat:@"%@",@(num).stringValue];
        _floorCountLab.text=floorCount;
        if(error) NSLog(@"3error==%@", error);
        
        [weakHealthStore stopQuery:query];
        
    }];
    HKSampleType *type4 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    
    HKSampleQuery *q4 = [[HKSampleQuery alloc] initWithSampleType:type4 predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        double num = 0;
        for (HKQuantitySample *res in results)
        {
            num += [res.quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
        }
        NSLog(@"卡路里===%@大卡", @((long)num));
//        NSString *kaluliCount=[NSString stringWithFormat:@"%@",@((long)num).stringValue];
//        _kaLuLiLab.text=kaluliCount;
        if(error) NSLog(@"4error==%@", error);
        [weakHealthStore stopQuery:query];
        NSLog(@"\n\n");
    }];
//   NSDateComponents *dateCom5B = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *dateCom5B =[calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];
//    [dateCom5B setDay:(dateCom5B.day - 10)];
    dateCom5B.calendar = calendar;
//    NSDateComponents *dateCom5E = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *dateCom5E = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];

//    dateCom5E.calendar = calendar;
    NSPredicate *predicate5 = [HKActivitySummaryQuery predicateForActivitySummaryWithDateComponents:dateCom5B];
    
//        NSPredicate *predicate5 = [HKActivitySummaryQuery predicateForActivitySummariesBetweenStartDateComponents:dateCom5B endDateComponents:dateCom5E];
    
    HKActivitySummaryQuery *q5 = [[HKActivitySummaryQuery alloc] initWithPredicate:predicate5 resultsHandler:^(HKActivitySummaryQuery * _Nonnull query, NSArray<HKActivitySummary *> * _Nullable activitySummaries, NSError * _Nullable error) {
        double energyNum       = 0;
        double exerciseNum     = 0;
        double standNum        = 0;
        double energyGoalNum   = 0;
        double exerciseGoalNum = 0;
        double standGoalNum    = 0;        
        for (HKActivitySummary *summary in activitySummaries)
            
        {
            
            energyNum       += [summary.activeEnergyBurned doubleValueForUnit:[HKUnit kilocalorieUnit]];
            
            exerciseNum     += [summary.appleExerciseTime doubleValueForUnit:[HKUnit secondUnit]];
            
            standNum        += [summary.appleStandHours doubleValueForUnit:[HKUnit countUnit]];
            
            energyGoalNum   += [summary.activeEnergyBurnedGoal doubleValueForUnit:[HKUnit kilocalorieUnit]];
            
            exerciseGoalNum += [summary.appleExerciseTimeGoal doubleValueForUnit:[HKUnit secondUnit]];
            
            standGoalNum    += [summary.appleStandHoursGoal doubleValueForUnit:[HKUnit countUnit]];
            
        }
        
//        NSLog(@"\n\n");
//        
//        NSLog(@"健身记录：energyNum=%@",       @(energyNum));
//        
//        NSLog(@"健身记录：exerciseNum=%@",     @(exerciseNum));
//        
//        NSLog(@"健身记录：standNum=%@",        @(standNum));
//        
//        NSLog(@"健身记录：energyGoalNum=%@",   @(energyGoalNum));
//        
//        NSLog(@"健身记录：exerciseGoalNum=%@", @(exerciseGoalNum));
//        
//        NSLog(@"健身记录：standGoalNum=%@",    @(standGoalNum));
        
        if(error) NSLog(@"5error==%@", error);
        
        [weakHealthStore stopQuery:query];
        
        NSLog(@"\n\n");
        
    }];
    
    
    
    //执行查询
    
    [_healthStore executeQuery:q1];
    
    [_healthStore executeQuery:q2];
    
    [_healthStore executeQuery:q3];
    
    [_healthStore executeQuery:q4];
    
    [_healthStore executeQuery:q5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
