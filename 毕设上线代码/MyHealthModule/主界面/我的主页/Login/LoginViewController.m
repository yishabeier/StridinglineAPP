//
//  LoginViewController.m
//  MyHealth
//
//  Created by L on 2017/4/17.
//  Copyright © 2017年 bairong. All rights reserved.
//
#import "Head.h"
#import "LoginViewController.h"
#import "MainPageViewController.h"
@interface LoginViewController (){
    int accoutInt;
    int passwordInt;
    NSString *_accout;
    NSString *_pass;

}
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *account;

@property (weak, nonatomic) IBOutlet UIView *password;
@property (weak, nonatomic) IBOutlet UITextField *accoutField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation LoginViewController
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickButton:(id)sender {
    if([_accoutField.text length]==0 || [_passwordField.text length]==0){
        [self errorShow];
    }else if([_accoutField.text  isEqualToString:_accout ] || [_passwordField.text isEqualToString:_pass]){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"账户已登录" message:nil delegate:self cancelButtonTitle:@"OK,我知道了" otherButtonTitles:nil];
        [alertView show];
        }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"账户已登录" message:nil delegate:self cancelButtonTitle:@"OK,我知道了" otherButtonTitles:nil];
        [alertView show];
        
     }

//    [self.view removeFromSuperview];

}
- (IBAction)forgetButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _accout =@"bairong";
    _pass =@"123";
    
    self.account.layer.borderColor=[UIColor grayColor].CGColor;
    self.account.layer.borderWidth = 1;
    self.account.layer.cornerRadius = 6.0f;
    self.account.layer.masksToBounds = YES;
    
    self.password.layer.borderColor =[UIColor grayColor].CGColor;
    self.password.layer.borderWidth = 1;
    self.password.layer.cornerRadius = 6.f;
    self.password.layer.masksToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark textFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([textField isEqual:_passwordField]) {
        if ([_accoutField.text length] == 0 || [textField.text length] != 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }else if ([textField isEqual:_accoutField]) {
        if ([_passwordField.text length] == 0 || [textField.text length] != 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }
    return YES;
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

-(void)loginButtonHighLightStatus{
    _loginButton.backgroundColor=[UIColor colorWithRed:247/255.0 green:38/255.0 blue:43/255.0 alpha:1.0];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.userInteractionEnabled=YES;
}


-(void)loginButtonNormalStatus{
    _loginButton.backgroundColor=[UIColor grayColor];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _loginButton.userInteractionEnabled=NO;
    
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


@end
