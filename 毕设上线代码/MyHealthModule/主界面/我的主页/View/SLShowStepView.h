//
//  ShowStepView.h
//  LeftSlide
//
//  Created by L on 17/2/20.
//  Copyright © 2017年 bairong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLShowStepView : UIView

- (instancetype)initWithFrame:(CGRect)frame currentStep:(NSInteger)step;

@property(nonatomic,assign)NSInteger averageStepNum;

@end
