//
//  AppDelegate.m
//  MyHealthModule
//
//  Created by L on 16/2/26.
//  Copyright © 2016年. All rights reserved.
//

#import "AppDelegate.h"
#import "MHMHomePageController.h"
#import "UIImage+Color.h"
#import "UtilsMacro.h"
#import "BottmViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    MHMHomePageController *vc = [[MHMHomePageController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];
//    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithSolidColor:[UIColor whiteColor] size:CGSizeMake(10, 10)]
//                                       forBarMetrics:UIBarMetricsDefault];
//    [UINavigationBar appearance].titleTextAttributes = @{
//                                                         NSForegroundColorAttributeName: [UIColor whiteColor],
//                                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
//                                                         };
//    return YES;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    [self.window makeKeyAndVisible];
    
    
    self.mainTabBarController = [[BaseTabBarController alloc] init];
    
    //LeftViewController *leftVC = [[LeftViewController alloc] init];
    
    BottmViewController *bottomVC =[[BottmViewController alloc]init];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:bottomVC andMainView:self.mainTabBarController];
    
    self.window.rootViewController = self.LeftSlideVC;
    
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
