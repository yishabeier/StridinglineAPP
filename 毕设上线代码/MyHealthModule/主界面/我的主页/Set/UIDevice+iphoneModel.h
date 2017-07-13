//
//  UIDevice+iphoneModel.h
//  西邮图书馆
//
//  Created by bairong on 15/11/20.
//  Copyright © 2015年 bairong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(int, IPhoneModel){//0~3
    iPhone4=0,//320*480
    iPhone5=1,//320*568
    iPhone6=2,//375*667
    iPhone6Plus=3,//414*736
    UnKnown
    
};
@interface UIDevice (iphoneModel)

+ (IPhoneModel)iPhonesModel;

@end
