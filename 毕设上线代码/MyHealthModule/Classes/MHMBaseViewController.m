//
//  ViewController.m
//  MyHealthModule
//
//  Created by L on 16/2/26.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMBaseViewController.h"
#import "UtilsMacro.h"
#import "UIView+Layout.h"

@interface MHMBaseViewController ()
@property (nonatomic, strong)UIButton *leftButton;
@end

@implementation MHMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = HEXCOLOR(0xf3f3f3);
    
    [self setupView];
    [self setupData];
    [self bindingData];
}

- (void)setupView {}

- (void)setupData {}

- (void)bindingData {}

@end
