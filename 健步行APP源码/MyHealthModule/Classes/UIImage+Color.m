//
//  UIImage+Color.m
//  MyHealthModule
//
//  Created by jack zhou on 12/25/13.
//  Copyright (c) 2013 JZ. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithSolidColor:(UIColor *)color size:(CGSize)size
{
    NSParameterAssert(color);
    NSAssert(!CGSizeEqualToSize(size, CGSizeZero), @"Size cannot be CGSizeZero");
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // Create a context depending on given size
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    // Fill it with your color
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
