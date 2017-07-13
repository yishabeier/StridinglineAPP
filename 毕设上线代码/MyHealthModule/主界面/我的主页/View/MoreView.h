//
//  MoreView.h
//  LeftSlide
//
//  Created by bairong on 16/10/8.
//  Copyright © 2016年 bairong All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreViewdelegate <NSObject>

@required
- (void)moreViewPushVCWithTag:(NSInteger)tag;

@end

@interface MoreView : UIView

@property (nonatomic,assign) id<MoreViewdelegate> delegate;

+ (instancetype)sharedSingleton;
+ (instancetype)views;

@end
