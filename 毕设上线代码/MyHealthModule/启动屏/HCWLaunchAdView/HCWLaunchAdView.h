//
//  HCWLaunchAdView.h
//  Example
//
//  Created by HCW_BOOU on 2017/3/15.
//  Copyright © 2017年 HCW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HCWLaunchAdViewBlock)(NSInteger tapIndex);

@interface HCWLaunchAdViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@end

@interface HCWLaunchAdView : UIView

#pragma mark - Class Methods

/**
 *  创建一个广告页显示出来
 *  @param urls 显示广告图片地址
 *  @param placeholderImage 默认图片
 *  @param block 点击广告回调
 */
+ (instancetype)showAdWithURLs:(NSArray<NSString *> *)urls
              placeholderImage:(UIImage *)placeholderImage
         didSelectedIndexBlock:(HCWLaunchAdViewBlock)block;

/**
 *  创建一个广告页显示出来
 *  @param urls 显示广告图片地址
 *  @param dwellTime 每张广告的停留时间
 *  @param placeholderImage 默认图片
 *  @param block 点击广告回调
 */
+ (instancetype)showAdWithURLs:(NSArray<NSString *> *)urls
                     dwellTime:(NSInteger)dwellTime
              placeholderImage:(UIImage *)placeholderImage
         didSelectedIndexBlock:(HCWLaunchAdViewBlock)block;

/**
 *  创建一个广告页显示出来
 *  @param urls 显示广告图片地址
 *  @param dwellTime 每张广告的停留时间
 *  @param showInView super view
 *  @param showAnimation 显示是否需要动画
 *  @param hideAnimation 隐藏是否需要动画
 *  @param placeholderImage 默认图片
 *  @param block 点击广告回调
 */
+ (instancetype)showAdWithURLs:(NSArray<NSString *> *)urls
                     dwellTime:(NSInteger)dwellTime
                    showInView:(UIView *)showInView
                 showAnimation:(BOOL)showAnimation
                 hideAnimation:(BOOL)hideAnimation
              placeholderImage:(UIImage *)placeholderImage
         didSelectedIndexBlock:(HCWLaunchAdViewBlock)block;

#pragma mark - Object Propertys

@property (nonatomic, copy) HCWLaunchAdViewBlock block; ///< 点击广告回调
@property (nonatomic, assign) NSInteger dwellTime;      ///< 每张广告停留时间，default is 1s
@property (nonatomic, strong) UIView *showInView;       ///< super view，default is keyWindow
@property (nonatomic, assign) BOOL showAnimation;       ///< 显示是否需要动画，default is NO
@property (nonatomic, assign) BOOL hideAnimation;       ///< 隐藏是否需要动画，default is YES
@property (nonatomic, strong) NSArray<NSString *> *urls;///< 显示广告图片地址数组
@property (nonatomic, strong) UIImage *placeholderImage;///< 默认图片

@end
