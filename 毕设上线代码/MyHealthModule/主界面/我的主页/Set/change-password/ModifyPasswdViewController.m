//
//  ModifyPasswdViewController.m
//  西邮图书馆
//
//  Created by bairong on 15/11/16.
//  Copyright © 2015年 bairong. All rights reserved.
//

#import "ModifyPasswdViewController.h"
#import "Head.h"
#import "GMDCircleLoader.h"
#import "YFLRequestData.h"
#import "UserModel.h"
//#import "KeychainItemWrapper.h"
@interface ModifyPasswdViewController ()

@end
#define length 10
@implementation ModifyPasswdViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *view=(UIImageView *)[self.tabBarController.view viewWithTag:10];
    view.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImageView *view=(UIImageView *)[self.tabBarController.view viewWithTag:10];
    view.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView{
    
    self.title=@"修改密码";
    
    self.view.backgroundColor=[UIColor whiteColor];
    //根视图上加手势
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    
    tapGr.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapGr];
    _nameField=[[UITextField alloc] init];
    _nameField.frame=CGRectMake(2*length,2*length, WScreen-4*length, 4*length);
    _nameField.borderStyle=UITextBorderStyleRoundedRect;
    _nameField.backgroundColor=[UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1];
    _nameField.secureTextEntry=YES;
    _nameField.placeholder=NSLocalizedString(@"请输入新密码", nil);
    _nameField.font=[UIFont fontWithName:@"Helvetica" size:18];
//    _nameField.keyboardType=UIKeyboardTypePhonePad;
    _nameField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:_nameField];

    
    
    _passwdField=[[UITextField alloc] init];
    _passwdField.frame=CGRectMake(2*length,7*length, WScreen-4*length, 4*length);
    _passwdField.borderStyle=UITextBorderStyleRoundedRect;
    _passwdField.backgroundColor=[UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1];
    _passwdField.secureTextEntry=YES;
    _passwdField.placeholder=NSLocalizedString(@"请再次输入新密码", nil);
    _passwdField.font=[UIFont fontWithName:@"Helvetica" size:18];
