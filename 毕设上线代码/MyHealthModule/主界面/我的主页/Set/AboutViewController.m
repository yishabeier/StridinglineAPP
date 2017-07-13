//
//  AboutViewController.m
//  西邮图书馆
//
//  Created by bairong on 15/10/26.
//  Copyright © 2015年 bairong. All rights reserved.
//

#import "AboutViewController.h"
#import "Head.h"
#import "UIDevice+iphoneModel.h"
#define length 10
@interface AboutViewController ()

@end

@implementation AboutViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *view=(UIImageView *)[self.tabBarController.view viewWithTag:10];
    view.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImageView *view=(UIImageView *)[self.tabBarController.view viewWithTag:10];
    view.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initView];
}
-(void)initView{
    
    self.title=@"关于我们";
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WScreen/2-5*length,6*length,8*length,8*length)];
//    NSString *tempStr=[NSString stringWithFormat:@"%@58",BUNDLEPATH];
    headerImageView.image=[UIImage imageNamed:@"58.png"];
    [self.view addSubview:headerImageView];
    
    UILabel *notLabel=[[UILabel alloc] initWithFrame:CGRectMake(length-5,15*length,WScreen-2*length, 40)];
    notLabel.font=[UIFont fontWithName:@"Arial" size:17];
    notLabel.textAlignment=NSTextAlignmentCenter;
    notLabel.text=@"健步行  v1.0.1";
    notLabel.textColor=[UIColor colorWithRed:245/255.0 green:91/255.0 blue:86/255.0 alpha:1];
    [self.view addSubview:notLabel];
    
   
    
    UILabel *copyLabel=[[UILabel alloc] initWithFrame:CGRectMake(length,HScreen-14*length,WScreen-2*length, 20)];
    copyLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:14];
    copyLabel.textAlignment=NSTextAlignmentCenter;
    copyLabel.numberOfLines=0;
    copyLabel.text=@"Copyright © 西安邮电大学移动开发实验室iOS组 2017";
    copyLabel.textColor=[UIColor colorWithRed:245/255.0 green:91/255.0 blue:86/255.0 alpha:1];
    [self.view addSubview:copyLabel];
    
     IPhoneModel test=[UIDevice iPhonesModel];
    if (test==0||test==1) {
        copyLabel.frame=CGRectMake(length,HScreen-18*length,WScreen-2*length, 20);
        copyLabel.text=@"Copyright ©";
        
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(length,HScreen-14*length,WScreen-2*length, 20)];
        titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:14];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.numberOfLines=0;
        titleLabel.text=@"西安邮电大学移动开发实验室iOS组 2017";
        titleLabel.textColor=[UIColor colorWithRed:245/255.0 green:91/255.0 blue:86/255.0 alpha:1];
        [self.view addSubview:titleLabel];
        
    }

//    UILabel *summaryLabel=[[UILabel alloc] initWithFrame:CGRectMake(length,HScreen-10*length,WScreen-2*length, 20)];
//    summaryLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:12];
//    summaryLabel.textAlignment=NSTextAlignmentCenter;
//    summaryLabel.text=@"XI’AN  UNIVERSITY OF POSTS & TELECOMMUNICATIONS  LIBRARY";
//    summaryLabel.textColor=[UIColor colorWithRed:245/255.0 green:91/255.0 blue:86/255.0 alpha:1];
//    [self.view addSubview:summaryLabel];
//
    
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
