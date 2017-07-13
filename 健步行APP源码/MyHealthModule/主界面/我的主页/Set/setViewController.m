//
//  setViewController.m
//  MyHealth
//
//  Created by L on 2017/4/10.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "setViewController.h"
#import "AboutViewController.h"
#import "FAQViewController.h"
#import "ModifyPasswdViewController.h"
@interface setViewController ()
@property (weak, nonatomic) IBOutlet UITableView *setTab;

@end

@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的设置";
    _setTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = @"";
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if(indexPath.row==0)
    {
        cell.textLabel.text=@"清除缓存";
    }
    if(indexPath.row==1)
    {
        cell.textLabel.text=@"使用说明";
//        cell.imageView.image=[UIImage imageNamed:@"acount"];
        

    }
    if(indexPath.row==2){
        cell.textLabel.text=@"关于我们";
//        cell.imageView.image=[UIImage imageNamed:@"paopao"];
    }
    if(indexPath.row==3){
        cell.textLabel.text=@"退出账户";
//        cell.imageView.image =[UIImage imageNamed:@"icon_username"];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"确定清除本地缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.tag=1;
        [alert show];
    }else if(indexPath.row==1){
        FAQViewController *faq=[[FAQViewController alloc]init];
        [self.navigationController pushViewController:faq animated:YES];
        
    }else if(indexPath.row==2){
        AboutViewController *about=[[AboutViewController alloc]init];
        [self.navigationController pushViewController:about animated:YES];
        
    }else{
        [self delete];
    }
}

-(void)delete{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认退出当前账户?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.tag=0;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag==0){
    if (buttonIndex==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"已登出" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:0 animated:NO];
    }
    }else{
        if (buttonIndex==1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"已清除" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [alert dismissWithClickedButtonIndex:0 animated:NO];
        }
    }
//        UserModel *userModel=[UserModel shareInstance];
//        userModel.sign=0;
////        [_keychain setObject:@"0" forKey:(id)kSecAttrLabel];
////        _array=@[@"到期提醒",@"2G/3G/4G下显示图片",@"常见问题",@"关于我们"];
//        
//        //清除用户本地头像
//        NSFileManager * fileManager = [[NSFileManager alloc] init];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];   // 保存文件的名称
//        [fileManager removeItemAtPath:filePath error:nil];
//        
//        
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        [user setBool:0 forKey:@"notion"];
//        [user setBool:1 forKey:@"show"];
//        [user synchronize]; //理解写入，否则会造成写入时间不确定
//        
//        [_setTab reloadData];
        return ;
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
