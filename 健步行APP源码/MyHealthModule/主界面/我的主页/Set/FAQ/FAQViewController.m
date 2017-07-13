//
//  FAQViewController.m
//  西邮图书馆
//
//  Created by bairong on 15/10/26.
//  Copyright © 2015年 bairong. All rights reserved.
//

#import "FAQViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "Head.h"
#define lengthsize 10
@interface FAQViewController ()

@end

@implementation FAQViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *view=(UIImageView *)[self.tabBarController.view viewWithTag:10];
    view.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImageView *view=(UIImageView *)[self.tabBarController.view viewWithTag:10];
    view.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tmpConstraints = [NSMutableArray array];
    [self initView];
    [self.view addConstraints:_tmpConstraints];
    // Do any additional setup after loading the view.
}
-(void)initView{
    self.title=@"常见问题";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lengthsize,lengthsize, WScreen-2*lengthsize,13*lengthsize)];
    headerImageView.backgroundColor=[UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1];
    headerImageView.layer.borderWidth =0;
    [headerImageView.layer setCornerRadius:10.0]; //设置矩圆角半径
    [self.view addSubview:headerImageView];
    
    UILabel *note = [[UILabel alloc] initWithFrame:CGRectMake(lengthsize, 0,WScreen-4*lengthsize , 13*lengthsize)];
    [note setText:@" 1. 使用软件需要注意什么?\n     在使用软件前需要允许获取健康数据的权限，在未经允许的条件下该软件上显示的数据将会有误。  "];
    [note setLineBreakMode:NSLineBreakByWordWrapping];
    [note setTextColor:[UIColor blackColor]];
    note.font=[UIFont fontWithName:@"Arial" size:14];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:note.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [note.text length])];
    note.attributedText = attributedString;
    note.numberOfLines = 0;
    [headerImageView addSubview:note];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(lengthsize,lengthsize*15, WScreen-2*lengthsize,15*lengthsize)];
    imageView.backgroundColor=[UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1];
    imageView.layer.borderWidth =0.0f;
    [imageView.layer setCornerRadius:10.0]; //设置矩圆角半径
    [self.view addSubview:imageView];

    
    UILabel *information = [[UILabel alloc] initWithFrame:CGRectMake(lengthsize,lengthsize,WScreen-4*lengthsize , 13*lengthsize)];
    [information setText:@" 2. 软件在加载数据的时候显示有时会很慢?\n     由于软件目前版本还存在着性能以及缓存优化的问题，所以给您带来的不便我们深表歉意，我们将会努力改善这方面的问题，谢谢您的使用！"];
    [information setLineBreakMode:NSLineBreakByWordWrapping];
    information.font=[UIFont fontWithName:@"Arial" size:14];
    [information setTextColor:[UIColor blackColor]];
    NSMutableAttributedString *attributedinformation = [[NSMutableAttributedString alloc] initWithString:information.text];
    NSMutableParagraphStyle *paragraphStyleinformation = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyleinformation setLineSpacing:7];//调整行间距
    
    [attributedinformation addAttribute:NSParagraphStyleAttributeName value:paragraphStyleinformation range:NSMakeRange(0, [note.text length])];
    information.attributedText = attributedinformation;
    information.numberOfLines = 0;
    [imageView addSubview:information];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
