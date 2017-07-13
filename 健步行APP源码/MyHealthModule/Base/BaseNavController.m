//
//  BaseNavController.m
//  LeftSlide
//
//  Created by L on 16/4/5.
//  Copyright © 2016年 bairong. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBg3"]
//                            forBarPosition:UIBarPositionAny
//                                barMetrics:UIBarMetricsDefault];
    self.navigationBar.titleTextAttributes =@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent =NO; //半透明效果
    self.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    
    
   

}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
