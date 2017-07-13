//
//  MHMHealthDataCell.m
//  MyHealthModule
//
//  Created by 陈宪栋 on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMHealthDataCell.h"
#import "UIView+Layout.h"
#import "UtilsMacro.h"
#import "MHMHealthModel.h"

@interface MHMHealthDataCell ()
@property (nonatomic, strong) UIImageView *phoneImage;
@property (nonatomic, strong) UILabel *stepCountLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation MHMHealthDataCell

- (void)setupCustomSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 34, self.contentView.height - 10)];
    self.phoneImage.image = [UIImage imageNamed:@"mhm_phone_image"];
    [self.contentView addSubview:self.phoneImage];
    
    self.stepCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.phoneImage.right + 10, 0, 120, self.contentView.height)];
    self.stepCountLabel.font = [UIFont systemFontOfSize:15.0];
    self.stepCountLabel.textColor = HEXCOLOR(0x434343);
    [self.contentView addSubview:self.stepCountLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stepCountLabel.right, 0, ScreenWidth - self.stepCountLabel.right - 15, self.contentView.height)];
    self.dateLabel.font = [UIFont systemFontOfSize:15.0];
    self.dateLabel.textColor = HEXCOLOR(0x808080);
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.dateLabel];
}

- (void)setHealthModel:(MHMHealthModel *)healthModel {
    _healthModel = healthModel;
    
    NSDateComponents *startComponents = healthModel.startDateComponents;
    self.dateLabel.text = F(@"%zd年%zd月%zd日", startComponents.year, startComponents.month, startComponents.day);
    self.stepCountLabel.text = F(@"%zd", healthModel.stepCount);
}

@end
