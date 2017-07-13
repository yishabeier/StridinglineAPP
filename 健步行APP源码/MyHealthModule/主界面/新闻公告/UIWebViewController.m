//
//  UIWebViewController.m
//  MyHealthModule
//
//  Created by L on 2017/5/10.
//
//

#import "UIWebViewController.h"

@interface UIWebViewController ()

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlWeb=self.urlWeb;
    UIWebView * webView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor=[UIColor blueColor];
    NSURL *url =[NSURL URLWithString:urlWeb];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
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
