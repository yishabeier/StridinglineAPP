//
//  NewsViewController.m
//  LeftSlide
//
//  Created by L on 2017/4/18.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "ToolsViewController.h"
#import "AppDelegate.h"
#import "JXScrollView.h"
#import "Head.h"
#import "ToolsCell.h"
#import "UIWebViewController.h"
#import "DetailTabViewController.h"
#import "HealthSourceViewController.h"
#import "VideoViewController.h"
@interface ToolsViewController ()<JXScrollViewDataSource,JXScrollViewDelegate>{
    NSArray *imageArr;

}
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property(strong,nonatomic)NSArray *imageArray;
@property(strong,nonatomic)NSArray *nameLabArray;
@property(strong,nonatomic)NSArray *titleLabArray;
@property(strong,nonatomic)NSArray *urlArray;

@end

@implementation ToolsViewController
- (IBAction)clickFirstButton:(id)sender {
    HealthSourceViewController *detail =[[HealthSourceViewController alloc]init];
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
}
- (IBAction)clickSecondButton:(id)sender {
    VideoViewController *detail =[[VideoViewController alloc]init];
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (IBAction)clickThirdButton:(id)sender {
    DetailTabViewController *detail =[[DetailTabViewController alloc]init];
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"newNaBarBackgroundImage.png"] forBarMetrics:UIBarMetricsDefault];
    self.title=@"健康专辑";
//    self.ScrollView.contentSize=CGSizeMake(WScreen,1000);
    
//    _contentViewHeight.constant = HScreen+136+64;
    [self setUpData];
    [self setUpView];
    // Do any additional setup after loading the view from its nib.
}

