//
//  ModifyPasswdViewController.h
//  西邮图书馆
//
//  Created by bairong on 15/11/16.
//  Copyright © 2015年 bairong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@interface ModifyPasswdViewController : UIViewController<UITextFieldDelegate>{
    UserModel *_usermoel;
    UIAlertView *_baseAlert;
}
//重新输入密码
@property(retain,nonatomic)UITextField *nameField;
@property(retain,nonatomic)UITextField *passwdField;
@end
