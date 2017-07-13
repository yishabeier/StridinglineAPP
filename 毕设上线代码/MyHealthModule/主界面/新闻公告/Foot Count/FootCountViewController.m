//
//  FootCountViewController.m
//  LeftSlide
//
//  Created by L on 2017/4/23.
//  Copyright © 2017年 zws. All rights reserved.
//

#import "FootCountViewController.h"
#import "Masonry.h"
#import "arcView.h"
#import <CoreMotion/CoreMotion.h>

@interface FootCountViewController ()<UIScrollViewDelegate>
{
    
    arcView *view1;
    
    UIButton *btn2;
    UIButton *_btn3;

    // 计步器实例化对象
    CMPedometer  *pedometer;
    // 计步器走的步数；
    int i;
    int v;
    UIScrollView  *indicators;
    NSMutableArray *arry1;
    // 剪切的当前时间；
    NSString *rday;
    float k;
    UILabel *footlaber;
}
@end

@implementation FootCountViewController
-(void)viewWillDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    indicators =  [[UIScrollView alloc] init];
    indicators.delegate = self;
    indicators.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:indicators];
    [indicators mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
        make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
    }];
    indicators.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    view1  =[[arcView alloc]initWithFrame:CGRectMake(0,0, APPW-40,APPW-30)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.num = v;
    [indicators addSubview:view1];
    
    UIImageView *footview = [[UIImageView alloc] init];
    footview.image = [UIImage imageNamed:@"脚丫0"];
    [indicators addSubview:footview];
    [footview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indicators.mas_top).offset(APPW-30);
        make.centerX.equalTo(indicators.mas_centerX).offset(-30);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:35.0/255.0 blue:42/255.0 alpha:1];
    btn2.layer.cornerRadius=15;
    btn2.layer.masksToBounds=YES;
    btn2.selected = YES;
    [btn2 setTitle:@"开始" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [indicators  addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indicators.mas_top).offset(APPW+30);
        make.left.equalTo(indicators.mas_left).offset(20);
        make.width.equalTo(@(130));
        make.height.equalTo(@(50));
    }];
    
    
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:35.0/255.0 blue:42/255.0 alpha:1];
    _btn3.layer.cornerRadius=15;
    _btn3.layer.masksToBounds=YES;
    [_btn3 setTitle:@"停止" forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn3 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [indicators  addSubview:_btn3];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indicators.mas_top).offset(APPW+30);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.width.equalTo(@(130));
        make.height.equalTo(@(50));
    }];
    
    
    UILabel *hot = [[UILabel alloc] init];
    hot.text =@"最近一周热量消耗";
    hot.font = [UIFont systemFontOfSize:12];
    [indicators addSubview:hot];
    [hot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indicators.mas_top).offset(APPW+90);
        make.left.equalTo(indicators.mas_left).offset(30);
        make.width.equalTo(@(120));
        make.height.equalTo(@(30));
    }];
    
    UILabel *unit = [[UILabel alloc] init];
    unit.text =@"单位 ： 卡 (Kal)";
    unit.font = [UIFont systemFontOfSize:12];
    [indicators addSubview:unit];
    [unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(indicators.mas_top).offset(APPW+90);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.width.equalTo(@(120));
        make.height.equalTo(@(30));
    }];
    
//    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnBack.frame =CGRectMake(20, 30, 20, 15);
//    [btnBack setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
//    [btnBack addTarget:self action:@selector(goToBack) forControlEvents:UIControlEventTouchUpInside];
//    [indicators  addSubview:btnBack];
//
    
    
    
}
//-(void)goToBack{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
-(void)click1{
    
    if (btn2.selected == YES) {
        
        NSLog(@"开始计步了");
        btn2.backgroundColor=[UIColor grayColor];
        
        if ([CMPedometer isStepCountingAvailable]) {
            
            pedometer=[[CMPedometer alloc]init];
            
            [pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                
                CMPedometerData *data=(CMPedometerData *)pedometerData;
                
                NSString *str1 = [NSString stringWithFormat:@"%@",data.numberOfSteps];
                
                i = [str1 intValue];
                v = i+v;
                view1.num = v;
                NSLog(@"%d",v);
                NSLog(@"用户行走了 %d 步",v);
            }];
            
        }
    }
    btn2.selected =NO;
    _btn3.backgroundColor=[UIColor colorWithRed:247.0/255.0 green:35.0/255.0 blue:42/255.0 alpha:1];
    _btn3.selected=YES;
    
    
}
-(void)click2{
    
    k  = v*0.05/1000;
    footlaber.text = [NSString stringWithFormat:@"您走了%.2f公里",k];
    [pedometer stopPedometerEventUpdates];
    NSString *step1 = [NSString stringWithFormat:@"%d",v];
    
    _btn3.selected = YES;
    btn2.backgroundColor=[UIColor colorWithRed:247.0/255.0 green:35.0/255.0 blue:42/255.0 alpha:1];
    btn2.selected=YES;
    _btn3.backgroundColor=[UIColor grayColor];
    NSLog(@"停止计步了------%@",step1);
    _btn3.selected=NO;
}
@end
