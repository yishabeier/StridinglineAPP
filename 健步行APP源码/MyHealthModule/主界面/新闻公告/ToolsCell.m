//
//  ToolsCell.m
//  MyHealthModule
//
//  Created by L on 2017/5/10.
//
//

#import "ToolsCell.h"
@implementation ToolsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.nameLab = [[UILabel alloc] init];
       self.nameLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.nameLab.font = [UIFont systemFontOfSize:14];
        self.nameLab.highlightedTextColor = [UIColor whiteColor];
               [self.contentView addSubview:self.nameLab];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:self.titleLab];
               self.titleLab.textColor =[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
//        [PublicMethods hexStringToColor:@"#bbbbbb"];
        self.titleLab.highlightedTextColor = [UIColor whiteColor];
        self.headerImg = [[UIImageView alloc] init];
        
        self.lineImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.lineImg];
        
        //将图片设置为圆形
        self.headerImg.layer.masksToBounds=YES;
        //这一步有问题!!!!!!!!!!!
//        self.headerImg.layer.cornerRadius=40.0f; //设置为图片宽度的一半出来为圆形
//        self.headerImg.layer.borderWidth=2.0f; //边框宽度
//        self.headerImg.layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色
        [self.contentView addSubview:self.headerImg];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize cellSize = self.bounds.size;
    self.headerImg.frame = CGRectMake(15, 8, cellSize.height-5, cellSize.height-20);
    NSLog(@"cellSize.height ==%f",cellSize.height);
    float currX =self.headerImg.bounds.size.width+25;
    self.nameLab.frame = CGRectMake(currX, 11, cellSize.width-currX-70, 20);
    self.nameLab.numberOfLines=0;
    [self.nameLab sizeToFit];
    self.nameLab.lineBreakMode = NSLineBreakByWordWrapping; //根据单词进行换行

    float bottomL =self.nameLab.bounds.size.height+15;
    self.titleLab.frame = CGRectMake(currX,bottomL,cellSize.width-currX, 20);
    self.lineImg .frame = CGRectMake(10, cellSize.height-1, cellSize.width-20, 0.5);
//    [self.headerImg.layer setMasksToBounds:YES];
//    self.headerImg.layer.cornerRadius = (cellSize.height-20)/2;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
