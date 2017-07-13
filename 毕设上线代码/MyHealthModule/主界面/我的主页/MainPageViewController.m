//
//  MainPageViewController.m
//  MyHealth
//
//  Created by L on 2017/4/6.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "MainPageViewController.h"
#import "AppDelegate.h"
#import "UIImage+GIF.h"
#import "Head.h"
#import "SLShowStepDataView.h"
#import "MoreView.h"
#import "Head.h"
#import "HCWLaunchAdView.h"
#import "LoginViewController.h"
#import "MHMHealthModel.h"
#import "AddFootViewController.h"
#import "FootCountViewController.h"
#import "LoginViewController.h"
@interface MainPageViewController ()<MoreViewdelegate>
{
    NSString        *_firstValue;
    UIImageView     *_backImageV;
    BOOL            _firstLoad;
    BOOL            _atTheTopBool;
    BOOL            _showZheXianAnimation;
    BOOL             isMore;
    
}
@property (nonatomic, assign)NSInteger timeType;
@property (strong, nonatomic) UIView *backView;

@end
@implementation MainPageViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"newNaBarBackgroundImage.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    
    
    [self performSelector:@selector(setBarBackGIFFF) withObject:nil afterDelay:2.3];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    if ([_firstValue isEqualToString:@"1"]) {
        [self setNabarBackgroudImage:self.timeType];
    }
    _firstValue =@"1";
    [self setBarBacgroudImages:[self getTimeType]];//设置bar背景
    [self setHeadImage];
}

-(void)setBarBackGIFFF{
    [self setBarBackGIF:@"1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.title=@"我的主页";
        [self startUIScreen];
        self.timeType=0;
        _firstLoad    = YES;
        _atTheTopBool=NO;
        _showZheXianAnimation=NO;
        _firstValue =@"0";
        isMore =NO; //是否显示MoreView
        [self setSelfView];
        [self initBarBtnItem];
        [self initStDataView];
    
}
- (void)buttonAction {
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}


#pragma mark  - 懒加载
- (UIView *)backView
{
    if (!_backView) {
                _backView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
                _backView.hidden = 0;
                _backView.backgroundColor = [UIColor clearColor];
                UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBackView)];
                [_backView addGestureRecognizer:recognizer];
                MoreView *moreView = [MoreView sharedSingleton];
                moreView.delegate = self;
                moreView.center = CGPointMake(WScreen - moreView.bounds.size.width * 0.5 - 10, moreView.bounds.size.height * 0.5 + 54);
                [_backView addSubview:moreView];
    }
    return _backView;
}

-(void)initStDataView{
    
    
    
    SLShowStepDataView *data = [[SLShowStepDataView alloc] initWithFrame:CGRectMake(5, 215, WScreen-10,200) yearArray:@[@"0",@"0",@"0",@"0",@"325",@"12280",@"0",@"54560",@"31000",@"25500",@"14758",@"70000"] monthArray:@[@"2885",@"1664",@"3234",@"2843",@"2799",@"2356",@"4038",@"546",@"714",@"2097",@"3023",@"3911",@"1393",@"1697",@"3095",@"2233",@"2724",@"2935",@"2596",@"872",@"1594",@"3429",@"2471",@"2559",@"2702",@"2273",@"1479",@"2100",@"2477",@"21"]weekArray:@[@"2885",@"3780",@"1664",@"3234",@"2843",@"2799",@"6"]];
    
    NSArray *yearArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"yearArray"];
    NSLog(@"********************%@",yearArray);
   
   
//    yearArray =_model.stepCount;
//    SLShowStepDataView *data=[[SLShowStepDataView alloc]initWithFrame:CGRectMake(5, 215, WScreen-10,200)  yearArray: monthArray:<#(NSArray *)#> weekArray:<#(NSArray *)#>]
         [self.view addSubview:data];
}
-(void)startUIScreen{
    NSArray *imageURLs = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496139366279&di=db16f46e50279678140e13b3397bfe86&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201501%2F29%2F20150129225504_mcBsE.jpeg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489575437372&di=960ea594392b795f13d964f62bb56ac0&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201508%2F02%2F20150802105225_tQjSm.thumb.700_0.jpeg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489575437371&di=b91414bec4f77f8013035d1b813a147c&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F24%2F20141024135801_ykTYC.thumb.700_0.jpeg"];
    
        [HCWLaunchAdView showAdWithURLs:imageURLs dwellTime:2 placeholderImage:nil didSelectedIndexBlock:^(NSInteger tapIndex) {
            NSLog(@"点击了%ld", (long)tapIndex);
        }];
    
    
}
-(void)setHeadImage{
        UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WScreen/2-40, 150-40, 80, 80)];
        headImage.image=[UIImage imageNamed:@"head"];
        headImage.autoresizingMask=YES;
        headImage.layer.cornerRadius=headImage.bounds.size.width/2;
        [self.view addSubview:headImage];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(headImage.frame.origin.x, headImage.frame.origin.y+80, 80, 28)];
//        label.text=@"白蓉";
        label.font= [UIFont systemFontOfSize:11];
        label.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:label];
}
-(void)setSelfView{
        _backImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WScreen,150)];
        _backImageV.backgroundColor = [UIColor redColor];
        _backImageV.userInteractionEnabled=YES;
        [self.view addSubview:_backImageV];
}

