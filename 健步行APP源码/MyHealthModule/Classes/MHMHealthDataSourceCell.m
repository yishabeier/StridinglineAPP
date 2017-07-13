//
//  MHMHealthDataSourceCell.m
//  MyHealthModule
//
//  Created by 陈宪栋 on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMHealthDataSourceCell.h"
#import "UIView+Layout.h"
#import "UtilsMacro.h"

@interface MHMHealthDataSourceCell ()
@property (nonatomic, strong) UIImageView *sourceImage;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MHMHealthDataSourceCell

- (void)setupCustomSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.sourceImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 34, 34)];
    self.sourceImage.image = [UIImage imageNamed:@"mhm_data_source"];
    [self.contentView addSubview:self.sourceImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sourceImage.right + 15, 0, ScreenWidth - self.sourceImage.right - 25, self.contentView.height)];
    self.titleLabel.text = @"苹果健康";
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.titleLabel];
}

@end
