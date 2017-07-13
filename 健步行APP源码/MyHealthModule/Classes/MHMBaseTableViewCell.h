//
//  MHMBaseTableViewCell.h
//  MyHealthModule
//
//  Created by 陈宪栋 on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHMBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