//初始化数据
-(void)setUpData{
    imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494955744928&di=3d4dceb435f51d2a2c79ad30a8106e40&imgtype=0&src=http%3A%2F%2Fwww.0555nh.com%2Ftupian%2Fbd3225030.jpg.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494955518164&di=c89b3c6e741c785e40fcd0e9478cdc3d&imgtype=0&src=http%3A%2F%2Fi.weather.com.cn%2Fimages%2Fguangxi%2Fgxsy%2Fmrjs%2Fmr%2F2015%2F01%2F28%2F78B3C2B75C4EE49FEDADE1B717EF0BD6.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494954425841&di=f31545a952787c4fc89367844839be58&imgtype=0&src=http%3A%2F%2Fuserimage8.360doc.com%2F16%2F0627%2F18%2F11532035_201606271824580443401353.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1494944428&di=d7f185574820f2b86ee4369e6f51b1ee&src=http://pic.lifetmt.com/2014/12/1-130FR3430O64.jpg",@"http://img.juimg.com/tuku/yulantu/110301/292-1103010J23769.jpg"];
    self.imageArray =@[@"run-16.png",@"Video-8.png",@"2-health.png",@"run-17.png",@"run-19.png",@"run-8.png",@"6-health.png",@"7-health.png",@"8-health.png",@"9-health.png",@"run-3.png",@"run-14.png",@"run-13.png",@"run-21.png",@"run-22.png"];
    self.nameLabArray=@[@"筋拉长一寸，寿命长十年？教你3个动作，坐着拉、站着拉……",@"睡前1小时是养生黄金期，坚持6个动作有奇效",@"晚餐，决定你的体重和健康",@"夏天快到了，你的手臂准备好了么？",@"几个方法帮你瘦腿，动起来！！",@"快速简单有效的手臂减脂方法盘点！",@"健身误区TOP10！对照自己，看看有没有做错",@"跑步减肥98%的人白跑了，因为会犯5个错误！",@"减肥第一步 坚决甩掉7个致胖的坏习惯",@"新菜常鲜丨诱人美食的一百种低脂吃法",@"26 种深蹲姿势，带你练出紧翘臀！",@"怎样做到增肌不增脂，秘诀在这里！",@"健身早餐：哪些早餐食物最好不要吃？",@"3分钟HIIT燃脂训练，你能做到这些吗？大写服！",@"嫩滑翡翠豆腐羹，清肠减脂瘦三斤",@"最近疯传的两分钟虐腹训练"];
    self.titleLabArray=@[@"西邮同心",@"华为运动健康",@"健康运动播报",@"健康运动播报",@"FitTime瑞健时代",@"乐心运动",@"GymMax健乐多",@"乐心运动",@"GymMax健乐多",@"乐心运动",@"GymMax健乐多",@"FitTime瑞健时代",@"FitTime瑞健时代",@"西邮同心",@"FitTime瑞健时代"];
    self.urlArray=@[@"https://mp.weixin.qq.com/s?__biz=MzAxODA2MDM5MQ==&mid=2650753574&idx=3&sn=70f632ff660dcca56fd58536bde7fa86&chksm=83d7ef2eb4a066384fcf8042309a046baf0a5baf80f1e21b2290575bf7ae168d50c52cde2032&mpshare=1&scene=1&srcid=0510N55ksm4B7ZFi97VXKAIM&key=1a0b9e468ea55114632b32cc550df4f667e880a03b877294267b816cc21c5c51a1716cbb812b6b2c55e3aa539494eea2ecf5207de7791dcd34cfea5e0527cef9c2c07bd2aff276a22c4790d4eaa7fd85&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=d%2FOiNwZRk4iaOMMXIf6sqH3hs1RH9Kg2wRwwiMnmlFa68ZSNek2ddb6H6qAkxF15",
                    @"https://mp.weixin.qq.com/s?__biz=MzA5ODY0ODgzMA==&mid=2662798932&idx=1&sn=50d0335e8449469a58ba8cea9c9032ba&chksm=8bcde1c5bcba68d3134443a6be65fa9cb0d600d5eb5d6ad5c93dac60e55c8b9eea4524f6b920&mpshare=1&scene=1&srcid=0511EEEfdR8aIffRU4lVWjlM&key=519926ba1d3c3d779526c30192a6b3dff6658b503fb6e43c01e306a9efedda65422bae8fe5e0fc7a242b35e05a3c6e37b45d6b7e428c58475fa54e172d072aec0db9e496656abda41c5a400b3e8b8e81&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=fuYBXAs1R%2FdTddozg%2B7mkK7YClm6wNe0nfVLN6oHd6FwFZWrlgg9d%2Bo9zFNqZv%2FH",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MDI3MDEyMg==&mid=2653009102&idx=1&sn=ed7f1f5bbe1fb06c001b0f1bc7ad0dc8&chksm=bd92430b8ae5ca1d9d1d98f6363734ae354974023c72d00a8d3abbb68b2a56366e552402372f&mpshare=1&scene=1&srcid=0511dxsQzZq2wVGDrYLsRPm7&key=316336ac2ae675e0a8994ebee6d77da23fecdcaa38808e7b795f333eabe0c5b3373bb20e4e2a3d7a1b2053fda5de8409fe5ceadf6907d41a5c9f4b8226a3718df1de96c4848c4cc0a25d456066787a19&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=fuYBXAs1R%2FdTddozg%2B7mkK7YClm6wNe0nfVLN6oHd6FwFZWrlgg9d%2Bo9zFNqZv%2FH",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MDI3MDEyMg==&mid=2653009111&idx=1&sn=9a82d3e5932261e0a8b40a2e89e4f6f9&chksm=bd9243128ae5ca04982044f7b6ecc057c9ebbbebef46707064a360ad0e00a6cf3ef3e07bfcba&mpshare=1&scene=1&srcid=0511swW39DbsaDf7D5N2dJzb&key=316336ac2ae675e0fbbf664083556526a307a550a0f070de3d2ec239007a40037d5180e21fe95e7093721dac4b5a1872c4c67e62df7c18d9b0559ae4c0a542ea5d81f511621874083599dff0d413d7c9&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=fuYBXAs1R%2FdTddozg%2B7mkK7YClm6wNe0nfVLN6oHd6FwFZWrlgg9d%2Bo9zFNqZv%2FH",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MDI3MDEyMg==&mid=2653009111&idx=2&sn=722824b3e93bdaaa7eb7d3b391649c70&chksm=bd9243128ae5ca040dc9c5a73970d54ddb6e4f920b89e240761684f0e954b7918b95a1b5903c&mpshare=1&scene=1&srcid=0511YZc2oZgpla0B3iLbIg2b&key=ca599c4517e3b9c7ee2a6a1d692768d287278272a77af78fb4dd3e27d2095e9b6363035c23820d450e214be48f68514a5b1cecb8353c50181ea6bc549ebb61316779f5be76cbf6673ef76886e1d0622a&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=fuYBXAs1R%2FdTddozg%2B7mkK7YClm6wNe0nfVLN6oHd6FwFZWrlgg9d%2Bo9zFNqZv%2FH",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MDI3MDEyMg==&mid=2653009111&idx=1&sn=9a82d3e5932261e0a8b40a2e89e4f6f9&chksm=bd9243128ae5ca04982044f7b6ecc057c9ebbbebef46707064a360ad0e00a6cf3ef3e07bfcba&mpshare=1&scene=1&srcid=0511swW39DbsaDf7D5N2dJzb&key=87d6234bc9090e429bb4d6229db659e9f8c02615c9bd13608f9f11f154a3784890ee8f4ad2e6953650482a6f642513e396511c991a2779f164a07211d7bb1548ca602564205a32cbcf673d0eb0027f58&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=fuYBXAs1R%2FdTddozg%2B7mkK7YClm6wNe0nfVLN6oHd6FwFZWrlgg9d%2Bo9zFNqZv%2FH",
                    @"https://mp.weixin.qq.com/s?__biz=MzA5MTgxMDM4Mg==&mid=2652657997&idx=1&sn=016425463767c007977afdf25df20f24&chksm=8b9e466cbce9cf7a1f0f2e68164cdff3a78029bbcbc11dba9fa73319c50b6aff8ddb1aad43c4&mpshare=1&scene=1&srcid=0516jqHsRQogkNceGVcARhvc&key=05bd214169ad157642305bb5081d0277310a8a4258e0661e49ac77ac24855e43345b02b6e197d91115ed4afee5abbeb3d962faa911406415124b5aeefd5f59e2516ef7a608098a5b8c58181c5c7c4ce2&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzA5MTgxMDM4Mg==&mid=2652657986&idx=1&sn=2a6c9d00cee8fa65d06474e446ca36aa&chksm=8b9e4663bce9cf753dbefd1e6b40ba11cd95d3f553d61594fabd3b1294d4dd6b69cee9ad933e&mpshare=1&scene=1&srcid=0516bhppmSoWTvwGAuzIiDDE&key=13026cacabfccb691490d95a8b253367b9073729a7822fb5db5f3716026cf12b1f75e39a0f49146429befa80f58446631d1db1c1eb8b5e8527632a51ab5b9d826e6f68f8d3dd178b314aa92379ddf64a&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzA5OTUxMDczOQ==&mid=2652038348&idx=1&sn=b5539da941e03980b38007abdb272d91&chksm=8b677470bc10fd666f637dd01d92acbec5283d19c87f5e383785d7e0f8993cd2c77347274e73&mpshare=1&scene=1&srcid=05169ViTqTgaWcrKaxv5rtmP&key=05bd214169ad1576f5f29591d3c9d762ef8431688cc57ef5153b8b038e07d421faece14450c8568a9cb376d289cf9a6157f6fa255a09c04e6643ba578d62498ece0543f3ba5f7a8e7500a05bb616b110&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI0NTA3MTA3OA==&mid=2649918129&idx=1&sn=d0a79916c5114cc3ee3f0b3b9a7ed900&chksm=f1520738c6258e2ee688fa9616befd6c59fe6362381af803a6703be83e3c841c3874d5ab5108&mpshare=1&scene=1&srcid=0516XEG73hrL9aAjERkokkUn&key=988a08a338a0a121154ea0fd7fd13ec755342db2d81afd7d1be06591afb238cb093dbd8461bdf109e1cd4c3bf17521667374fac6c017a25df31f0e4af3b33a4ab414e686b87040a0b195422e7db446ec&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI5MzYyODc1NA==&mid=2247484474&idx=3&sn=6dc55df734142c33778b2fd266749b48&chksm=ec6e7a07db19f311b5e8f7d52418b9fc8b841b17531851564eec38603fdd566821d4ceb4bc78&mpshare=1&scene=1&srcid=0516HC1Fp4Uy2hEX8AVlIwl4&key=05bd214169ad157674f8eec29ca1b639c236b16c7c147fe589bfffa8bb75168a32902efbca5dc8cce014443c02b8b2c0823f05fd5fc34f48cb6a111fb64a8d2be8aba79df59687ebe0d7ea8cd70f0a1f&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzA3NTA0NTYxMA==&mid=2651149496&idx=4&sn=fa25b7952c461176ad6a3ebb9eaa3854&chksm=84877b3db3f0f22bb5dcdbe7b6341f9051ce67843229284852cb8c478e397bdf49022664e3bb&mpshare=1&scene=1&srcid=0516TfSVcsGAtj5nGmYT8FyW&key=988a08a338a0a121f80aaca958d480aff3e66011b0efca259ad87c274a825d012c1f143127e4db8f0f8ba4001cdae4c981f3d91a0bdd27c347cd99d9baccbd3d97fc903fcaf615c2e15857861dbe07e5&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI5MDY3NTE1Mg==&mid=2247483884&idx=1&sn=a4a5fed38322cfbb9e4fe3b7d8361d21&chksm=ec1d0153db6a8845e2ad008dbfb621d901ae2bc88afacfde0bb0657cf6af8ed761979f5f0a36&mpshare=1&scene=1&srcid=0516UROBxSIp3mjg1wfYcRyp&key=118210233a75182d3f22cdb514cf914e035f20701908baaaefe95acffdaf08595f8751dc9d654bc21ff5d5a66e274da0e056f4803d7699c987120781d1cffb229b0641ab2731e6badf5fe8f1fcf3cfa1&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083750&idx=4&sn=eeb1a7e2657ea8f23c95529fd084dce5&chksm=f2d46c8ec5a3e5987fa60a6715147ba31cfb60cb086022209466736610efc7b86a6e1593e199&mpshare=1&scene=1&srcid=0516PRjxILUbIFiuCNgXrPep&key=9603ff9ff537db226a3ffb11f2e9ef2743ac8100a6d91cbde46f9b4be41557548b3d5f5d3aac378811e58e30f68b67ce52788506a0e3310cc63c9dcfd96b4efb62bf4ce79006899e2ca17d474ac54685&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083728&idx=3&sn=81426c641aa63ef3b443f01aad5fec01&chksm=f2d46cb8c5a3e5ae0186194b4b027bb61e9c0cb70db247c4b1d91614c27ca824183777f17f96&mpshare=1&scene=1&srcid=0516OjthEdrFc3UgyVvN5Z0h&key=508fe9d2e44c5b799c0a1fc166c93d9fa7b1fa80836fafd83fd3f6bdee4f77c6f914f33bf227354ce6ccec8bcd3181cadde6f9f2213561f130fd951bc177eee68766d904642365e4b6c22fbad958168f&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzIxMTUwNTU1MA==&mid=2247483866&idx=1&sn=9ff74fa55667146448ebd1f09ff88a85&mpshare=1&scene=1&srcid=0516xId3gYIGOIugiAICfb1N&key=988a08a338a0a1214aaeea6f2d704613938fcbcd4a7d9c6e393a43948e0f303ae3a22613781a5b01a9af09a5bba94477cf0f0775c83492c515f234a2d5e7e9f675fd9239f29bba0b6e881f0e1a77362b&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4"];
}

