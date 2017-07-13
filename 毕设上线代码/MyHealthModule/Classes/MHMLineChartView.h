//
//  MHMLineChartView.h
//  MyHealthModule
//
//  Created by L on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MHMHealthInterval) {
    MHMHealthInterval_day,
    MHMHealthInterval_week,
    MHMHealthInterval_month,
    MHMHealthInterval_year
};

@interface MHMLineChartView : UIImageView
//日/年平均值手动赋值
@property (nonatomic, assign) NSInteger averageStepCount;

- (void)setupChartWithDictionary:(NSDictionary *)dic index:(MHMHealthInterval)interval;
@end
