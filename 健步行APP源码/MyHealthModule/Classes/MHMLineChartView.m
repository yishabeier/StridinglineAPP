//
//  MHMLineChartView.m
//  MyHealthModule
//
//  Created by L on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMLineChartView.h"
#import "MHMHealthModel.h"
#import "MHMHelper.h"
#import "UIImage+Resize.h"
#import "UIView+Layout.h"
#import "UtilsMacro.h"
#import "UIImageView+Dashed.h"

@interface MHMLineChartView ()
@property (nonatomic, strong) UILabel *lblStepCount;
@property (nonatomic, strong) UILabel *lblDayAverageStep;
@property (nonatomic, strong) NSArray *healthModelArray;
@property (nonatomic, assign) NSInteger maxStepCount;
@property (nonatomic, assign) NSInteger minStepCount;
@property (nonatomic, assign) NSInteger totalStepCount;
@property (nonatomic, assign) NSInteger maxLimitCount;
@property (nonatomic, assign) NSInteger minLimitCount;
@property (nonatomic, strong) CABasicAnimation *pathAnimation;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) MHMHealthInterval interval;
@property (nonatomic, strong) UILabel *maxCountLabel;
@property (nonatomic, strong) UILabel *minCountLabel;
@end

@implementation MHMLineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self setupUI];
    
    return self;
}

- (void)setupChartWithDictionary:(NSDictionary *)dic index:(MHMHealthInterval)interval {
    self.healthModelArray = [dic valueForKey:kResultModelsKey];
    self.maxStepCount = [[dic valueForKey:kMaxStepCountKey] integerValue];
    self.minStepCount = [[dic valueForKey:kMinStepCountKey] integerValue];
    self.totalStepCount = [[dic valueForKey:kTotalStepCountKey] integerValue];
    self.interval = interval;
    self.maxLimitCount = [self getMaxLimitCount];
    self.minLimitCount = [self getMinLimitCount];
    if (self.healthModelArray.count != 0) {
        [self.shapeLayer removeAllAnimations];
        [self.shapeLayer removeFromSuperlayer];
        [self drawLineChart];
    }
    //日/年均值手动赋值，这里不作处理
    if (interval != MHMHealthInterval_day && interval != MHMHealthInterval_year) {
        UILabel *lblDayAverageStep = [self viewWithTag:1007];
        lblDayAverageStep.text = F(@"日平均值：%zd",self.healthModelArray.count == 0 ? 0 : self.totalStepCount / self.healthModelArray.count);
    }
    if (interval == MHMHealthInterval_day) {//只显示日总步数
        UILabel *lblStepCount = [self viewWithTag:1008];
        lblStepCount.text = F(@"%zd步",self.totalStepCount);
    }
    self.maxCountLabel.text = F(@"%ld",self.maxLimitCount);
    self.minCountLabel.text = F(@"%ld",self.minLimitCount);
    [self showX];

}

- (NSInteger)getMaxLimitCount {
    NSInteger maxLimitCount = 0;
    if (self.maxStepCount <= 0) {
        maxLimitCount = 0;
    } else {
        maxLimitCount = self.maxStepCount + self.maxStepCount / 3;
        if (self.interval == MHMHealthInterval_day) {
            maxLimitCount = maxLimitCount / 10 * 10;
        } else if (self.interval == MHMHealthInterval_month || self.interval == MHMHealthInterval_week) {
            maxLimitCount = maxLimitCount / 100 * 100;
        } else if (self.interval == MHMHealthInterval_year) {
            maxLimitCount = maxLimitCount / 10000 * 10000;
        }
    }
    return maxLimitCount;
}

- (NSInteger)getMinLimitCount {
    NSInteger minLimitCount = 0;
    if (self.maxStepCount <= 0) {
        minLimitCount = 0;
    } else {
        minLimitCount = self.minStepCount - self.minStepCount / 3;
        if (self.interval == MHMHealthInterval_month || self.interval == MHMHealthInterval_week || self.interval == MHMHealthInterval_day) {
            minLimitCount = minLimitCount / 100 * 100;
        } else if (self.interval == MHMHealthInterval_year) {
            minLimitCount = minLimitCount / 10000 * 10000;
        }
    }
    return minLimitCount;
}

