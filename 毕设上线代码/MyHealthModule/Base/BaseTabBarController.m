//
//  BaseTabBarController.m
//  LeftSlide
//
//  Created by L on 16/4/5.
//  Copyright © 2016年 bairong. All rights reserved.
//

#import "BaseTabBarController.h"

#import "BaseNavController.h"
#import "MainPageViewController.h"
//#import "HealthViewController.h"
#import "HistoryViewController.h"
#import "ToolsViewController.h"
#import "MHMHomePageController.h"


@interface BaseTabBarController ()
@property (nonatomic, strong) MainPageViewController *minePageVC;
@property (nonatomic, strong) MHMHomePageController   *healthVC;
@property (nonatomic, strong) HistoryViewController  *historyVC;
@property (nonatomic, strong) ToolsViewController    *newsVC;

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建子控制器
    [self _createSubCtrls];
    
}

- (void)_createSubCtrls{
    //修改下面文字大小和颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
//    _minePageVC = [[MainPageViewController alloc]initWithNibName:@"MainPageViewController" bundle:nil];
    _minePageVC = [[MainPageViewController alloc]init];

    _minePageVC.tabBarItem.image = [UIImage imageNamed:@"应用"];
    _minePageVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"应用选中" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _minePageVC.tabBarItem.title=@"我的主页";
    
     self.healthVC = [[MHMHomePageController  alloc]init];
    _healthVC.tabBarItem.image = [UIImage imageNamed:@"通讯录"];
    _healthVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"通讯录选中" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _healthVC.tabBarItem.title = @"健康数据";
    
    self.historyVC =[[HistoryViewController alloc]initWithNibName:@"HistoryViewController" bundle:nil];
    _historyVC.tabBarItem.image = [UIImage imageNamed:@"消息"];
    _historyVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"消息选中" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _historyVC.tabBarItem.title = @"健身历史";
    
    self.newsVC =[[ToolsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
    _newsVC.tabBarItem.image=[UIImage imageNamed:@"我"];
    _newsVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"我选中" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _newsVC.tabBarItem.title = @"健康专辑";
    
    //创建数组
    NSArray *viewCtrls = @[_minePageVC,_healthVC,_historyVC,_newsVC];
    
    //创建可变数组,存储导航控制器
    NSMutableArray *navs = [NSMutableArray arrayWithCapacity:viewCtrls.count];
    
    //创建二级控制器导航控制器
    for (UIViewController *ctrl in viewCtrls) {
        BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:ctrl];
        
        //将导航控制器加入到数组中
        [navs addObject:nav];
    }
    
    //将导航控制器交给标签控制器管理
    self.viewControllers = navs;
    
}




@end
