//
//  HealthSourceViewController.m
//  MyHealthModule
//
//  Created by L on 2017/5/16.
//
//

#import "HealthSourceViewController.h"

#import "UIWebViewController.h"
#import "ToolsCell.h"
@interface HealthSourceViewController ()
@property(strong,nonatomic)NSArray *imageArray;
@property(strong,nonatomic)NSArray *nameLabArray;
@property(strong,nonatomic)NSArray *titleLabArray;
@property(strong,nonatomic)NSArray *urlArray;

@end

@implementation HealthSourceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpdateData];
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpdateData{
    self.imageArray =@[@"run-0.png",@"run-1.png",@"run-22.png",@"run-3.png",@"run-4.png",@"run-5.png",
                       @"run-6.png",@"run-7.png",@"run-8.png",
                       @"run-9.png",@"run-10.png",@"run-11.png",
                       @"run-12.png",@"run-13.png",@"run-14.png",
];
    self.nameLabArray=@[@"最常被人忽视的细节，却是高效虐腹的关键！",@"圆肩驼背，可能没你想得那么简单！",@"穿衣有型脱衣有肉，就靠这1个动作！",@"还在做卷腹？1个动作高效虐腹！",@"找对节奏，让你的训练事半功倍！",@"训练后最易中枪的7个错误！",@"1个动作提高硬拉、引体向上的能力！",@"1个动作拉伸胸部、挺拔身姿！",@"1个动作全身高效塑形！",@"想用跑步瘦20斤，如何执行最有效？",@"训练那么辛苦，不弄清消耗和摄入怎么能行",@"你的粗腿根本不是因为胖，而是…",@"不吃主食只吃菜，能减肥成功吗？",@"99%的人都知道的俯卧撑，这么练才能精准练到胸肌！",@"26 种深蹲姿势，带你练出紧翘臀！"];
    self.titleLabArray=@[@"Mikeling 健身CEO",@" Mikeling 健身CEO",@"  Mikeling 健身CEO",@"Mikeling 健身CEO",@"FitTime 健身CEO",@" Mikeling 健身CEO",@"Mikeling 健身CEO",@"Mikeling 健身CEO",@" Mikeling 健身CEO",@"Keep君 Keep",@"Keep君 Keep",@"Keep君 Keep",@"范志红 Keep",@"Keep君 Keep",@"keepon健身计划"];
    self.urlArray=@[@"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650915028&idx=1&sn=1469c671b9e945f2131ddbe610a925bb&chksm=bd0350c28a74d9d433003db48bf76bf0c374798c0c206ec60b4f3d790ae03060c544a2d54862&mpshare=1&scene=1&srcid=05168d57d50aVzGrR74MoRO6&key=5a2d2c76af59b628d48df89cacc61f756d11c16f73438cfc5d03ad21670875cf340945a0bed34fb31cbf7280affd473acb9cca70ba0b276664a06bb9df208cdc9676a2d61d2f9309a79fb91111269f16&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650915010&idx=1&sn=5a970af824b9494c55f1811f9a8a18de&chksm=bd0350d48a74d9c2d80660f9c0c2519161fa390a87bd34e261229a9b5e30ffa289e01fb5f8ab&mpshare=1&scene=1&srcid=0516V3Il51FY3IXymxB20OEx&key=9603ff9ff537db2218ef8a7e0f283868630800b11969a400cd9c3c9cdeab36e853852f653a449aee73fbe28b1d3ec57b0a644a865930039b9524386ea4a0a43aaac914704076c1059ce89708a9706fdf&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650914998&idx=1&sn=95f186888b70ca992ae1283bdf01ea1c&chksm=bd0350a08a74d9b65be0615ca23c79dc5515e49e5201bf12c7f2a9e2721750fd98486c73b326&mpshare=1&scene=1&srcid=0516gDK62IyBanGqZXF61Np5&key=508fe9d2e44c5b79f11e873e23fef9d2c4c289c25656bc44168a41ff37dfe8d1faced103198fb8f2ecfe5eac5245076a29b0d44561b129cba90974873f9a2a529ec79ed71c96266143704f321590f6a3&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650914991&idx=1&sn=4305c11f09ca53dfa7585686b2cab7a0&chksm=bd0350b98a74d9af7125c93e384bbe0727bfab23672540409790497acd1f4f4a1c75195e736c&mpshare=1&scene=1&srcid=0516w52rGLDPmNYIXU7Jkfbi&key=2cba64347303289f7380c217bbe87de45a8b8a0063f921315469973efc091a0a862bd0c9c0dd01a34b86c74a1fb1d49db3ab9034d6463cc1a78788d77184dfadcb8b8529824336998bbf87b3950cec98&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650914981&idx=1&sn=acd7e60a29e24f50a533c1a24d5a9b22&chksm=bd0350b38a74d9a5f1a9cad4ac5c71e54b20e620898ba792b2a61b617fed37ab3fcdf90686c8&mpshare=1&scene=1&srcid=0516a1058uWNCn0I2rHLNOS6&key=508fe9d2e44c5b792768b08a6a1ee301c0ae221222dc86dbade4fcf0223b54936f1577f7efe2ebfdb246f8c5fbd81916c27f3fdd8cc6e6eb372319a2f0f46cef816486ca5482bded64c164aaf2084752&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650914952&idx=1&sn=8b4aff84625b260beac4ea525ea54f81&chksm=bd03509e8a74d988a39c16c929a8ab6a0c19025e212cd9e128be976af4f97035832904d9edab&mpshare=1&scene=1&srcid=0516zHIdzLhozByfv36Xa9ik&key=2cba64347303289f6a4fba6cf3c0d3a2a06510879a1187534d9e55f9eaa17dd8da01931ff164bd68a28ec0c5f9aad326f00296add37041d211f367726d7f9c873a33127f4f33e931c19cdbb13a95b048&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650914951&idx=1&sn=8a89565ead1ec3f122dc68fade416c25&chksm=bd0350918a74d987275c55bb41fc5c73e98f751802c20a3d28a0e457eac383c89d53076bc6ec&mpshare=1&scene=1&srcid=05162qCtPFxYzQJzoVEoDXLV&key=2cba64347303289fd9484949dd67cfc3d2f6c0e12694df4967e698e43094b5cfd958bbe3b2f95dda1422d39a09e785e3b2d3bba7df7a9f1b9c95455a5d375012903388db413e8299bc934427b489684f&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650914942&idx=1&sn=f9ce792245adb70fbdbe494595aa193e&chksm=bd0350688a74d97ef6d4b1731042b31679fb0a92dbbbf3429040c9dd7142f47b01462ecc98fd&mpshare=1&scene=1&srcid=0516qGUEIAZXNERiZU2XrT5L&key=508fe9d2e44c5b794d64b3d5eba8327b70c2370c3250c6c0c28a5fc0cdbfbc732d41efb5863c5df3fb48a555b33efb29037cdb2e1f3f7428548e341085bd80a7a234eb4ece388523008ce3aedc63424e&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5NTU4ODQ3Mw==&mid=2650914933&idx=1&sn=1fd42cd74470e27d66cdf1d8020e95fc&chksm=bd0350638a74d97503ddbae814ae1f85ea887f68e630a50c4212d2ef69a50814e6908807710e&mpshare=1&scene=1&srcid=0516lgPusoCqTGPdoYKF0gqL&key=2cba64347303289fc64506a451bde001cc08caabae4324823f7b3fd2b24460264259a93915d79cbf095a5decb80cb78de8dfa8de8716f418380ce3a3bd7f1fcbc4ad4fd2a2c0d116015b26a6bd8dd4a3&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNTA5NzgyNQ==&mid=2653115605&idx=1&sn=4eff20242571643b06d8ab693eddae4e&chksm=805ebe5bb729374dd5756783517140cc82a56b5fc83b2a9e232754491d02f8fbed9a35879f4d&mpshare=1&scene=1&srcid=0516Pg44IbdzD0EXuNOBALg5&key=05bd214169ad1576a774faaa004777f0883e598115ec939ad8e98f439b4a2c46dd6cec91740868a73ed7a9bffc5a5429417156d1b8c9717f15042e4082cfef9ead82ac19bf07aa051b71bd5cc81fbf45&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNTA5NzgyNQ==&mid=2653115605&idx=2&sn=667d25eb84381df9cfbdd3e764e0b87c&chksm=805ebe5bb729374d35f1215c8af79acb63f6517ce7a62aa8607ba0e4d5685f65780e7f3e0184&mpshare=1&scene=1&srcid=0516boWos2AaJPDredg6agCM&key=7d4eb0035f57fc87d100ee22366ea90e653580e94b7520b0713614828a95291bb51c73d5e144eea854bbed7e057f306072d7937483ddd7e57f4f423d2ed365beddeb2ab3fafe4f4c3abc35ac67391b35&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNTA5NzgyNQ==&mid=2653115542&idx=1&sn=37cfb8a688424d9f13788eaaf5e2ac30&chksm=805ebe18b729370e3665ce251564e97d9b64a59f2e21adb258018a4d30574728f0a2d5d97466&mpshare=1&scene=1&srcid=0516RGeP2HNDnwv6Pic5IHbQ&key=c5a58783da8d7ae1f4d4e1cafdad4e39bbe9bd2d34b1c3a724b80d9033af931ed95123aa22fbd5215b1aedc4a3b57dfc3ff7cabfd2ac39f623945aacf95764ebd838ba663c48d33c9f494d7920c0a08f&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNTA5NzgyNQ==&mid=2653115485&idx=1&sn=b5f0bf6ba2d2dbd2fbd84c4c08444ec0&chksm=805ebed3b72937c5d3b0405213e10171f9a53caee4f9946dbdb1a8beb632034578145730ceb5&mpshare=1&scene=1&srcid=0516QxqDYtpuc3jJKVd1Wt6W&key=55ff6cf80764bb5e5ad3bdfec84e8f6619b871d8c1e9664de8d88058f22d3cf8d819c8666efb0570eac764f373e8631c24fbf8fe083b94fbcf7942b2b78b0086f5b44645b7e3ea51352a4c14fb088695&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNTA5NzgyNQ==&mid=2653115483&idx=1&sn=ba8abec2445c1644d732805300cf4b54&chksm=805ebed5b72937c32463362ed6f6311f91bc396679d8f6ebf899971ca83d34258907f9cb8289&mpshare=1&scene=1&srcid=05160LOGgkk7so0bvvw2NQLu&key=55ff6cf80764bb5e218fa8d8fa390081614ff645eece7614a4b53ebe2e517cc141992b2e74e460dfcfd7a6bbd787f4a3e67ee05e7b7b47b8d36186a1664b7cfca3dff76388183fb5e1d1161407f8b979&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI5MzYyODc1NA==&mid=2247484474&idx=3&sn=6dc55df734142c33778b2fd266749b48&chksm=ec6e7a07db19f311b5e8f7d52418b9fc8b841b17531851564eec38603fdd566821d4ceb4bc78&mpshare=1&scene=1&srcid=0516HC1Fp4Uy2hEX8AVlIwl4&key=d97f1de820e9358bc2a644073262a3c334a0fef7a7a4c5adaaafb0d76e4e7997a20816c547ad9434bc363ac411faefff55772d2ec752fae808df657a44b696327337003fecfe0416c0b297ffad66f841&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4"];
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
