//
//  JZShowView.m
//  LeftSlide
//
//  Created by L on 17/2/17.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "SLHistogramView.h"
#define PI 3.14159265358979323846 

#define zeroY (self.frame.size.height-35)

#define topY  20

#define Ywidth   40

#define jzViewWidth 5.0

#define jzColor [UIColor yellowColor]

#define xyFont   10

@interface SLHistogramView ()
{
    CGFloat maxYScale;
    NSInteger maxY;
    NSInteger showType;
    float leftX;
}
@property(nonatomic,copy)NSArray *dateArray;
@end

@implementation SLHistogramView

- (instancetype)initWithFrame:(CGRect)frame dateArray:(NSArray *)dataArray Xtype:(ShowType)type leftX:(float)x{
    self = [super initWithFrame:frame];
    if (self) {
        showType = type;
        leftX = x;
        self.dateArray = dataArray;
        [self getMaxYScale];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{

    [self YLineX:self.frame.size.width - leftX];
    float maxLength = (self.frame.size.width-Ywidth-leftX*2-jzViewWidth);
    [self XLineX:leftX];
    for (int i = 0; i<self.dateArray.count; i++) {
        float xPoint = (leftX+10+(maxLength/(self.dateArray.count-1))*i);
        [self onePillarsWithX:xPoint height:[self.dateArray[i] integerValue] * maxYScale];
        [self showXPoint:xPoint+(jzViewWidth/2) num:i];
    }
}

-(void)getMaxYScale{
    for (int i = 0; i<self.dateArray.count; i++) {
        NSInteger foot = [self.dateArray[i] integerValue];
        if (maxY < foot) {
            maxY = foot;
        }
    }
    NSInteger intNum = [self integerLength:maxY];
    maxY =((maxY%intNum)?(maxY/intNum)+1:(maxY/intNum))*intNum;
    maxYScale = (zeroY-topY)/maxY*1.0;
}

-(NSInteger)integerLength:(NSInteger)num{
    NSInteger total = 0;    //几位数
    NSInteger intNum = 1;  //位数的10000
    while (num>9) {
        num = num/10;
        total ++;
        intNum = intNum *10;
    }
    return intNum;
}

#pragma mark y轴
-(void)YLineX:(float)x{
    NSArray *pointArr = [self getYArray];
    for (int i = 0; i<pointArr.count; i++) {
        NSDictionary *labArr = @{NSFontAttributeName:[UIFont systemFontOfSize:xyFont],NSForegroundColorAttributeName:jzColor};
        NSString *showStr = pointArr[i][@"showNum"];
        CGSize labSize = [showStr sizeWithAttributes:labArr];
        
        [showStr drawInRect:CGRectMake(x-labSize.width, [pointArr[i][@"pointY"] floatValue]-(labSize.height/2)-2, labSize.width, labSize.height) withAttributes:labArr];
    }
}

#pragma mark y坐标
-(NSArray *)getYArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    NSInteger pointNum = maxY/[self integerLength:maxY];  //点的个数
//    for (int i = 0; i<pointNum+1; i++) {
//        NSMutableDictionary *muDict = [[NSMutableDictionary alloc] init];
//        [muDict setValue:[NSString stringWithFormat:@"%ld",i*[self integerLength:maxY]] forKey:@"showNum"];
//        [muDict setValue:@(zeroY-((zeroY -topY)/pointNum *i)) forKey:@"pointY"];
//        [muArr addObject:muDict];
//    }
    
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] init];
    [muDict setValue:[NSString stringWithFormat:@"0"] forKey:@"showNum"];
    [muDict setValue:@(zeroY) forKey:@"pointY"];
    [muArr addObject:muDict];
    muDict = nil;
    
    muDict = [[NSMutableDictionary alloc] init];
    NSString *showNum =[NSString stringWithFormat:@"%ld",pointNum*[self integerLength:maxY]];
    if ([showNum integerValue]>=10000) {
        showNum = [NSString stringWithFormat:@"%.1f万",([showNum floatValue]/10000)];
    }
    [muDict setValue:showNum forKey:@"showNum"];
    [muDict setValue:@(zeroY-((zeroY -topY)/pointNum *pointNum)) forKey:@"pointY"];
    [muArr addObject:muDict];
    muDict = nil;
    return muArr;
}

