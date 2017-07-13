//
//  VideoViewController.m
//  MyHealthModule
//
//  Created by L on 2017/5/16.
//
//

#import "VideoViewController.h"
#import "UIWebViewController.h"
#import "ToolsCell.h"
@interface VideoViewController ()
@property(strong,nonatomic)NSArray *imageArray;
@property(strong,nonatomic)NSArray *nameLabArray;
@property(strong,nonatomic)NSArray *titleLabArray;
@property(strong,nonatomic)NSArray *urlArray;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpdateData];
    // Do any additional setup after loading the view from its nib.
}
-(void)setUpdateData{
    self.imageArray =@[@"run-13.png",@"run-14.png",@"run-15.png",@"run-16.png",@"run-17.png",@"run-18.png",@"run-19.png",@"run-20.png",@"run-21.png",@"run-22.png",@"run-3.png",@"run-24.png",@"run-1.png",@"run-7.png",@"run-6.png"];
    self.nameLabArray=@[@"3分钟HIIT燃脂训练，你能做到这些吗？大写服！",@"当某天停止健身后，身体会逐渐退化到什么程度",@"4款高颜值减脂增肌餐",@"健身每天几分钟 划船式伏地挺身",@"初学者如何获得苗条身材？",@"7个登山跑变化，在家就可以练腹肌",@"终极目标：世界上最完美的男性身材就应该是这样",@"掌握了这个健身技巧，2秒钟让你举起更重的重量",@"健身|马甲线的练习手册",@"一个绳子练全身，超好用的TRX初级版教学",@"小力王告诉你为什么要颈前深蹲",@"腿部训练基础动作教学：仰卧斜板腿上举",@"诺顿博士教你练卧推，发达胸肌的王牌动作",@"零基础学倒立，美女示范哦",@"拜拜肉大作战，还我玲珑玉臂来"];
    self.titleLabArray=@[@"全球健身视频精选",@"全球健身视频精选",@"全球健身视频精选",@"全球健身视频精选",@"全球健身视频精选",@"全球健身视频精选",@"全球健身视频精选",@"全球健身视频精选",@"健身大咖视频站",@"看视频学健身",@"看视频学健身",@"看视频学健身",@"看视频学健身",@"看视频学健身",@"健身小视频"];
    self.urlArray=@[@"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083750&idx=4&sn=eeb1a7e2657ea8f23c95529fd084dce5&chksm=f2d46c8ec5a3e5987fa60a6715147ba31cfb60cb086022209466736610efc7b86a6e1593e199&mpshare=1&scene=1&srcid=0516PRjxILUbIFiuCNgXrPep&key=9603ff9ff537db226a3ffb11f2e9ef2743ac8100a6d91cbde46f9b4be41557548b3d5f5d3aac378811e58e30f68b67ce52788506a0e3310cc63c9dcfd96b4efb62bf4ce79006899e2ca17d474ac54685&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083830&idx=1&sn=f1faf8b6b352da7d67931d34d3ae136a&chksm=f2d46cdec5a3e5c8f752082905b08c66aae92288d54a7247f8d50d0e7c7e2893771aeda3cc8b&mpshare=1&scene=1&srcid=0516ObtvZzQspnGhub0N2JWj&key=9603ff9ff537db222547279f6ac58a58b40adbd349850060e264e51417821f2e4c1c12f1e8ab81f97df64d0ec747e9e90fd795fa48b90e70ed9d5c2d5db16396f96e94e5c18cf3386e61b267df4b4dbc&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083830&idx=4&sn=c81a0d636876070f56cc12b684a0fc0d&chksm=f2d46cdec5a3e5c826661559f1cd2e0d2f4a8ff34489750997b2ca73cda878c85c2f89e90d38&mpshare=1&scene=1&srcid=051664FU1weg92yAlghdZgzA&key=55ff6cf80764bb5ee4413ea8ea247fcd9e556c25abd127628ebcbe02dc09df2723295ea381eea1fba08c349976d9490c87c43eae3d048cfc4e0dbc5dfa00d338d32e89e5fb198907bb475b67d27cc68a&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083816&idx=4&sn=da2595517536d8f675e5212216a367e5&chksm=f2d46cc0c5a3e5d6d1af09629557b2ca29f5cc7c7612a9b7174a1c3ceccc46ebe971a760559a&mpshare=1&scene=1&srcid=0516BH71mkQ63ahEZ7JbvxnO&key=c5a58783da8d7ae19d26e7e547771faddf1a5a7d77c18d38d5ab3d374ae89c617e7cec9299e4276655b136b0b209528fe36b1b6f3fddee88b4e2640f1d0c5e9eef459126dedd289ca142cf8447ac799d&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083795&idx=3&sn=76b93d0c40f3e678dc846900fe43db8a&chksm=f2d46cfbc5a3e5eda7d4c04a6f8b4d4c2c1269863285782ffa4f2fae6e47a5f0f7e9db7dfb03&mpshare=1&scene=1&srcid=05167n2Au4tdURSIkQlo9KlW&key=13026cacabfccb69a2f510a18815dde11b0dad84be02a6d2da4369a168c983fe7f41e800a69ff36c52f999ecb563a780be6d0ff9bc2731d5b77a06f123da70d551271ac5d4ca616681e4a720cbb38cba&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083795&idx=4&sn=f5773ad619eb93315b53eaf2418e569e&chksm=f2d46cfbc5a3e5ed02a2da450d0456f569dba08416915f74f5583947af3c19e6fb50cd8bb5be&mpshare=1&scene=1&srcid=0516MvwrYxN0yuYI0O09tsSl&key=988a08a338a0a12120deebaf75778e508f2bf68b9879b5fdafa0b2bc744bbc1b31f9b9e897c0508d3438c4e2c87618ca4a5bff0585b240396e0181a15a20ec7f09e7659521bbb0e7d206dbe0b9546ea8&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083750&idx=1&sn=7f747044478ca0c2b2690553cee80883&chksm=f2d46c8ec5a3e598f4c23d3fbcc1862f214e1b7f655ad9ff472417ab873eb38c2db5223dfaf3&mpshare=1&scene=1&srcid=0516FYRCIrfNcEWS2yJi1L9C&key=508fe9d2e44c5b79f4142a4c258175355657d33c69b9512aa4fc316d4f120e4b34f66296d458c3fdb9712d728bb8082b3c4bd2232060c95b0dbf9a59d9bc9c6d88f975fa7b1d2a302f1f355029aa1222&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzI3MDEyNjE1MQ==&mid=2650083750&idx=3&sn=9835bc8c9e19869d49ed963aeafe82bf&chksm=f2d46c8ec5a3e598beb6a37681c05c3a56741087506d539b755ffb65776d7c69e3aeb890fb43&mpshare=1&scene=1&srcid=0516am6c7gCJxKUqv2yNTzGi&key=7d4eb0035f57fc87f84c77de7b7df2c47579c41dd3ecd65dfdecffbd879b7c2fc106db841caf6a9650199d94b9c56dfc375fb7139677ce0fafaefb46c0aa42635ace7beb06f7b5aa41e8465a83c190c4&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzIwMzA4MTM4Mw==&mid=2650369512&idx=1&sn=9c5aa37225474c45331596b5692913c6&chksm=8ed91e20b9ae9736f77d029db4d4eec2416eff7147f54188d64a5b44807b27fbe9998aea3ceb&mpshare=1&scene=1&srcid=0516pGrEK2cCsJe7VQEtG2uO&key=7d4eb0035f57fc87168d58aa12a301587985a46b897a416121aa3c67642a4607f33685c36e3d4cc7d26db544e29415d0d3c06ed611cafd23f73baf59dd0528cc1ea0214688af7878249f04f7eac85504&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDk3NzI0OA==&mid=2247483708&idx=1&sn=d8073e190122c532b3aa216fba772241&mpshare=1&scene=1&srcid=05168H9i71Iket2Jk9vcuhun&key=13026cacabfccb6933a6c7574cf2d548ab00a90c35f8b109f4237ba6d16afe96a69df6a0a3c202c4b1a49d09e03e9b8f7e8b657c6dc190a10409a674d9318faaa75e927a9643451be9dd78eb5766e0e1&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDk3NzI0OA==&mid=2247483702&idx=1&sn=31d1f80a0ed14ee29cfa04d5052cadda&mpshare=1&scene=1&srcid=0516vUonWinDfHbdvxRPXfhY&key=d324dc14f2336256f111283b58f5c327122562901d40eb963b9a8c01705ff2ca1326b75494a02201c703cbef4f96a9f8a7b42bcc4a0daf30a6fd3c6bc77b5432c8f51fc9734bcd912829a93ac999bd64&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDk3NzI0OA==&mid=2247483699&idx=1&sn=7dc928f9d7384666d773223f4d9be791&mpshare=1&scene=1&srcid=0516lfbLUUaKDbHLJ9fUDjAy&key=82f06b1a5367f39082fecad3c6d51db4a2245bf006b887162285fc8e2984d74493d98b89d3ca603af3a74fdc02b89692c9a6cc33b2e3be2762b1c2b6fb71b7681ae9b0c0bcccdc5e29fa2d4fada80ae6&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDk3NzI0OA==&mid=2247483693&idx=1&sn=67de7f8efa0e9b77a6626331c770a11e&mpshare=1&scene=1&srcid=05164BaUPEViZpfrkAaXdZIo&key=9603ff9ff537db22825e4338dc1a4cdc06bf5c42a68fdcb7034e3a2642d1527d244fb4b8f7dedf702920ae99fee1bb068d216b079a3b7758577331656be233c4559e14a6945ec085820aa0a8999c1e8f&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzAxNDk3NzI0OA==&mid=2247483686&idx=2&sn=c6e92129dbebe15449e987a3260578d8&mpshare=1&scene=1&srcid=0516rOL9C9dWxZzVbLMoRfId&key=5a2d2c76af59b62802a77630ce5309170c2f9c578e55cfdf990ab5f695e8adeecddfcd3c6c36bc8da3b9ffcc241b37a8dd5a58c8b1eb02c98d22e1b722ea107966278add38dcf392ad086b3c81541e7e&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4",
                    @"https://mp.weixin.qq.com/s?__biz=MzUzMjAxMDUxOQ==&mid=2247483835&idx=3&sn=a9ff5e749478c7ced17639b22b4c4636&chksm=fab882c3cdcf0bd592a06deef89a5147514de2b6712bbff42ebf03ec0ef0a63e1692be0ecced&mpshare=1&scene=1&srcid=0516OgARZbqKdlVcOFkR84jy&key=5a2d2c76af59b6284992d2890c4acbb72e07836105a11306c41d44926817d41caa2d2048e349f09133f935c55b596a74be6f5f62d5bb8ba398d151a533bcb444929339449aacaf09820cb66de7fad412&ascene=0&uin=MjAwNDA3ODMxMQ%3D%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.12.3+build(16D32)&version=12020010&nettype=WIFI&fontScale=100&pass_ticket=GeYfe9NxVSQiSnoyTjwGddQI8LCs8gXT48wm8Cb8dkYSv3jLweuKwGP9gNa0GBP4"];
    
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
