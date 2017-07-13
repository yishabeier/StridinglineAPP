//
//  ShowStepDataView.m
//  LeftSlide
//
//  Created by L on 17/2/20.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "SLShowStepDataView.h"
#import "SLShowStepView.h"
#import "SLHistogramView.h"
#import "Head.h"
@interface SLShowStepDataView ()

@property(nonatomic,strong)UIScrollView *bgSView;

@end

@implementation SLShowStepDataView

- (instancetype)initWithFrame:(CGRect)frame yearArray:(NSArray *)yearArray monthArray:(NSArray *)monthArray  weekArray:(NSArray *)weekArray;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UISegmentedControl *segMent = [[UISegmentedControl alloc] initWithItems:@[@"周",@"月",@"年"]];
        segMent.frame = CGRectMake(0, 0, self.frame.size.width,35);
        [segMent addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        segMent.tintColor = [UIColor orangeColor];
        [self addSubview:segMent];
        
        _bgSView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(segMent.frame)+3, WScreen-10,200 )];
        NSLog(@"segment.frarme =%f",CGRectGetMaxY(segMent.frame)); //35
        NSLog(@"self.frame.sise.width= %f",self.frame.size.width); //355
        NSLog(@"self.frame.size.height=%f",self.frame.size.height); //200
        
        _bgSView.pagingEnabled = YES;
        _bgSView.contentSize = CGSizeMake(self.frame.size.width *3, self.frame.size.height);
        _bgSView.layer.cornerRadius = 5;
        _bgSView.layer.masksToBounds = YES;
        [self setScrollBgColor:_bgSView];
        [self addSubview:_bgSView];
        
        NSArray *showArr = @[weekArray,monthArray,yearArray];
        for (int i = 0; i<showArr.count; i++) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSInteger dayAverage=[defaults integerForKey:@"dayAverage"];
            NSLog(@"dayAverage=====%ld",dayAverage);
            NSString *footCount=[defaults objectForKey:@"footCount"];
            NSInteger  footCount1=[footCount intValue];
            SLShowStepView *stepView = [[SLShowStepView alloc] initWithFrame:CGRectMake(20+(_bgSView.frame.size.width*i), 10, _bgSView.frame.size.width-40, 50) currentStep:footCount1];
            NSLog(@"_bgSView.frame.size.widht =%f",_bgSView.frame.size.width);
//            stepView.averageStepNum = dayAverage+i;
            stepView.averageStepNum = dayAverage;

            [_bgSView addSubview:stepView];
            
            SLHistogramView *show = [[SLHistogramView alloc] initWithFrame:CGRectMake(_bgSView.frame.size.width*i, 60, _bgSView.frame.size.width, _bgSView.frame.size.height-60) dateArray:showArr[i] Xtype:2-i leftX:20];
            [_bgSView addSubview:show];
        }
        showArr = nil;
        segMent.selectedSegmentIndex = 0;
    }
    return self;
}

-(void)setScrollBgColor:(UIScrollView *)scrollV{
    //初始化渐变层
    UIView *sendV = [[UIView alloc] initWithFrame:scrollV.frame];
    sendV.layer.cornerRadius = 5;
    sendV.layer.masksToBounds = YES;
    [self addSubview:sendV];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = sendV.bounds;
    [sendV.layer addSublayer:gradientLayer];
    
    //设置渐变颜色方向
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //设定颜色组
    gradientLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
}

-(void)valueChange:(UISegmentedControl *)seg{
    
    [self.bgSView setContentOffset:CGPointMake(self.bgSView.frame.size.width*seg.selectedSegmentIndex, 0) animated:NO];
    
}

@end
