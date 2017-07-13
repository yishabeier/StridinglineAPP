//
//  MHMHealthDataSectionHeaderView.m
//  MyHealthModule
//
//  Created by 陈宪栋 on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMHealthDataSectionHeaderView.h"
#import "UtilsMacro.h"
#import "UIView+Layout.h"

@implementation MHMHealthDataSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf3f3f3);
        [self setupView];
    }
    return self;
}

- (void)setupView {
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, 60, 16)];
    stepLabel.text = @"步数";
    stepLabel.font = [UIFont systemFontOfSize:16.0];
    stepLabel.textColor = HEXCOLOR(0x6e6e6e);
    [self addSubview:stepLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(stepLabel.right, stepLabel.top, ScreenWidth - stepLabel.right - 15, stepLabel.height)];
    dateLabel.text = @"日期";
    dateLabel.textColor = HEXCOLOR(0x6e6e6e);
    dateLabel.textAlignment = NSTextAlignmentRight;
    dateLabel.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:dateLabel];
}

@end
