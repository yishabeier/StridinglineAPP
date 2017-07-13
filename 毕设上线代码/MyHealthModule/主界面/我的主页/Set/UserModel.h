//
//  UserModel.h
//  西邮图书馆
//
//  Created by bairong on 15/10/28.
//  Copyright © 2015年 bairong. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserModel : NSObject

@property(strong,nonatomic)NSMutableArray *myBorrowArray;
@property(strong,nonatomic)NSMutableArray *bookDetailArray;
@property(strong,nonatomic)NSMutableArray *searchDeatilArray;
@property(strong,nonatomic)NSMutableSet *timeSet;
@property(strong,nonatomic)NSMutableArray *department;

@property(strong,nonatomic)NSString *session;
@property(strong,nonatomic)NSString *libIdArray;

@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *idnumber;
@property(strong,nonatomic)NSString *password;
@property(strong,nonatomic)NSString *serviceName;
//表示当前账户 是否在处于登录状态
@property(assign,nonatomic)NSInteger sign;
@property(strong,nonatomic)NSString *idString;
@property(strong,nonatomic)NSString *barcodeString;

+(UserModel *)shareInstance;


@end
