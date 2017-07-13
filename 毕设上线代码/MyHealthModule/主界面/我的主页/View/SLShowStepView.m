//
//  ShowStepView.m
//  LeftSlide
//
//  Created by L on 17/2/20.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "SLShowStepView.h"

@implementation SLShowStepView
{
    UILabel *stepLab;
}

- (instancetype)initWithFrame:(CGRect)frame currentStep:(NSInteger)step;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createShowView:step];
    }
    return self;
}

-(void)setAverageStepNum:(NSInteger)averageStepNum{
    stepLab.text = [NSString stringWithFormat:@"日平均值：%zi",averageStepNum];
}

-(void)createShowView:(NSInteger)step{
    //显示文字步数
    UILabel *showLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    showLab.text = @"步数";
    showLab.textColor = [UIColor whiteColor];
    showLab.textAlignment = NSTextAlignmentLeft;
    showLab.font = [UIFont systemFontOfSize:25];
    [self addSubview:showLab];
    
    //显示当天步数
    showLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(showLab.frame), 0, self.frame.size.width-CGRectGetMaxX(showLab.frame), 30)];
    showLab.attributedText = [self attributedStrWithStr:[NSString stringWithFormat:@"%zi步",step] bigFont:25 smallFont:15 bigTextColor:[UIColor whiteColor] smallTextColor:[UIColor whiteColor] withLastWordLength:1];
    showLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:showLab];

    //显示当前时间
    CGRect rc = [[self getCurrentDate] boundingRectWithSize:CGSizeMake(MAXFLOAT, 17) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    showLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-rc.size.width-5, CGRectGetMaxY(showLab.frame)+5, rc.size.width, 17)];
    showLab.text = [self getCurrentDate];
    showLab.textColor = [UIColor whiteColor];
    showLab.font = [UIFont systemFontOfSize:14];
    showLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:showLab];
    
    //step显示
    stepLab = [[UILabel alloc] initWithFrame:CGRectMake(0, showLab.frame.origin.y, self.frame.size.width-showLab.frame.origin.x+15, 17)];
    stepLab.text = [NSString stringWithFormat:@"日平均值：0"];
    stepLab.textColor = [UIColor whiteColor];
    stepLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:stepLab];
    showLab = nil;
}

-(NSString *)getCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    NSString *showTime = @"今日 ";
    showTime =[showTime stringByAppendingString:[self getTheTimeBucket]];
    showTime = [showTime stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
    return showTime;
}

-(NSMutableAttributedString *)attributedStrWithStr:(NSString *)str
                                           bigFont:(CGFloat)bigFont
                                         smallFont:(CGFloat)smallFont
                                      bigTextColor:(UIColor *)bigColor
                                    smallTextColor:(UIColor *)smallColor
                                withLastWordLength:(int)length{
    
    NSMutableAttributedString *showStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [showStr addAttribute:NSForegroundColorAttributeName value:bigColor range:NSMakeRange(0, str.length-length)];
    [showStr addAttribute:NSForegroundColorAttributeName value:smallColor range:NSMakeRange(str.length-length, length)];
    [showStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:bigFont] range:NSMakeRange(0, str.length-length)];
    [showStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:smallFont] range:NSMakeRange(str.length-length, length)];
    
    return showStr;
    
}
//将时间点转化成日历形式
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate * destinationDateNow = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:destinationDateNow];
    
    //设置当前的时间点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}
//获取时间段
-(NSString *)getTheTimeBucket
{
    //    NSDate * currentDate = [self getNowDateFromatAnDate:[NSDate date]];
    
    NSDate * currentDate = [NSDate date];
    if ([currentDate compare:[self getCustomDateWithHour:0]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:9]] == NSOrderedAscending)
    {
        return @"早上";
    }
    else if ([currentDate compare:[self getCustomDateWithHour:9]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:11]] == NSOrderedAscending)
    {
        return @"上午";
    }
    else if ([currentDate compare:[self getCustomDateWithHour:11]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:13]] == NSOrderedAscending)
    {
        return @"中午";
    }
    else if ([currentDate compare:[self getCustomDateWithHour:13]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:18]] == NSOrderedAscending)
    {
        return @"下午";
    }
    else
    {
        return @"晚上";
    }
}


@end
