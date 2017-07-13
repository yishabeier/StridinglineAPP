//
//  AppDelegate.h
//  MyHealthModule
//
//  Created by L on 16/2/26.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "BaseTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;//侧滑视图VC
@property (strong, nonatomic) BaseTabBarController *mainTabBarController;//主视图TabBarVC

@end

