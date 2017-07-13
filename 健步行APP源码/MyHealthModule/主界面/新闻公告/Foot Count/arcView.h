//
//  arcView.h
//  圆弧进度条显示
//
//  Created by yhj on 15/12/10.
//  Copyright © 2015年 QQ:1787354782. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APPW [[UIScreen mainScreen] bounds].size.width

#define APPH [[UIScreen mainScreen] bounds].size.height

@interface arcView : UIView

@property(nonatomic,assign)int num;

@property(nonatomic,strong)UILabel *numLabel;

@property(nonatomic,strong)NSTimer *timer;

@end
