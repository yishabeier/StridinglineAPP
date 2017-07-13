//
//  JXScrollView.m
//  JXScrollView
//
//  Created by JackXu on 16/4/17.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "JXScrollView.h"
#import "UIImageView+WebCache.h"

@interface JXScrollView()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation JXScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){{0,0},frame.size}];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame)-32, frame.size.width, 37)];
        _timeInterval = 3.0;
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
    }
    return self;
}

-(void)setPageControlTintColor:(UIColor *)tintColor{
    _pageControl.pageIndicatorTintColor = tintColor;
//    [_pageControl setTintColor:tintColor];
}

-(void)setPageIndicatorSelectedTintColor:(UIColor *)tintColor{
    _pageControl.currentPageIndicatorTintColor = tintColor;
}

-(void)setPageControlPosition:(JXScrollViewPageControlPosition)pageControlPosition{
    NSInteger count = [self.dataSource numberOfItemInScrollView:self];
    CGSize pointSize = [_pageControl sizeForNumberOfPages:count];
    
    switch (pageControlPosition) {
        case JXScrollViewPageControlPositionLeft:{
            [_pageControl setFrame:CGRectMake(10, _pageControl.frame.origin.y, pointSize.width, _pageControl.frame.size.height)];
        }break;
        case JXScrollViewPageControlPositionCenter:{
            [_pageControl setFrame:CGRectMake(0, _pageControl.frame.origin.y, self.frame.size.width, _pageControl.frame.size.height)];
        }break;
        case JXScrollViewPageControlPositionRight:{
            NSLog(@"%f",self.frame.size.width - pointSize.width);
            [_pageControl setFrame:CGRectMake( (_pageControl.frame.size.width - pointSize.width)*0.5-10, _pageControl.frame.origin.y, _pageControl.frame.size.width, _pageControl.frame.size.height)];
        }break;
        default:
            break;
    }
}

//初始化广告轮播
-(void)start{
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat imageW = _scrollView.frame.size.width;
    CGFloat imageH = _scrollView.frame.size.height;
    // 图片的Y
    CGFloat imageY = 0;
    // 图片总数
    NSInteger totalCount = [self.dataSource numberOfItemInScrollView:self];
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 图片X
        CGFloat imageX = i * imageW;
        // 设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        if ([self.dataSource respondsToSelector:@selector(scrollView:urlForItemAtIndex:)]) {
            
            if (!_hideIndicator) {
                [self createActivityView:imageView];
            }
            
            UIImage *image = nil;
            if ([self.dataSource respondsToSelector:@selector(scrollView:placeholderImageForIndex:)]) {
                image = [self.dataSource scrollView:self placeholderImageForIndex:i];
            }
            NSURL *imageUrl = [self.dataSource scrollView:self urlForItemAtIndex:i];
            [imageView sd_setImageWithURL:imageUrl placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                [self stopActivityView:imageView];
            }];
            
        }else{
            [imageView setImage:[self.dataSource scrollView:self imageForItemAtIndex:i]];
        }
        
        [_scrollView addSubview:imageView];
        UIButton  *imageButton=[[UIButton alloc] init];
        [imageButton addTarget:self action:@selector(goToAdvertDetail) forControlEvents:UIControlEventTouchUpInside];
        imageButton.frame = CGRectMake(imageX, imageY, imageW, imageH);
        [_scrollView addSubview:imageButton];
    }
    
    // 设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
    //不允许在垂直方向上进行滚动
    _scrollView.contentSize = CGSizeMake(contentW, 0);
    // 3.设置分页
    _scrollView.pagingEnabled = YES;
    // 4.监听scrollview的滚动
    _scrollView.delegate = self;
    _pageControl.numberOfPages = totalCount;
    [self addTimer];
}

//下一张图片
- (void)nextImage  {
    int page = (int)self.pageControl.currentPage;
    NSInteger imageCount = [self.dataSource numberOfItemInScrollView:self];
    if (page == imageCount-1) page = 0;
    else page++;
    // 滚动scrollview
    [UIView animateWithDuration:.5f animations:^{
        CGFloat x = page * self.scrollView.frame.size.width;
        self.scrollView.contentOffset = CGPointMake(x, 0);
    }];
}
// scrollview滚动时回调
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollviewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) / scrollviewW;
    self.pageControl.currentPage = page;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
// scrollview拖拽时回调
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //关闭定时器
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{ // 开启定时器
    [self addTimer];
}
//开启定时器
-(void)addTimer{
    if (nil == _timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        //防止timer被阻塞
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

//关闭定时器
- (void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}

//创建风火轮
- (void)createActivityView:(UIImageView*)img
{
    static int size = 40;
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(img.frame.size.width/2 - size/2, img.frame.size.height/2 - size/2, size, size);
    [img addSubview:activityView];
    [activityView startAnimating];
}

//移除风火轮
- (void)stopActivityView:(UIImageView*)img;{
    if (img.image != nil)
        for (UIView *view in [img subviews]) {//读出UIButton里的所有控件，再选择UIActivityIndicatorView进行更改
            if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
                [view removeFromSuperview];//把风火轮UIActivityIndicatorView移除
            }
        }
}

//点击某一页
-(void)goToAdvertDetail{
    if ([self.delegate respondsToSelector:@selector(scrollView:didClickAtIndex:)]) {
        [self.delegate scrollView:self didClickAtIndex:_pageControl.currentPage];
    }

}

@end
