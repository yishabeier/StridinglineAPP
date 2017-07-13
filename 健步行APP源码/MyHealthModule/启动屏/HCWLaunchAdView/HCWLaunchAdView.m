//
//  HCWLaunchAdView.m
//  Example
//
//  Created by HCW_BOOU on 2017/3/15.
//  Copyright © 2017年 HCW. All rights reserved.
//

#import "HCWLaunchAdView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@implementation HCWLaunchAdViewCell
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _imageView;
}
@end

@interface HCWLaunchAdView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation HCWLaunchAdView

#pragma mark - Class Methods

+ (instancetype)showAdWithURLs:(NSArray<NSString *> *)urls
              placeholderImage:(UIImage *)placeholderImage
         didSelectedIndexBlock:(HCWLaunchAdViewBlock)block
{
    return [self showAdWithURLs:urls
                      dwellTime:1
            placeholderImage:placeholderImage
          didSelectedIndexBlock:block];
}

+ (instancetype)showAdWithURLs:(NSArray<NSString *> *)urls
                     dwellTime:(NSInteger)dwellTime
              placeholderImage:(UIImage *)placeholderImage
         didSelectedIndexBlock:(HCWLaunchAdViewBlock)block
{
    return [self showAdWithURLs:urls
                      dwellTime:dwellTime
                     showInView:[self defaultInView]
                  showAnimation:NO
                  hideAnimation:YES
            placeholderImage:placeholderImage
          didSelectedIndexBlock:block];
}

+ (instancetype)showAdWithURLs:(NSArray<NSString *> *)urls
                     dwellTime:(NSInteger)dwellTime
                    showInView:(UIView *)showInView
                 showAnimation:(BOOL)showAnimation
                 hideAnimation:(BOOL)hideAnimation
              placeholderImage:(UIImage *)placeholderImage
         didSelectedIndexBlock:(HCWLaunchAdViewBlock)block
{
    HCWLaunchAdView *view = [[HCWLaunchAdView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.urls = urls;
    view.dwellTime = dwellTime;
    view.showInView = showInView?:[self defaultInView];
    view.showAnimation = showAnimation;
    view.hideAnimation = hideAnimation;
    view.placeholderImage = placeholderImage;
    view.block = block;
    [showInView addSubview:view];
    [showInView bringSubviewToFront:view];
    [view show];
    return view;
}

#pragma mark - Object Methods

- (void)show
{
    self.alpha = 0.0f;
    if (self.showAnimation) {
        [UIView animateWithDuration:0.30 animations:^{
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [self setupTimer];
        }];
    } else {
        self.alpha = 1.0f;
        [self setupTimer];
    }
}

- (void)hide
{
    if (self.hideAnimation) {
        [UIView animateWithDuration:0.30 animations:^{
            self.alpha = 0.02f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self invalidateTimer];
        }];
    } else {
        self.alpha = 0.0f;
        [self removeFromSuperview];
        [self invalidateTimer];
    }
}

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageControl.numberOfPages = self.urls.count;
    self.pageControl.hidden = self.urls.count < 2;
    self.collectionView.scrollEnabled = self.urls.count > 1;
}

#pragma mark - Private Methods

- (void)setupSubviews
{
    // collection view
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[HCWLaunchAdViewCell class] forCellWithReuseIdentifier:@"HCWLaunchAdViewCell"];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    self.collectionView = mainView;
    
    // time button
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeButton.layer.masksToBounds = YES;
    timeButton.layer.cornerRadius = 15;
    timeButton.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    timeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [timeButton setTitleColor:[UIColor whiteColor] forState:0];
    [self addSubview:timeButton];
    [timeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    self.timeButton = timeButton;
    
    // page control
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    typeof(self) __weak weakSelf = self;
    
    // time button
    [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(30);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(65, 30));
    }];
    
    // collection view
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // page control
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-20);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.height.equalTo(@30);
    }];
}

- (int)currentIndex
{
    int index = 0;
    index = self.collectionView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    return index;
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.urls.count;
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.dwellTime target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:self.urls.count*self.dwellTime];
    
    // 倒计时
    __block int timeout = (int)self.urls.count*(int)self.dwellTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __block dispatch_source_t btimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(btimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(btimer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(btimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.timeButton setTitle:@"跳过" forState:UIControlStateNormal];
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.timeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(btimer);
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)automaticScroll
{
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(int)targetIndex
{
    if (self.urls.count < targetIndex+1) {
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

+ (UIView *)defaultInView
{
    return [UIApplication sharedApplication].delegate.window.rootViewController.view;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.urls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCWLaunchAdViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HCWLaunchAdViewCell" forIndexPath:indexPath];
    
    NSString *imagePath = self.urls[indexPath.row];
    
    if ([imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
        } else {
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                [UIImage imageWithContentsOfFile:imagePath];
            }
            cell.imageView.image = image;
        }
    } else if ([imagePath isKindOfClass:[UIImage class]]) {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.block) {
        self.block(indexPath.row);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.urls.count) return;
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.currentPage = indexOnPageControl;
}

@end
