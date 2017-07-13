//
//  DetailTabViewController.m
//  MyHealthModule
//
//  Created by L on 2017/5/11.
//
//

#import "DetailTabViewController.h"
#import "UIWebViewController.h"
#import "ToolsCell.h"
@interface DetailTabViewController ()
@property(strong,nonatomic)NSArray *imageArray;
@property(strong,nonatomic)NSArray *nameLabArray;
@property(strong,nonatomic)NSArray *titleLabArray;
@property(strong,nonatomic)NSArray *urlArray;

@end

@implementation DetailTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpdateData];
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpdateData{
    self.imageArray =@[@"Video-0.png",@"Video-1.png",@"Video-2.png",@"Video-3.png",@"Video-4.png",@"Video-5.png",@"Video-6.png",@"Video-7.png",@"Video-8.png",@"Video-9.png",@"Video-10.png",@"Video-11.png",@"Video-12.png",@"Video-13.png",@"Video-14.png"];
    self.nameLabArray=@[@"在睡觉这事儿上，五福临门其实可以这样解读",@"为什么每天早上起来都这么累，可能是这几个原因",@"27岁癌症患者告诉你：年轻人，别睡太晚",@"321，天黑请闭眼",@"心脏病与睡眠呼吸暂停综合征",@"警惕打鼾！年轻小伙诱发心脏病、李安险些猝死",@"心灵驿站｜你好，晚睡星人",@"干货总结：阻塞性睡眠呼吸暂停的并发症汇总",@"关于梦境，你不得不知道的4个真相！",@"春天来了，你为啥总是睡不醒？",@"谈谈帕金森病合并睡眠障碍",@"伯克利前沿科学家发现人类睡眠的奥秘",@"小白失眠了，怎么办？林医生来帮你",@"王玉平：失眠如此煎熬，我们该如何选择用药？",@"癌症可能是“睡”出来的"];
    self.titleLabArray=@[@"家亿 汉妮威睡眠系统",@"小威 汉妮威睡眠系统",@" aisleep睡眠博士",@"aisleep睡眠博士",@"橙橙 睡眠健康",@" 阿橙 睡眠健康",@"一苇渡航 中国睡眠研究会",@"李祖飞 中国睡眠研究会",@"欧欧 中国睡眠研究会",@"白剑峰 付东红 中国睡眠研究会",@"中国睡眠研究会",@"中国睡眠研究会",@"中国睡眠研究会",@"中国睡眠研究会",@" 汉妮威睡眠系统"];
    self.urlArray=@[@"https://mp.weixin.qq.com/s?__biz=MjM5MTcyNzQ0MQ==&mid=2649941958&idx=1&sn=493fee5c7afb7a037c248d2badc8a1c4&chksm=beb76df889c0e4eed546e9a112d07af1b9ebbd6f91e87b896c1d03149cefac9d81c985bccbed&mpshare=1&scene=1&srcid=0516qatp4by9xzGGQXiKYiL8&key=2cba64347303289f0d2a5ef2263b33339ab987228aba9c4d6aa555f2f8311eba62f620c8b8577c333016f4b6c3b6c745947cf0104f32d379b3c5c579c9ece0cbc2eef90592abbc5e23451ed502e95bb9&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MTcyNzQ0MQ==&mid=2649941970&idx=1&sn=025c674c3c2b1681dd22333d095adf7e&chksm=beb76dec89c0e4fa09d3393dea871bb3cc6e122788e240b6f939bdb4d9fad8f47d4b469b14b1&mpshare=1&scene=1&srcid=05168hHSsLYD8oyv2ZRf0vok&key=2cba64347303289fe6b2c4b932433b4016888ae82ef8652b00f585379dff99b473dd7b8551ba94777f3a9e47aa7e6a130db1e3f2bd20bdaff4fe5d9a864f10583c50056cb5ba656bf8692a7a50438583&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MjA1ODQ4MA==&mid=2650945329&idx=1&sn=b9f2bca8c05ea3f48a98bd4ba87eed1c&chksm=bd5a8a2e8a2d03383e32c52cd915bb23309a82e876f86c5075ab2bb4668053414515b7460ac0&mpshare=1&scene=1&srcid=05168wQqB4bh9tyhixAXvaNH&key=55ff6cf80764bb5e0df27bcacd6719881055b65dbd763066594e693030854680dc152e61279c52cffcf7f18b6bcd03e3b6d0a9eee0abfccd187c90462b78f3beafb8f302bbe153e2e4770c1d08d062a3&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MjA1ODQ4MA==&mid=2650945357&idx=1&sn=3ffaf7c71dd7b3df61bf53de165d3395&chksm=bd5a8a528a2d03445e70399871a5df3d1b107a4b87dd79c14c5426c3925c79b57cdbdb36a580&mpshare=1&scene=1&srcid=0516yEbx6D3VvDpBwcfHxMAt&key=55ff6cf80764bb5e17475d958ebc3841ab2ec8b53466ee7ce31e3a372e1c919971561b23bd2d2302d10f73f6a5faf215a22caa793ccaf3c4a46b07234b4a518339d615b0826682bd56fb38dba1638dff&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzA5MzExMzA2MA==&mid=2653910059&idx=1&sn=60751afd193b4de39851a7911b913cdb&chksm=8bb90ba0bcce82b60f2b78aa7a8ad0675f13bd08c440757e21438faccc41e2fbfdcb0a2b8765&mpshare=1&scene=1&srcid=0516EtdpgjDUAw0ZBefMHVs5&key=5a2d2c76af59b62871de7b390703d4810279a3f4f99c3a34e35b6158d7b33780960c96f17a97fabe5a3cd72a0d9ac8ff5fefb29b9ba1e37e84d68324417a42be545e9676965e731f9af53aa347ca6f91&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzA5MzExMzA2MA==&mid=2653910087&idx=1&sn=60b2c1a0e78b6abd078c08cea778d4c3&chksm=8bb90bccbcce82da4fd427f7b4ea5ed1fb50b37bbc573403a732f5143650b5a8662ee319707f&mpshare=1&scene=1&srcid=0516GbwxYhij77SRxIKSXEal&key=82f06b1a5367f3902a7199109971638d975d2fb2bd1eb101c78185c254f916ff5efde8cc75d0a7d0ed5e300be83d9bd480d3545d76ee0e5cfcb4fb3c1ebaa61e2621d1a4b18691bff9084f7176c118a2&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014250&idx=5&sn=be2673ae5db05b1b5d6b65e5d97b1476&chksm=83964e22b4e1c734f511bc1398a97603ad79878d76d52d6c5efd6e83398ea82289800206fc66&mpshare=1&scene=1&srcid=0516yWJp9ujLbMxiB69bobos&key=988a08a338a0a1213dcbfab3e06a1c10ca4ffacfa2b9163ee606317b40e188a43ec721118efa38f1e6e9e93cab59ff009ce1b0e87ae795cafc975a20a4453f35834d6e32fda9671140a3b6ab1c521c83&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014250&idx=2&sn=86f6b36cffbc255a18235023ddb2b13a&chksm=83964e22b4e1c73430193de2c7b889c33336805fafcce61796449826e2c5070e5fee21b31228&mpshare=1&scene=1&srcid=0516XCOwhlyd35VLr0eSGwyc&key=c4821028b94802fed1d4486fac9514c6f8a2fbf244b2a4e726907ecac87554be8a47f98fde30c23060c70a9b3a9762528cafbcfa3e9464a13178e1a0ba01c8fd2f7ccb55949750eeebeb48197dbf0d6e&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014250&idx=1&sn=7a3c35c43dccdfe46ee322f71f099cb4&chksm=83964e22b4e1c7342dd8d1bed1e11226d63f07ea0fc98d70ea91ea50eed0802e21d5c17b8751&mpshare=1&scene=1&srcid=0516XLN11ntg2n0uUNI6vyEJ&key=508fe9d2e44c5b79da9a0c51b4e454c63bde63cb103fc5493e29d7af2a342ed7a6df290e470e514057a88cdf1738b631299b864335ecd5981f645f5b10a11d68e309793431f7fe52a829a3e2172e9344&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014253&idx=2&sn=8d86278a90c9e99ea30d79885e4e8de7&chksm=83964e25b4e1c73323f722e296af4cb025d993a457bc0869d958a9eda32fdbbd193ab52d5c6c&mpshare=1&scene=1&srcid=0516YjoNX9zrROaGuvjI6tg9&key=7d4eb0035f57fc8742f81f989b6ad24dcd157fcb7a9c848bc4d59a0b0b2bcb36680f7a714f022b95e43483d82818dcd079ff355989e14817d27ea112b896c0724f7a956087b223d287b47436a610f07c&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014256&idx=2&sn=12cbb4320cd0915f68186d520c78b443&chksm=83964e38b4e1c72e84b21bd4cfd909ad9c3a711ffc6a56b8fcffd7ef302ba0efbb6928ea55d2&mpshare=1&scene=1&srcid=0516OE2EUOL6tBUOsFUrrgth&key=9603ff9ff537db22491c52dd34037048889e046abea26cf138e074e523368e5d0329421a95d3790c9dc2b8a4c67f7cdc24da2458e6293ffa3bcc31f82cde6e4359e8ba42762f7c0edfc719557a64d1d4&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014270&idx=2&sn=5594b43bbdf362068f40a30400c32c7a&chksm=83964e36b4e1c720995f079f20e930aa780cbd31975e9658e109de2129bd3d94e421c338ef74&mpshare=1&scene=1&srcid=0516QSTTe0Ic8A8dVb6ZyHFH&key=05bd214169ad157663f4ea6af22a60518c6fdfcfb608aeaed1b667390c29d848913956b7296e8b448d78d965f3e101b4ece2e971c35a9cb181bea413942fd6e427c9aceac2153dccf12544ba9659bd9e&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014272&idx=2&sn=edd418a6a80e3156b13b6b19012ccd37&chksm=83964e48b4e1c75e64a387cd90924765185a0cffc8bed4a775513d8aea7915ea7cee79199cff&mpshare=1&scene=1&srcid=0516lcmhOwkBFTPb5qmBzzcy&key=508fe9d2e44c5b791db8cd252ccf0bdacf7fedc388bc9de7125493f222293ea8fb54e89ec40188617ed5751d54302773c1ae5072468840129fdc90fb125ef653757ce6b55cdc28039008115b17364a8a&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDIwNDI2Mw==&mid=2650014272&idx=1&sn=fa2560603d78252ceb6cd1c5dc33a2b4&chksm=83964e48b4e1c75e14017edc1efed13a2a1bd7876f3fb6f8d671e77654e71c70768945c6743f&mpshare=1&scene=1&srcid=0516vF3n3YwjI8CSroO5nn1p&key=9603ff9ff537db22d5cd551de4a71d41f20e66c7af2fa4b3ce20771e7756490c43414cd8752a27017f05fe9a540265e126617392cec1e2d2595cfb11d75646a489b6be58ee57c5941d279fcc728e4382&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MjM5MTcyNzQ0MQ==&mid=2649941950&idx=1&sn=ff270cb21ecb073e22fba0207cba0672&chksm=beb76d8089c0e4965cda8d6a07cfb9c741d921afc721d7e8cd73e8dbc95bea7ffa1db66209cd&mpshare=1&scene=1&srcid=0516rvD0bsRaDd6QaTUqesbP&key=988a08a338a0a121b6f25245494536da7faab4f86624f398fb8bd146ef23633311f75a9215abf302917cd4a03b3e8cdcd2115b51ee5ef64e0245f625df45ddc90e6ba3d6f0ea834612759b601c0cc04b&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4"];

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