//初始化视图
-(void)setUpView{
    JXScrollView *scroll = [[JXScrollView alloc] initWithFrame:CGRectMake(0, 0, WScreen, 150)];
    scroll.pageControlTintColor = [UIColor grayColor];
    scroll.pageIndicatorSelectedTintColor = [UIColor redColor];
    scroll.dataSource = self;
    scroll.delegate = self;
    scroll.hideIndicator = YES;
    scroll.pageControlPosition = JXScrollViewPageControlPositionRight;
    [self.ScrollView addSubview:scroll];
    [scroll start];
}

#pragma mark - 加载网络图片
-(NSInteger)numberOfItemInScrollView:(JXScrollView *)scrollView{
   
       return imageArr.count;

}

-(NSURL*)scrollView:(JXScrollView *)scrollView urlForItemAtIndex:(NSInteger)index{
    return [NSURL URLWithString:imageArr[index]];
}


//#pragma mark - 加载本地图片
////-(NSInteger)numberOfItemInScrollView:(JXScrollView *)scrollView{
////    return 6;
////}
////
////-(UIImage*)scrollView:(JXScrollView *)scrollView imageForItemAtIndex:(NSInteger)index{
////    return [UIImage imageNamed:[NSString stringWithFormat:@"image%zd.jpg",index]];
////}