- (void)setupUI {
   self.image = [UIImage resizedImageWithName:@"backgroundIcon"];

    UIColor *lblColor = [UIColor whiteColor];
    
    //步数文字
    UILabel *lblStepPrompt = [self createLabelWithRect:CGRectMake(20, 6, 50, 18)
                                             alignment:NSTextAlignmentLeft
                                                  font:[UIFont systemFontOfSize:18]
                                             textColor:lblColor
                                                  text:@"步数"];
    [self addSubview:lblStepPrompt];
    
    //日平均值
    _lblDayAverageStep = [self createLabelWithRect:CGRectMake(lblStepPrompt.left, lblStepPrompt.bottom + 6, 150, 12)
                                         alignment:NSTextAlignmentLeft
                                              font:[UIFont systemFontOfSize:12]
                                         textColor:lblColor
                                              text:@"日平均值：0"];
    _lblDayAverageStep.tag = 1007;
    [self addSubview:_lblDayAverageStep];
    
    //步数
    _lblStepCount = [self createLabelWithRect:CGRectMake(0, lblStepPrompt.top, 100, 18)
                                    alignment:NSTextAlignmentRight
                                         font:[UIFont systemFontOfSize:18]
                                    textColor:lblColor
                                         text:@"0步"];
    _lblStepCount.right = self.right - 12;
    _lblStepCount.tag = 1008;
    _lblStepCount.textColor = lblColor;
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:_lblStepCount.text];
    [attributeStr setAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15] }
                          range:NSMakeRange(_lblStepCount.text.length - 1, 1)];
    _lblStepCount.attributedText = attributeStr;
    [self addSubview:_lblStepCount];
    
    //今天
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    UILabel *lblDayPrompt = [self createLabelWithRect:CGRectMake(0, _lblDayAverageStep.top, 150, 12)
                                            alignment:NSTextAlignmentRight
                                                 font:[UIFont systemFontOfSize:12]
                                            textColor:lblColor
                                                 text:F(@"今天 %@", [formatter stringFromDate:[NSDate date]])];
    lblDayPrompt.right = _lblStepCount.right;
    [self addSubview:lblDayPrompt];
    
    UIView *firstLineView = [[UIView alloc] initWithFrame:CGRectMake(12, _lblDayAverageStep.bottom + 6, self.width - 24, 0.5)];
    firstLineView.backgroundColor = lblColor;
    firstLineView.tag = 1001;
    [self addSubview:firstLineView];
    
    self.maxCountLabel = [self createLabelWithRect:CGRectMake(0, firstLineView.bottom, 150, 12) alignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:12.0] textColor:lblColor text:@"0"];
    self.maxCountLabel.right = _lblStepCount.right;
    [self addSubview:self.maxCountLabel];
    
    UIImageView *secondLineView = [[UIImageView alloc] initWithFrame:CGRectMake(firstLineView.left, firstLineView.bottom + 49, firstLineView.width, 30)];
    secondLineView.image = [self drawDottedLine:secondLineView.size lineWidth:1 lineColor:lblColor];
    secondLineView.tag = 1002;
    [self addSubview:secondLineView];
    
    UIView *thirdLineView = [[UIView alloc] initWithFrame:CGRectMake(firstLineView.left, firstLineView.bottom + 98, firstLineView.width, firstLineView.height)];
    thirdLineView.backgroundColor = firstLineView.backgroundColor;
    thirdLineView.tag = 1003;
    [self addSubview:thirdLineView];
    
    self.minCountLabel = [self createLabelWithRect:CGRectMake(0, thirdLineView.top - 12, 150, 12) alignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:12.0] textColor:lblColor text:@"0"];
    self.minCountLabel.right = _lblStepCount.right;
    [self addSubview:self.minCountLabel];
    
//    UILabel *lblFirstTime = [self createLabelWithRect:CGRectMake(lblStepPrompt.left, thirdLineView.bottom + 12, 30, 10) alignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:10] textColor:lblColor text:@"0时"];
//    lblFirstTime.tag = 1111;
//    [self addSubview:lblFirstTime];
//    
//    UILabel *lblSecondTime = [self createLabelWithRect:CGRectMake(0, lblFirstTime.top, 30, 10) alignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:10] textColor:lblColor text:@"12时"];
//    lblSecondTime.tag = 2222;
//    lblSecondTime.centerX = self.centerX;
//    [self addSubview:lblSecondTime];
//    
//    UILabel *lblThirdTime = [self createLabelWithRect:CGRectMake(0, lblFirstTime.top, 30, 10) alignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:10] textColor:lblColor text:@"0时"];
//    lblThirdTime.tag = 3333;
//    lblThirdTime.right = self.width - lblStepPrompt.left;
//    [self addSubview:lblThirdTime];
    
    [self drawX];

    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.lineWidth = 1;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self.shapeLayer setAffineTransform:CGAffineTransformMakeTranslation(0, thirdLineView.top - firstLineView.bottom)];
    [self.shapeLayer setAffineTransform:CGAffineTransformMakeScale(1, -1)];
}

