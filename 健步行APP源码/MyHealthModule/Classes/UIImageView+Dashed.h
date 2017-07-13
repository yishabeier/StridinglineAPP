//
//  UIImageView+Dashed.h
//  StackRoom
//
//  Created by jack zhou on 14-3-1.
//  Copyright (c) 2014年 JZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Dashed)
- (void)creatDashedViewWithEachWidth:(float)eachWidth
                           lineColor:(UIColor *)lineColor;
@end