-(UIImage*)scrollView:(JXScrollView *)scrollView placeholderImageForIndex:(NSInteger)index{
    return [UIImage imageNamed:@"loading"];
}

-(void)scrollView:(JXScrollView *)scrollView didClickAtIndex:(NSInteger)index{
    NSLog(@"Click:%zd",index+1);
}

#pragma mark TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier =@"identifier";
    ToolsCell *cell= [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell=[[ToolsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.headerImg.image=[UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.nameLab.text=self.nameLabArray[indexPath.row];
    cell.titleLab.text=self.titleLabArray[indexPath.row];
    return cell;
    
}
#pragma mark TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 44;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *label =[[UILabel alloc]initWithFrame:self.view.bounds];
//    label.text=@"              精彩文章";
//    label.font =[UIFont fontWithName:@"Arial" size:12];
//    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 30, 30)];
//    imageView.image=[UIImage imageNamed:@"walletIcon"];
//    [label addSubview:imageView];
//    return label;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIWebViewController *webView = [[UIWebViewController alloc]init];
    webView.hidesBottomBarWhenPushed=YES;
    webView.urlWeb=self.urlArray[indexPath.row];
    webView.title=@"精彩文章";
    [self.navigationController pushViewController:webView animated:YES];
}
#pragma mark 让tableView的headerSection 跟随tableView一起移动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 40;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
