//
//  UtilsMacro.h
//  LQBaseKit
//
//  Created by L on 16/2/26.
//  Copyright © 2016年. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

//Log
#ifdef DEBUG
#define LQLog(...) NSLog(__VA_ARGS__)
#else
#define LQLog(...)
#endif

//GCD
#define GCD_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCD_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//Documents
#define DocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]

//APP
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define DeviceMode [[UIDevice currentDevice] model]

// DEVICE VERSION
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//下面三个宏为了兼容，以后开发注意不要用
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define IOS9 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0

//UI

#define ALERT(title, msg)   [[[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

#define ERROR(m,c,d) [NSError errorWithDomain:m code:c userInfo:d]

//Color
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

//Format
#define F(string, args...)                  [NSString stringWithFormat:string, args]

//Frame
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define StatusBarHeight                     20
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height

//NSUserDefaults
#define UserDefaults                        [NSUserDefaults standardUserDefaults]

#endif /* UtilsMacro_h */