- (UILabel *)createLabelWithRect:(CGRect)rect alignment:(NSTextAlignment)textAlignment font:(UIFont *)textFont textColor:(UIColor *)textColor text:(NSString *)text {
    UILabel *lblPrompt = [[UILabel alloc] initWithFrame:rect];
    lblPrompt.textAlignment = textAlignment;
    lblPrompt.textColor = textColor;
    lblPrompt.font = textFont;
    lblPrompt.text = text;
    return lblPrompt;
}

- (void)drawX {
    UIView *thirdLine = [self viewWithTag:1003];
    for (NSInteger j = 1; j <= 7; j++) {
        CGFloat x = 15 + (self.width - 24) / 7 * (j - 1);
        UILabel *xLabel = [self createLabelWithRect:CGRectMake(x, thirdLine.bottom + 12, 40, 10) alignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:10.0] textColor:[UIColor whiteColor] text:@""];
        xLabel.backgroundColor = [UIColor clearColor];
        xLabel.text = @"2月24日";
        xLabel.hidden = YES;
        xLabel.tag = 2000 + j;
        [self addSubview:xLabel];
    }
}

- (void)showX {
    UILabel *label1 = [self viewWithTag:2001];
    UILabel *label2 = [self viewWithTag:2002];
    UILabel *label3 = [self viewWithTag:2003];
    UILabel *label4 = [self viewWithTag:2004];
    UILabel *label5 = [self viewWithTag:2005];
    UILabel *label6 = [self viewWithTag:2006];
    UILabel *label7 = [self viewWithTag:2007];
    if (self.interval == MHMHealthInterval_day) {
        
        [self setLabelArray:@[label1,label4,label7] hidden:NO];
        [self setLabelArray:@[label2,label3,label5,label6] hidden:YES];
        [self setLabelArray:@[label1,label4,label7] text:@[@"0时",@"12时",@"0时"]];
        [self resetLabelFrame:@[label1,label2,label3,label4,label5,label6,label7]];
        
    } else if (self.interval == MHMHealthInterval_week) {
        
        NSInteger lastMonth = 0;
        NSMutableArray *textArray = @[].mutableCopy;
        for (MHMHealthModel *model in self.healthModelArray) {
            if (lastMonth != model.startDateComponents.month) {
                [textArray addObject:F(@"%ld月%ld日",(long)model.startDateComponents.month,(long)model.startDateComponents.day)];
            } else {
                [textArray addObject:F(@"%ld",(long)model.startDateComponents.day)];
            }
            lastMonth = model.startDateComponents.month;
        }
        [self setLabelArray:@[label1,label2,label3,label4,label5,label6,label7] hidden:NO];
        [self setLabelArray:@[label1,label2,label3,label4,label5,label6,label7] text:textArray];
        [self resetLabelFrame:@[label1,label2,label3,label4,label5,label6,label7]];
        
    } else if (self.interval == MHMHealthInterval_month) {
        
        if (self.healthModelArray.count == 30) {
            [self setLabelArray:@[label1,label3,label5,label6,label7] hidden:NO];
            [self setLabelArray:@[label2,label4] hidden:YES];

            NSArray *modelArray = @[self.healthModelArray[0],self.healthModelArray[7],self.healthModelArray[14],self.healthModelArray[21],self.healthModelArray.lastObject];
            NSInteger lastMonth = 0;
            NSMutableArray *textArray = @[].mutableCopy;
            for (MHMHealthModel *model in modelArray) {
                if (lastMonth != model.startDateComponents.month) {
                    [textArray addObject:F(@"%ld月%ld日",(long)model.startDateComponents.month,(long)model.startDateComponents.day)];
                } else {
                    [textArray addObject:F(@"%ld",(long)model.startDateComponents.day)];
                }
                lastMonth = model.startDateComponents.month;
            }
            [self setLabelArray:@[label1,label3,label5,label6,label7] text:textArray];
            label1.centerX = 1 / 5.0 * (self.width - 24) - 20;
            label3.centerX = 2 / 5.0 * (self.width - 24) - 20;
            label5.centerX = 3 / 5.0 * (self.width - 24) - 20;
            label6.centerX = 4 / 5.0 * (self.width - 24) - 20;
            label7.centerX = 5 / 5.0 * (self.width - 24) - 20;
        } else {
            [self setLabelArray:@[label1,label2,label3,label4,label5,label6,label7] hidden:YES];
        }
        
    } else if (self.interval == MHMHealthInterval_year) {
        
        MHMHealthModel *lastModel = self.healthModelArray.lastObject;
        if (!lastModel) {
            [self setLabelArray:@[label1,label2,label3,label4,label5,label6,label7] hidden:YES];
            return;
        }
        NSMutableArray *textArray = @[].mutableCopy;
        if (lastModel.startDateComponents.month - 3 <= 0) {
            [textArray addObject:F(@"%ld年%ld月",(long)lastModel.startDateComponents.year,(long)lastModel.startDateComponents.month)];
            [textArray addObject:F(@"%ld月",12 - (3 - (long)lastModel.startDateComponents.month))];
            [textArray addObject:F(@"%ld月",12 - (6 - (long)lastModel.startDateComponents.month))];
            [textArray addObject:F(@"%ld年%ld月",(long)lastModel.startDateComponents.year - 1,12 - (9 - (long)lastModel.startDateComponents.month))];
        } else if (lastModel.startDateComponents.month - 6 <= 0) {
            [textArray addObject:F(@"%ld月",(long)lastModel.startDateComponents.month)];
            [textArray addObject:F(@"%ld年%ld月",(long)lastModel.startDateComponents.year,(long)lastModel.startDateComponents.month - 3)];
            [textArray addObject:F(@"%ld月",12 - (6 - (long)lastModel.startDateComponents.month))];
            [textArray addObject:F(@"%ld年%ld月",(long)lastModel.startDateComponents.year - 1,12 - (6 - (long)lastModel.startDateComponents.month))];
        } else if (lastModel.startDateComponents.month - 9 <= 0) {
            [textArray addObject:F(@"%ld月",(long)lastModel.startDateComponents.month)];
            [textArray addObject:F(@"%ld月",(long)lastModel.startDateComponents.month - 3)];
            [textArray addObject:F(@"%ld年%ld月",(long)lastModel.startDateComponents.year,(long)lastModel.startDateComponents.month - 6)];
            [textArray addObject:F(@"%ld月",12 - (9 - (long)lastModel.startDateComponents.month))];
        } else if (lastModel.startDateComponents.month - 12 <= 0) {
             [textArray addObject:F(@"%ld月",(long)lastModel.startDateComponents.month)];
             [textArray addObject:F(@"%ld月",(long)lastModel.startDateComponents.month - 3)];
             [textArray addObject:F(@"%ld月",(long)lastModel.startDateComponents.month - 6)];
             [textArray addObject:F(@"%ld年%ld月",(long)lastModel.startDateComponents.year,(long)lastModel.startDateComponents.month - 9)];
        }
        
        [self setLabelArray:@[label1,label3,label5,label7] hidden:NO];
        [self setLabelArray:@[label2,label4,label6] hidden:YES];
        [self resetLabelFrame:@[label1,label2,label3,label4,label5,label6,label7]];
        label1.width = 50;
        label3.width = 50;
        label5.width = 50;
        label7.width = 50;
        [self setLabelArray:@[label1,label3,label5,label7] text:[textArray reverseObjectEnumerator].allObjects];
    }
}

