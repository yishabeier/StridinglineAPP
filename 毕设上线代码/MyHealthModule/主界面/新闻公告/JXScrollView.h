//
//  JXScrollView.h
//  JXScrollView
//
//  Created by JackXu on 16/4/17.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JXScrollViewPageControlPosition){
    JXScrollViewPageControlPositionLeft,
    JXScrollViewPageControlPositionCenter,
    JXScrollViewPageControlPositionRight
};

@class JXScrollView;

@protocol JXScrollViewDataSource <NSObject>

@required

-(NSInteger)numberOfItemInScrollView:(JXScrollView *)scrollView;

@optional

-(NSURL*)scrollView:(JXScrollView *)scrollView urlForItemAtIndex:(NSInteger)index;
-(UIImage*)scrollView:(JXScrollView *)scrollView imageForItemAtIndex:(NSInteger)index;
-(UIImage*)scrollView:(JXScrollView *)scrollView placeholderImageForIndex:(NSInteger)index;

@end

@protocol JXScrollViewDelegate <NSObject>

@optional

-(void)scrollView:(JXScrollView *)scrollView didClickAtIndex:(NSInteger)index;

@end

@interface JXScrollView : UIView

@property (nonatomic, assign) BOOL hideIndicator;//设置隐藏加载菊花，默认显示
@property (nonatomic, assign) double timeInterval;//设置播放时间间隔,默认3s
@property (nonatomic, strong) UIColor *pageControlTintColor;//pageControl的颜色
@property (nonatomic, strong) UIColor *pageIndicatorSelectedTintColor;//pageControl选中颜色
@property (nonatomic, assign) JXScrollViewPageControlPosition pageControlPosition;//pageControl的位置
@property (nonatomic, weak) id <JXScrollViewDataSource> dataSource;
@property (nonatomic, weak) id <JXScrollViewDelegate> delegate;


-(void)start;

@end
