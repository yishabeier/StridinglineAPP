//
//  UserModel.m
//  西邮图书馆
//
//  Created by bairong on 15/10/28.
//  Copyright © 2015年 bairong. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel *userModel=nil;

+(UserModel *)shareInstance{
    if (userModel==nil) {
        userModel=[[UserModel alloc] init];
    }
    return userModel;
}

@end