- (void)resetLabelFrame:(NSArray *)labelArray {
    NSInteger i = labelArray.count;
    for (NSInteger j = 1; j <= i; j++) {
        ((UILabel *)labelArray[j - 1]).left = 15 + (self.width - 24) / i * (j - 1);
        ((UILabel *)labelArray[j - 1]).width = 40;
    }
}

- (void)setLabelArray:(NSArray *)labelArray hidden:(BOOL)hidden {
    for (UILabel *label in labelArray) {
        label.hidden = hidden;
    }
}

- (void)setLabelArray:(NSArray *)labelArray text:(NSArray *)textArray {
    if (textArray.count == labelArray.count) {
        for (NSInteger i = 0; i < labelArray.count; i++) {
            ((UILabel *)labelArray[i]).text = textArray[i];
        }
    } else {
        for (NSInteger i = 0; i < labelArray.count; i++) {
            ((UILabel *)labelArray[i]).text = @"";
        }
    }
}

//画虚线
- (UIImage *)drawDottedLine:(CGSize)size lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGFloat lengths[] = {3,3};
    CGContextSetLineWidth(context, lineWidth);
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, lineColor.CGColor);
    CGContextSetLineDash(line, 0, lengths, 2);
    CGContextMoveToPoint(line, 0.0, 0);
    CGContextAddLineToPoint(line, self.frame.size.width, 0);
    CGContextStrokePath(line);
    UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return drawImage;
}
//画折线
- (void)drawLineChart {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIBezierPath *path = [UIBezierPath bezierPath];
        NSArray *points = [self pointsFromModel:self.healthModelArray];
        CGPoint lastPoint = CGPointZero;
        for (NSInteger i = 0; i < points.count; i++) {
            CGPoint p = [[points objectAtIndex:i] CGPointValue];
            [path moveToPoint:CGPointMake(p.x + 2, p.y)];
            [path addArcWithCenter:p radius:2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            if (i == 0) {
                lastPoint = p;
            } else {
                float distance = sqrt(pow(p.x - lastPoint.x, 2) + pow(p.y - lastPoint.y, 2));
                float last_x1 = lastPoint.x + 2 / distance * (p.x - lastPoint.x);
                float last_y1 = lastPoint.y + 2 / distance * (p.y - lastPoint.y);
                float x1 = p.x - 2 / distance * (p.x - lastPoint.x);
                float y1 = p.y - 2 / distance * (p.y - lastPoint.y);
                [path moveToPoint:CGPointMake(last_x1, last_y1)];
                [path addLineToPoint:CGPointMake(x1, y1)];
                lastPoint = p;
            }
        }

        self.shapeLayer.path = path.CGPath;

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.layer addSublayer:self.shapeLayer];
            [CATransaction begin];
            [self.shapeLayer addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
            self.shapeLayer.strokeEnd = 1.0;
            [CATransaction commit];
        });
    });
}