-(void)onePillarsWithX:(float)x height:(float)h{
    if( h > 0 ){
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        float radius =jzViewWidth/2-0.6; //半径
        if(h > (radius)*2){
            
            float lineH = h-((radius)*2);  //线的高度   10为上下连个半弧
            NSLog(@"~~~%f~~~",lineH);
            
            float lineY = zeroY-lineH;  //先得y点坐标
            
            CGPoint aPoints[2];//坐标点
            aPoints[0] =CGPointMake(x, lineY);//坐标1
            aPoints[1] =CGPointMake(x, lineY+lineH);//坐标2
            
            CGContextMoveToPoint(contextRef, x, lineY);
            /*画矩形*/
            CGContextSetFillColorWithColor(contextRef, jzColor.CGColor);//填充颜色
            CGContextFillRect(contextRef,CGRectMake(x, lineY, jzViewWidth, lineH));//填充框
            CGContextDrawPath(contextRef, kCGPathFillStroke);//绘画路径
            
            /*画扇形*/
            //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
            CGContextSetStrokeColorWithColor(contextRef, jzColor.CGColor); //设置画笔颜色
            CGContextSetFillColorWithColor(contextRef, jzColor.CGColor);//填充颜色
                                                                                      //以10为半径围绕圆心画指定角度扇形
            CGContextMoveToPoint(contextRef, x+jzViewWidth/2, lineY); //移动到扇形中点
            CGContextAddArc(contextRef, x+jzViewWidth/2, lineY, jzViewWidth/2-0.6,  -0 * PI / 180, -180 * PI / 180, 1);
            CGContextClosePath(contextRef);
            CGContextDrawPath(contextRef, kCGPathFillStroke); //绘制路径
            
            CGContextMoveToPoint(contextRef, x+jzViewWidth/2, zeroY);
            CGContextAddArc(contextRef, x+jzViewWidth/2, zeroY, jzViewWidth/2-0.6, -180 * PI / 180, -0 * PI / 180, 1);
            CGContextClosePath(contextRef);
            CGContextDrawPath(contextRef, kCGPathFillStroke);
            
        }else{
            //画椭圆
            CGContextSetStrokeColorWithColor(contextRef, jzColor.CGColor);
            CGContextSetFillColorWithColor(contextRef, jzColor.CGColor);
            CGContextSetLineWidth(contextRef, 1.0);
            CGContextMoveToPoint(contextRef, x, zeroY-(h/2));
            CGContextAddEllipseInRect(contextRef, CGRectMake(x, zeroY-(h/2), jzViewWidth, h)); //椭圆
            CGContextDrawPath(contextRef, kCGPathFillStroke);
        }
    }
}

-(void)XLineX:(float)x{
    
    NSArray *pointArr = [self getYArray];
    CGSize labSize = [pointArr[pointArr.count-1][@"showNum"] sizeWithAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:xyFont]}];
    CGFloat topYPoint = topY-(labSize.height/2)-2;

    pointArr = nil;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(contextRef, x, topYPoint);
    CGPoint aPoint[2];
    aPoint[0] = CGPointMake(x, topYPoint);
    aPoint[1] = CGPointMake(self.frame.size.width-x, topYPoint);
    CGContextSetLineWidth(contextRef, 1.0);
    CGContextSetStrokeColorWithColor(contextRef, jzColor.CGColor);
    CGContextAddLines(contextRef, aPoint, 2);
    CGContextDrawPath(contextRef, kCGPathStroke);
    
    CGContextMoveToPoint(contextRef, x, zeroY+5);
    aPoint[0] = CGPointMake(x, zeroY+5);
    aPoint[1] = CGPointMake(self.frame.size.width-x, zeroY+5);
    CGContextSetLineWidth(contextRef, 1.0);
    CGContextSetStrokeColorWithColor(contextRef, jzColor.CGColor);
    CGContextAddLines(contextRef, aPoint, 2);
    CGContextDrawPath(contextRef, kCGPathStroke);
    contextRef = nil;
}

-(void)showXPoint:(float)X num:(int)num{

    NSDictionary *labArr = @{NSFontAttributeName:[UIFont systemFontOfSize:xyFont],NSForegroundColorAttributeName:jzColor};
    NSString *showStr= [self getXShowNum:num+1];
    if (showStr.length) {
        CGSize labSize = [showStr sizeWithAttributes:labArr];
        float labX = X-(labSize.width/2);
        [showStr drawInRect:CGRectMake(labX, zeroY+10, labSize.width, labSize.height) withAttributes:labArr];
    }
    showStr = nil;
}


-(NSString *)getXShowNum:(int)num{

    
    NSString *showStr;
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:myDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    switch (showType) {
        case ShowYear:
        {
            if (num%3) {
                showStr = nil;
            }else{
                if (num == 3 || num == 12) {
                    [dateFormatter setDateFormat:@"yyyy年MM月"];
                }else{
                    [dateFormatter setDateFormat:@"MM月"];
                }
                [adcomps setYear:0];
                [adcomps setMonth:num-self.dateArray.count];
                [adcomps setDay:0];
            }
        }
            break;
        case ShowMonth:
        {
            int remainderDays = self.dateArray.count%7; //余数出的天数
            if(num%7 == remainderDays||(!remainderDays && num ==1)){
                if (num<7  || (num/7 == 2)) {
                    [dateFormatter setDateFormat:@"MM月dd日"];
                }else{
                    [dateFormatter setDateFormat:@"dd"];
                }
                [adcomps setYear:0];
                [adcomps setMonth:0];
                [adcomps setDay:num-self.dateArray.count];
            }else{
                showStr = nil;
            }

        }
            break;
        case ShowWeek:
        {
            if (num == 1) {
                [dateFormatter setDateFormat:@"MM月dd日"];
            }else{
               [dateFormatter setDateFormat:@"dd"];
            }
            [adcomps setYear:0];
            [adcomps setMonth:0];
            [adcomps setDay:num-self.dateArray.count];
        }
            break;
        default:
            break;
    }
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:myDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
}

@end