-(NSInteger)getTimeType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSDate *date =[NSDate date];
    [dateFormatter setDefaultDate:date];
    
    NSString *shangWuTimeStart =@"04:00:00";
    NSString *shangWuTimeEnd = @"11:59:59";
    NSString *xiaWuTimeStart = @"12:00:00";
    NSString *xiaWuTimeEnd = @"17:59:59";
    NSDate *shangWuTimeStartDate =[dateFormatter dateFromString:shangWuTimeStart];
    NSDate *shangWuTimeEndDate =[dateFormatter dateFromString:shangWuTimeEnd];
    
    NSDate *xiaWuTimeStartDate =[dateFormatter dateFromString:xiaWuTimeStart];
    NSDate *xiaWuTimeEndDate =[dateFormatter dateFromString:xiaWuTimeEnd];
    /*
     - (NSComparisonResult)compare:(NSDate *)other;
     
     该方法用于排序时调用:
     
     . 当实例保存的日期值与anotherDate相同时返回NSOrderedSame
     
     . 当实例保存的日期值晚于anotherDate时返回NSOrderedDescending
     
     . 当实例保存的日期值早于anotherDate时返回NSOrderedAscending
     */
    if ([date compare:shangWuTimeStartDate]!=NSOrderedAscending&&[date compare:shangWuTimeEndDate]!=NSOrderedDescending) {
        NSLog(@"上午好");
        
        return 0;
    }else if([date compare:xiaWuTimeStartDate]!=NSOrderedAscending&&[date compare:xiaWuTimeEndDate]<=0){
        NSLog(@"下午好");
        
        return 1;
        
    }else{
        NSLog(@"晚上好");
        
        return 2;
    }
    return 0;
}

-(void)setNabarBackgroudImage:(NSInteger)timeType{
    if (timeType>2||timeType<=0){
        self.timeType=0;
    };
    
    NSArray *naBarBcakImage = @[@"bar_forenoon",@"bar_afternoon",@"bar_evening"];
//     NSArray *naBarBcakImage = @[@"bar_forenoon",@"bar_forenoon",@"bar_forenoon"];
    NSString *naBarImageName = [naBarBcakImage objectAtIndex:self.timeType];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:naBarImageName] forBarMetrics:UIBarMetricsDefault];
}
-(void)setBarBacgroudImages:(NSInteger)timeType{
    if (timeType>2||timeType<=0){
        self.timeType=0;
    }else{
        self.timeType=timeType;
    }
    [self setNabarBackgroudImage:self.timeType];
    
    
    [self  setBarBackGIF:@"0"];
}
-(void)setBarBackGIF:(NSString*)type{//0:gif 1:png
        NSArray *BarBcakImage = @[@"barBG_morning2x.gif",@"barBG_noon2x.gif",@"barBG_evening2x.gif"];
//      NSArray *BarBcakImage = @[@"barBG_morning2x.gif",@"barBG_morning2x.gif",@"barBG_morning2x.gif"];
        NSArray *barBackPNG =@[@"barBG_morning2x.png",@"barBG_noon2x.png",@"barBG_evening2x.png"];
//     NSArray *barBackPNG =@[@"barBG_morning2x.png",@"barBG_morning2x.png",@"barBG_morning2x.png"];
        if([type isEqualToString:@"0"]){
            NSString *BarImageName = [BarBcakImage objectAtIndex:self.timeType];
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:BarImageName ofType:nil];
            NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
            _backImageV.image = [UIImage sd_animatedGIFWithData:imageData];
        }else{
            NSString *BarImageName = [barBackPNG objectAtIndex:self.timeType];
            _backImageV.image = [UIImage imageNamed:BarImageName];
        }
}
-(void)popView{
    
        MoreView *moreView = [MoreView sharedSingleton];
        moreView.delegate = self;
        moreView.center = CGPointMake(WScreen - moreView.bounds.size.width * 0.5 - 10, moreView.bounds.size.height * 0.5 + 10);
        [self.view addSubview:moreView];
    
//        setViewController *set=[[setViewController alloc]init];
//        [self.navigationController pushViewController:set animated:YES];
    
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        [self presentViewController:loginVC animated:YES completion:nil];
    
}
-(void)initBarBtnItem{
//    UIView *rightButtonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
//    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeSystem];
//    //    rightButton.backgroundColor =[UIColor clearColor];
//    rightButton.frame=rightButtonView.frame;
//    [rightButton  setImage:[UIImage imageNamed:@"消息选中"] forState:UIControlStateNormal];
//    rightButton.tintColor=[UIColor whiteColor];
//    [rightButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
//    [rightButtonView addSubview:rightButton];
//    UIBarButtonItem *rightButtonitem =[[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
//    self.navigationItem.rightBarButtonItem=rightButtonitem;
    
    UIView *leftButtonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame=leftButtonView.frame;
    [leftButton  setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    leftButton.tintColor=[UIColor whiteColor];
    [leftButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:leftButton];
    UIBarButtonItem *leftButtonitem =[[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem=leftButtonitem;
}

#pragma mark 右上角按钮事件
- (void)moreViewPushVCWithTag:(NSInteger)tag{
    self.backView.alpha =0;
    isMore=!isMore;
    _backView=nil;
    NSInteger count=tag-20001;
    if(count==0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"确定分享？"] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:okAction];

    }else if(count==1){
        AddFootViewController *addFoot=[[AddFootViewController alloc]init];
        addFoot.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:addFoot animated:YES];

    }else{
        FootCountViewController *footCount=[[FootCountViewController alloc]init];
        footCount.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:footCount animated:YES];
    }
    }
-(void)hiddenBackView{

    [UIView animateWithDuration:0.5 animations:^{
        self.backView.alpha = 0;
        isMore = !isMore;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        self.backView = nil;
    }];
    
}
@end
