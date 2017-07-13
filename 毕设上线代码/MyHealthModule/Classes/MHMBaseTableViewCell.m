//
//  MHMBaseTableViewCell.m
//  MyHealthModule
//
//  Created by 陈宪栋 on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMBaseTableViewCell.h"

@implementation MHMBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MHMBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCustomSubviews];
    }
    return self;
}

- (void)setupCustomSubviews {
    // 布局UI
}

@end