- (NSArray *)pointsFromModel:(NSArray *)healthModelArray {
    UIView *firstLine = [self viewWithTag:1001];
    UIView *thirdLine = [self viewWithTag:1003];
    NSMutableArray *points = @[].mutableCopy;
    NSInteger i = 0;
    if (self.interval == MHMHealthInterval_week) {
        i = 7 - healthModelArray.count;
    } else if (self.interval == MHMHealthInterval_month) {
        i = 30 - healthModelArray.count;
    } else if (self.interval == MHMHealthInterval_year) {
        i = 12 - healthModelArray.count;
    }
    for (MHMHealthModel *model in healthModelArray) {
        i++;
        CGFloat x = 0;
        if (self.interval == MHMHealthInterval_day) {
            x = model.startDateComponents.hour / 24.0 * (self.width - 24);
        } else if (self.interval == MHMHealthInterval_week) {
            x = 25 + (self.width - 24) / 7 * (i - 1);
        } else if (self.interval == MHMHealthInterval_month) {
            x = i / 31.0 * (self.width - 24);
        } else if (self.interval == MHMHealthInterval_year) {
            x = i / 13.0 * (self.width - 24);
        }
        CGFloat y = (model.stepCount - self.minLimitCount) / (CGFloat)(self.maxLimitCount - self.minLimitCount) * (thirdLine.top - firstLine.top);
        x += 12;
        y -= thirdLine.top;
        CGPoint point = CGPointMake(x, y);
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    return points;
}

-(CABasicAnimation *)pathAnimation
{
    if (!_pathAnimation) {
        _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _pathAnimation.duration = 0.0;
        _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _pathAnimation.fromValue = @0.0f;
        _pathAnimation.toValue   = @0.0f;
    }
    return _pathAnimation;
}

- (void)setAverageStepCount:(NSInteger)averageStepCount {
    _averageStepCount = averageStepCount;
    
    UILabel *lblDayAverageStep = [self viewWithTag:1007];
    lblDayAverageStep.text = F(@"日平均值：%zd",averageStepCount);
}
@end
