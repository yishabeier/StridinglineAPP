//
//  BottmViewController.m
//  LeftSlide
//
//  Created by L on 2017/4/18.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "BottmViewController.h"
#import "AppDelegate.h"
//#import "OtherController.h"
//#import "HaHaViewController.h"
#import "setViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "MainPageViewController.h"
#import "AddFootViewController.h"
#import "FootCountViewController.h"
@interface BottmViewController ()<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoHeadImage;
@property(strong,nonatomic)NSString  *imageField;

@end

@implementation BottmViewController
- (IBAction)onClickLogin:(id)sender {
    LoginViewController *loginVC =[[LoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}
- (IBAction)onClickRegister:(id)sender {
    RegisterViewController *registerVC =[[RegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initPhotoHeadImage];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"首页";
//        cell.imageView.image=[UIImage imageNamed:@"阅读"];
//    } else
    if (indexPath.row == 0) {
        cell.textLabel.text = @"设置";
        cell.imageView.image=[UIImage imageNamed:@"良品"];

    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"添加步数";
        cell.imageView.image=[UIImage imageNamed:@"碎片"];

    }else{
        cell.textLabel.text = @"步数计数器";
        cell.imageView.image=[UIImage imageNamed:@"阅读"];

    }
//    else if (indexPath.row == 3) {
//        cell.textLabel.text = @"个性装扮";
//    } else if (indexPath.row == 4) {
//        cell.textLabel.text = @"我的收藏";
//    } else if (indexPath.row == 5) {
//        cell.textLabel.text = @"我的相册";
//    } else if (indexPath.row == 6) {
//        cell.textLabel.text = @"我的文件";
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

//    if(indexPath.row ==0){
////        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        
//                    MainPageViewController *vc = [[MainPageViewController alloc] init];
//        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//        [tempAppDelegate.mainTabBarController.selectedViewController pushViewController:vc animated:NO];
//        
//    }else
    if(indexPath.row ==0){
        setViewController *myset=[[setViewController alloc]init];
        myset.hidesBottomBarWhenPushed=YES;
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainTabBarController.selectedViewController pushViewController:myset animated:NO];
       
    }else if (indexPath.row==1){
        AddFootViewController *addFoot=[[AddFootViewController alloc]init];
        addFoot.hidesBottomBarWhenPushed=YES;
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tempAppDelegate.mainTabBarController.selectedViewController pushViewController:addFoot animated:NO];
           }else{
               
//               AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//               
//               FootCountViewController *vc = [[FootCountViewController alloc] init];
//               
//               [tempAppDelegate.mainTabBarController.selectedViewController presentViewController:vc animated:YES completion:^{
//                   [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//               }];
               
               FootCountViewController *addFoot=[[FootCountViewController alloc]init];
               addFoot.hidesBottomBarWhenPushed=YES;
               [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
               [tempAppDelegate.mainTabBarController.selectedViewController pushViewController:addFoot animated:NO];
               


    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//- (void)imgButtonAction {
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    HaHaViewController *vc = [[HaHaViewController alloc] init];
//    
//    [tempAppDelegate.mainTabBarController.selectedViewController presentViewController:vc animated:YES completion:^{
//        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//    }];
//    
//}


-(void)initPhotoHeadImage{
    //给头像添加手势，选择照片
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhoto)];
    [_photoHeadImage  addGestureRecognizer:tap];
    _photoHeadImage.userInteractionEnabled=YES;
    
}
-(void)choosePhoto{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionPhoto=[UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        //开机拍照
        [self takePhoto:0];
    }];
    UIAlertAction *actionLibrary=[UIAlertAction actionWithTitle:@"从本地相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //本地相册中选择
        [self takePhoto:1];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:actionPhoto];
    [alert addAction:actionLibrary];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark 是否选择拍照
-(void)takePhoto:(NSInteger)index{
    switch (index) {
        case 0:
        {
            //唤醒相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                //创建图片选择器
                UIImagePickerController *picker=[[UIImagePickerController alloc]init];
                picker.delegate=self;
                //设置来源
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                //允许拍照
                picker.allowsEditing =YES;
                [self presentViewController:picker animated:YES completion:nil];
            }else{
                UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"nil" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *photoMessage=[UIAlertAction actionWithTitle:@"您的设备暂时不支持相机功能" style:UIAlertActionStyleDefault handler:nil];
                [alertVC addAction:photoMessage];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }
            break;
        case 1:{
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
                //创建图片选择器
                UIImagePickerController *picker =[[UIImagePickerController alloc]init];
                picker.delegate=self;
                picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                picker.allowsEditing=YES;
                [self presentViewController:picker animated:YES completion:nil];
            }else{
                UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"nil" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *photoMessage=[UIAlertAction actionWithTitle:@"您的设备暂时不支持相册功能" style:UIAlertActionStyleDefault handler:nil];
                [alertVC addAction:photoMessage];
                [self presentViewController:alertVC animated:YES completion:nil];
                
            }
            
        }
            break;
        default:
            break;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取编辑过的图片 选择图片
    UIImage *iconImage=info[UIImagePickerControllerEditedImage];
    //将图片写入沙盒
    NSString *homePath=[NSHomeDirectory() stringByAppendingString:@"/Documents"];
    NSString *imageViews   = [homePath stringByAppendingFormat:@"/%d.png", arc4random_uniform(1000000)];
    [UIImageJPEGRepresentation(iconImage, 1.0f) writeToFile:imageViews atomically:YES];
    self.imageField = imageViews;
    
    _photoHeadImage.image = iconImage;
    _photoHeadImage.layer.cornerRadius = 50;
    _photoHeadImage.layer.masksToBounds = YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
