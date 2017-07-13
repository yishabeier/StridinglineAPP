//
//  arcView.m
//  圆弧进度条显示
//
//  Created by yhj on 15/12/10.
//  Copyright © 2015年 QQ:1787354782. All rights reserved.
//

#import "arcView.h"

@implementation arcView

-(void)drawRect:(CGRect)rect
{
    // 仪表盘底部
    drawHu1();
    [self drawHu3];
    // 仪表盘进度
    [self drawHu2];
}

-(void)drawHu2
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 20);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换
    CGFloat length[] = {3,3};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[[UIColor alloc]initWithRed:247/255.0 green:35/255.0 blue:42.0/255.0 alpha:1] set];
    
    //2.设置路径
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(numberChange:) name:@"number" object:nil];
    
    CGFloat end = 1.5*M_PI +(2*M_PI*_num/10000);
    CGContextAddArc(ctx, APPW/2, APPW/2, 80, 1.5*M_PI , end, 0);
    
    //3.绘制
    CGContextStrokePath(ctx);
}
-(void)drawHu3
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 20);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换
    CGFloat length[] = {3,3};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
   [[[UIColor alloc]initWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1] set];
    
    
    
       CGContextAddArc(ctx, APPW/2, APPW/2, 80, 1.5*M_PI , 3.5*M_PI, 0);
    
    //3.绘制
    CGContextStrokePath(ctx);
}


-(void)numberChange:(NSNotification *)text
{
    _num =[text.userInfo[@"num"] intValue];
    [self setNeedsDisplay];
}

-(void)setNum:(int)num
{
    _num =num;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 120, 30)];
        lab2.text =@"单位：步（step）";
        lab2.font = [UIFont systemFontOfSize:13];
        
        
        UILabel *la1 = [[UILabel alloc]initWithFrame:CGRectMake((APPW-120)/2, (APPW-80)/2, 120, 30)];
        la1.text = @"步数";
        la1.textAlignment = NSTextAlignmentCenter;
        
        
        
        
        _numLabel=[[UILabel alloc]initWithFrame:CGRectMake((APPW-120)/2, (APPW-80)/2+30, 120, 30)];
               _numLabel.textAlignment =NSTextAlignmentCenter;
        _numLabel.textColor=[UIColor blackColor];
        _numLabel.text = @"0步";
        _numLabel.font=[UIFont systemFontOfSize:18];
        if (!_timer) {
            _timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(change) userInfo:nil repeats:YES];
            
        }
        
        UILabel *la3 = [[UILabel alloc]initWithFrame:CGRectMake((APPW-120)/2, (APPW-80)/2+60, 120, 30)];
        
        
        la3.text = @"每日目标5000步";
        la3.textAlignment = NSTextAlignmentCenter;
        la3.font=[UIFont systemFontOfSize:12];
        
        
        [self addSubview:lab2];
        [self addSubview:_numLabel];
        [self addSubview:la1];
        [self addSubview:la3];
    }
    return self;
}

-(void)change
{    
//    _num +=1;
//    if (_num >10000) {
//        _num = 0;
//    }
    _numLabel.text =[NSString stringWithFormat:@"%d步",_num];
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:_numLabel.text,@"num", nil];
    
    // 创建通知
    NSNotification *noti =[NSNotification notificationWithName:@"number" object:nil userInfo:dic];
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotification:noti];
}

void drawHu1()
{
    // 1 获取上下文
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    // 1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 2);
    // 1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapRound);
    
    // 1.3 虚实切换， 绘制10 跳过5
   
    
    // 1.4 设置颜色
    [[[UIColor alloc]initWithRed:247/255.0 green:35.0/255.0 blue:42.0/255.0 alpha:1] set];
    
    // 2 设置路径
    CGContextAddArc(ctx,APPW/2,APPW/2,120,-M_PI,M_PI,0);
    
    // 3 绘制
    CGContextStrokePath(ctx);
}

@end
