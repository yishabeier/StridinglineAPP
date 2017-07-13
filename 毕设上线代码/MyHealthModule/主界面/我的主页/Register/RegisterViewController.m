//
//  RegisterViewController.m
//  LeftSlide
//
//  Created by L on 2017/4/19.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UIImagePickerControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mailView;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIButton *boyButton;
@property (weak, nonatomic) IBOutlet UIButton *girlButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoHeadImage;
@property(strong,nonatomic)NSString  *imageField;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@end

@implementation RegisterViewController
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)completeButton:(id)sender {
    NSLog(@"aaaa");
    if([_accountField.text length]==0 || [_passField.text length]==0){
        [self errorShow];
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"账户已注册" message:nil delegate:self cancelButtonTitle:@"OK,我知道了" otherButtonTitles:nil];
        [alertView show];
        
    }

}

-(void)errorShow{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"账号或密码输入不正确" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:defult];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)warningShow{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"账号或者密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:defult];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountView.layer.borderColor=[UIColor grayColor].CGColor;
    self.accountView.layer.borderWidth = 1;
    self.accountView.layer.cornerRadius = 6.0f;
    self.accountView.layer.masksToBounds = YES;
    
    self.mailView.layer.borderColor =[UIColor grayColor].CGColor;
    self.mailView.layer.borderWidth = 1;
    self.mailView.layer.cornerRadius = 6.f;
    self.mailView.layer.masksToBounds = YES;

    [self initBoyButton];
    [self initGirlButton];
    [self initPhotoHeadImage];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initBoyButton{
       // [_boyButton setImage:[UIImage imageNamed:@"boyNormal"] forState:UIControlStateNormal];
//    [_boyButton setBackgroundColor:[UIColor grayColor]];
//    [_boyButton setBackgroundColor:[UIColor colorWithRed:247/255.0 green:38/255.0 blue:43/255.0 alpha:1.0]];
//        [_boyButton setImage:[UIImage imageNamed:@"boySelect"] forState:UIControlStateSelected];
        [_boyButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        _boyButton.imageView.contentMode =UIViewContentModeCenter;
    }
-(void)initGirlButton{
//    [_girlButton setImage:[UIImage imageNamed:@"girlNormal"] forState:UIControlStateNormal];
//    [_girlButton setImage:[UIImage imageNamed:@"girlSelect"] forState:UIControlStateSelected];
//    [_girlButton setBackgroundColor:[UIColor grayColor]];
//    [_girlButton setBackgroundColor:[UIColor colorWithRed:247/255.0 green:38/255.0 blue:43/255.0 alpha:1.0]];
    [_girlButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    _girlButton.imageView.contentMode =UIViewContentModeCenter;
}
-(void)initBackButton{
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setImage:[UIImage imageNamed:@""  ]  forState:UIControlStateNormal];
   [ backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
}
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
#pragma mark Button的选择
-(void)select:(UIButton *)button{
    if(button ==_girlButton){
        _girlButton.enabled =NO;
        _boyButton.enabled=YES;
    }
    if(button==_boyButton){
        _boyButton.enabled=NO;
        _girlButton.enabled =YES;
        }
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
    _photoHeadImage.layer.cornerRadius = 45;
    _photoHeadImage.layer.masksToBounds = YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 35+235+200 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}


//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([textField isEqual:_passField]) {
        if ([_accountField.text length] == 0 || [textField.text length] != 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }else if ([textField isEqual:_accountField]) {
        if ([_passField.text length] == 0 || [textField.text length] != 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }
    return YES;
}
-(void)loginButtonHighLightStatus{
    _completeButton.backgroundColor=[UIColor colorWithRed:247/255.0 green:38/255.0 blue:43/255.0 alpha:1.0];
    [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _completeButton.userInteractionEnabled=YES;
}


-(void)loginButtonNormalStatus{
    _completeButton.backgroundColor=[UIColor grayColor];
    [_completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _completeButton.userInteractionEnabled=NO;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (buttonIndex==1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"已注册" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [alert dismissWithClickedButtonIndex:0 animated:NO];
        }
       }



-(void)goBack{
    
}
@end