//    _passwdField.keyboardType=UIKeyboardTypePhonePad;
    _passwdField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:_passwdField];

    
    UIButton *dlbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    dlbutton.frame=CGRectMake(2*length,14*length, WScreen-4*length, 5*length);
    [dlbutton.layer setMasksToBounds:YES];  //setMasksToBounds:方法告诉layer将位于它之下的laye都遮盖住。这是必须的，这样会使圆角不被遮，
    [dlbutton.layer setCornerRadius:10.0]; //设置矩圆角半径
    [dlbutton.layer setBorderWidth:1];   //边
    [dlbutton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:91/255.0 blue:86/255.0 alpha:1]];
    [dlbutton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [dlbutton setTitle:@"提交修改" forState:UIControlStateNormal];
    [dlbutton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dlbutton];

}
-(void)requestData{
 
    YFLRequestData *yfn=[[YFLRequestData alloc] init];
    [yfn monitor];
 

    
//    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:@"com.xiyoumobileiOS" accessGroup:nil];
//    NSString *userNumber=[keychain  objectForKey:(id)kSecAttrAccount];
//    NSString *userPasswd=[keychain objectForKey:(id)kSecValueData];
//
//    
    
    NSUserDefaults *defaut =[NSUserDefaults standardUserDefaults];
    NSString *userNumber=[defaut  objectForKey:@"userNumber"];
    NSString *userPasswd=[defaut  objectForKey:@"UserPasswd"];
    

    //请求参数
    NSString *numberStr=[NSString stringWithFormat:@"S%@",userNumber];
    NSMutableDictionary *params = [@{@"username":numberStr,@"password":userPasswd}   mutableCopy];
    NSString *strURL=[NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/login"];
    
    [YFLRequestData requestURL:strURL
                    httpMethod:@"GET"
                        params:params
                          file:nil
                       success:^(id data) {
                          
                           NSString *sessionStr=[data  objectForKey:@"Detail"];
                           [self requestUser:sessionStr];
                           
                       }
                          fail:^(NSError *error) {
                              if([yfn.statusStr isEqual:@"没有网络"]){
                                  [self performDismiss:@"网络连接失败"];
                                  
                                  return ;
                              }
                              [self performDismiss:@"密码修改失败,请重试"];
                              
                              return ;
                          }];
    
}
-(void)requestUser:(NSString *)session{
    //监听网络状态
    YFLRequestData *yfn=[[YFLRequestData alloc] init];
    [yfn monitor];
    
//    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:@"com.xiyoumobileiOS" accessGroup:nil];
//    NSString *userNumber=[keychain  objectForKey:(id)kSecAttrAccount];
//    NSString *userPasswd=[keychain objectForKey:(id)kSecValueData];
    
    NSUserDefaults *defaut =[NSUserDefaults standardUserDefaults];
    NSString *userNumber=[defaut  objectForKey:@"userNumber"];
    NSString *userPasswd=[defaut  objectForKey:@"UserPasswd"];

  
    
    
    //请求参数
    NSString *numberStr=[NSString stringWithFormat:@"S%@",userNumber];

    
    //请求参数
        NSMutableDictionary *params = [@{@"session":session,@"username":numberStr,@"password":userPasswd,@"newpassword":_nameField.text,@"repassword":_passwdField.text}   mutableCopy];
  
    [YFLRequestData requestURL:@"http://api.xiyoumobile.com/xiyoulibv2/user/modifyPassword"
                    httpMethod:@"GET"
                        params:params
                          file:nil
                       success:^(id data) {
                        
                           NSString *str=[data objectForKey:@"Detail"];
                        
                           if ([str isEqualToString:@"MODIFY_SUCCEED"]) {
                               [self performDismiss:@"密码修改成功"];
                           }
                           else if([str isEqualToString:@"INVALID_PASSWORD"]){
                               [self performDismiss:@"请重新登录,当前密码已失效"];
                           }
                           else if([str isEqualToString:@"DIFFERENT_PASSWORD"]){
                               [self performDismiss:@"新密码两次输入不一致"];
                           }
                           else{
                               [self performDismiss:@"密码修改失败,请重试"];
                           }
                         
                       }
                          fail:^(NSError *error) {
                              if([yfn.statusStr isEqual:@"没有网络"]){
                                  [self performDismiss:@"网络连接失败"];
                                  
                                  return ;
                              }
                              [self performDismiss:@"密码修改失败,请重试"];
                              
                              return ;
                              
                          }];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [_nameField resignFirstResponder];
    [_passwdField resignFirstResponder];
    
}

-(void)action:(UIButton *)sender{
    [_nameField resignFirstResponder];
    [_passwdField resignFirstResponder];

    
    if ([_nameField.text isEqual:@""]||[_passwdField.text isEqual:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入不能为空" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
        
        return ;
    }
    [self xuji];
}
-(void)xuji{
    
    if (SYSTEM_VERSION >= 8.0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认修改?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      
            [self requestData];
            [self initAlertView];

        }];
        [alertCtrl addAction:cancelAction];
        [alertCtrl addAction:okAction];
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }else{
        //这个else一定要写，否则会导致在ios8一下的真机crash
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认修改?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
    }

}
#pragma mark - UIAlertViewDelete
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
        [self requestData];
        [self initAlertView];
    }
}
-(void)initAlertView{
    
    _baseAlert=[[UIAlertView alloc] initWithTitle:@"正在修改" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [_baseAlert show];
    
    // Create and add the activity indicator
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.center = CGPointMake(_baseAlert.bounds.size.width / 2.0f, _baseAlert.bounds.size.height - 50.0f);
    aiv.color=[UIColor colorWithRed:255/255.0 green:91/255.0 blue:86/255.0 alpha:1.0];
    [aiv startAnimating];
    [_baseAlert setValue:aiv forKey:@"accessoryView"];
    
    return ;
    
}
- (void)performDismiss:(NSString *)resultString{
   
    if (SYSTEM_VERSION >= 8.0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:resultString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [alertCtrl addAction:okAction];
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }else{
        //这个else一定要写，否则会导致在ios8一下的真机crash
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:resultString delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
    }
    [_baseAlert dismissWithClickedButtonIndex:0 animated:NO];
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
