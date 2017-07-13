//
//  MoreView.m
//  LeftSlide
//
//  Created by bairong on 16/10/8.
//  Copyright © 2016年 bairong All rights reserved.
//

#import "MoreView.h"
#import "setViewController.h"
@implementation MoreView

static MoreView *shareSingleton;


+ (instancetype)sharedSingleton{
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^ {
        
        shareSingleton = [MoreView views] ;
        
    } );
    return shareSingleton;
}

    
+ (instancetype)views{
    return [[NSBundle mainBundle] loadNibNamed:@"MoreView" owner:nil options:nil].lastObject;
}
/**
 20001 - 首页
 20002 - 购物车
 20003 - 我的
 20004 - 消息中心
 */
//- (IBAction)goToVC:(UIButton *)sender {
//    if ([self.delegate respondsToSelector:@selector(moreViewPushVCWithTag:)]) {
//        [self.delegate moreViewPushVCWithTag:sender.tag];
//    }
//}
- (IBAction)goMyset:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(moreViewPushVCWithTag:)]) {
      [self.delegate moreViewPushVCWithTag:sender.tag];
    }

}

@end
