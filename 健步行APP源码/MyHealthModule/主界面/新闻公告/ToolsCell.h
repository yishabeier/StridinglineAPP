//
//  ToolsCell.h
//  MyHealthModule
//
//  Created by L on 2017/5/10.
//
//

#import <UIKit/UIKit.h>

@interface ToolsCell : UITableViewCell
{
    CGFloat width;
    CGFloat height;
}
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *headerImg;//头像
@property(nonatomic,strong)UIImageView *lineImg;
@end
