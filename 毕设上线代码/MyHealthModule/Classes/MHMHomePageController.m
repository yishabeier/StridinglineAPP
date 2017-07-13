//
//  MHMHomePageController.m
//  MyHealthModule
//
//  Created by L on 16/2/26.
//  Copyright © 2016年. All rights reserved.
//

#import "MHMHomePageController.h"
#import "UtilsMacro.h"
#import "MHMDetailInfoController.h"
#import "MHMInfoSourceController.h"
#import <ReactiveCocoa.h>
#import "UIView+Layout.h"
#import "MHMLineChartView.h"
#import "MHMHealthManager.h"
#import "MHMHelper.h"

static NSInteger const topViewHeight = 60;
static NSString *kMHMNormalCellIdentifier = @"MHMNormalCellIdentifier";

@interface MHMHomePageController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *jumpControllers;
@property (nonatomic, strong) UISegmentedControl *dateSegmentControl;

@property (nonatomic, strong) MHMLineChartView *lineChartView;
@property (nonatomic, strong) MHMHealthManager *healthManager;

@property (nonatomic, strong) NSArray *listModels;
@property (nonatomic, strong) NSDictionary *dayResultDict;//存储日数据
@property (nonatomic, strong) NSDictionary *weekResultDict;//存储周数据
@property (nonatomic, strong) NSDictionary *monthResultDict;//存储月数据
@property (nonatomic, strong) NSDictionary *yearResultDict;//存储年数据
@property (nonatomic, assign) NSInteger dayAverage;//日/周对应的日平均值
@property (nonatomic, assign) NSInteger yearAverage;//年对应的日平均值

@property(nonatomic,strong) NSMutableArray *weekArray;//本周数据
@property(nonatomic,strong)NSMutableArray *mouthArray;//当月数据
@property(nonatomic,strong)NSMutableArray *yearArray;//当月数据

@property (nonatomic, assign) BOOL isShowAlert;
@end

@implementation MHMHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"健康数据";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"newNaBarBackgroundImage.png"] forBarMetrics:UIBarMetricsDefault];
    //setupView、setupData、bindingData这三个方法是放在基类中的viewDidLoad调用的，
    //子类中调用[super viewDidLoad]时会自动调用这三个方法
}

- (void)setupView {
    [self.view addSubview:self.tableView];
    
    [self setupTopView];
    
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.height = 200;
    self.tableView.tableHeaderView = tableHeaderView;
    
    [tableHeaderView addSubview:self.lineChartView];
    self.lineChartView.center = tableHeaderView.center;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)setupData {
    //一次性获取 日/周/月/年 数据并存储
    @weakify(self);
    [self fetchHealthData:MHMHealthIntervalUnitDay resultBlock:^(NSDictionary *queryResultDict) {
        @strongify(self);
        self.dayResultDict = queryResultDict;
//        NSLog(@"天数据是%@",self.dayResultDict);
    }];
    
    [self fetchHealthData:MHMHealthIntervalUnitWeek resultBlock:^(NSDictionary *queryResultDict) {
        @strongify(self);
        self.weekResultDict = queryResultDict;
        if (((NSArray *)queryResultDict[kResultModelsKey]).count <= 0) {
            return;
        }
        //日对应的日平均值和周一样
        self.lineChartView.averageStepCount = [queryResultDict[kTotalStepCountKey] integerValue] / ((NSArray *)queryResultDict[kResultModelsKey]).count;
        self.dayAverage = self.lineChartView.averageStepCount;//存储日/周对应的日平均值
        NSLog(@"日平局值是》》》》》》》》%ld",(long)self.dayAverage);
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSInteger dayAverage=self.dayAverage ;
        [defaults setInteger:dayAverage forKey:@"dayAverage"];
        
    }];
    
    [self fetchHealthData:MHMHealthIntervalUnitMonth resultBlock:^(NSDictionary *queryResultDict) {
        @strongify(self);
        self.monthResultDict = queryResultDict;

//        NSLog(@"月数据是%@",self.monthResultDict);

    }];
    
    [self fetchHealthData:MHMHealthIntervalUnitYear resultBlock:^(NSDictionary *queryResultDict) {
        @strongify(self);
        self.yearResultDict = queryResultDict;
//        NSLog(@"年数据是%@",self.yearResultDict);
        


        if (((NSArray *)queryResultDict[kResultModelsKey]).count <= 1) {
            return;
        }
        //存储年对应的日平均值
        self.yearAverage = [queryResultDict[kTotalStepCountKey] integerValue] / (self.listModels.count - 1);
    }];
}

- (void)bindingData {
    @weakify(self);
    [[self.dateSegmentControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl *segmentControl) {
        @strongify(self);
        __block NSDictionary *dict;
        switch (segmentControl.selectedSegmentIndex) {
            case 0:
                dict = self.dayResultDict;
                break;
            case 1:
                dict = self.weekResultDict;
                break;
            case 2:
                dict = self.monthResultDict;
                break;
            case 3:
                dict = self.yearResultDict;
                break;
        }
        if (dict) {
            [self.lineChartView setupChartWithDictionary:dict index:segmentControl.selectedSegmentIndex];
        } else {
            [self fetchHealthData:segmentControl.selectedSegmentIndex resultBlock:^(NSDictionary *queryResultDict) {
                dict = queryResultDict;
            }];
        }
        //选择为 日/年 的话，手动修改对应日平均值
        if (segmentControl.selectedSegmentIndex == 0) {
            self.lineChartView.averageStepCount = self.dayAverage;
        } else if (segmentControl.selectedSegmentIndex == 3) {
            self.lineChartView.averageStepCount = self.yearAverage;
        }
    }];
}

#pragma mark - custom Method
- (void)fetchHealthData:(MHMHealthIntervalUnit)unit
            resultBlock:(void (^)(NSDictionary *queryResultDict))resultBlock {
    if (![self.healthManager isHealthDataAvailable]) {
        [self showAlert:@"当前系统不支持健康数据获取"];
    } else {
        @weakify(self);
        [self.healthManager authorizateHealthKit:^(BOOL isAuthorizateSuccess) {
            @strongify(self);
            if (isAuthorizateSuccess) {
                if (!self.listModels) {//全部数据获取 这里只获取一次
                    [self.healthManager fetchAllHealthDataByDay:^(NSArray *modelArray) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (modelArray) {
                                self.listModels = modelArray;
                                
//                                NSLog(@"全部数据是%@", self.listModels);
                            }
                        });
                    }];
                }
                
                [self.healthManager fetchHealthDataForUnit:unit queryResultBlock:^(NSDictionary *queryResultDict) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (resultBlock) {
                            resultBlock(queryResultDict);
                        }
                        if (self.dateSegmentControl.selectedSegmentIndex == unit) {
                            [self.lineChartView setupChartWithDictionary:queryResultDict index:self.dateSegmentControl.selectedSegmentIndex];
                        }
                    });
                }];
                
               
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:F(@"请在隐私健康APP中允许%@读取数据", AppName)];
                });
            }
        }];
    }
}

- (void)showAlert:(NSString *)prompt {
    if (self.isShowAlert) {//提示语只显示一次，之后获取信息出现则不提示
        return;
    }
    
    ALERT(prompt, nil);
    self.isShowAlert = YES;
}

- (void)setupTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, topViewHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView addSubview:self.dateSegmentControl];
    self.dateSegmentControl.center = topView.center;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom - 0.5, topView.width, 0.5)];
    line.backgroundColor = RGB(185, 185, 185);
    [topView addSubview:line];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMHMNormalCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:kMHMNormalCellIdentifier];
    }
    
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];

//    cell.detailTextLabel.textColor = HEXCOLOR(0x0262bc);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 1) {
//        cell.textLabel.textColor = HEXCOLOR(0x2a2a2a);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.detailTextLabel.text = @"步";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.textLabel.textColor = HEXCOLOR(0x2a2a2a);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return cell;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        MHMDetailInfoController *vc = [[MHMDetailInfoController alloc] initWithListModels:self.listModels];
        NSLog(@"模型数据为 :%@",self.listModels);
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }

    if (indexPath.row == 1) {

        _weekArray=[self.weekResultDict objectForKey:@"resultModels"];
        MHMDetailInfoController *vc = [[MHMDetailInfoController alloc] initWithListModels:_weekArray];
        
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.row == 2) {

        _mouthArray=[self.monthResultDict objectForKey:@"resultModels"];
        _yearArray=[self.yearResultDict objectForKey:@"resultModels"];
        MHMDetailInfoController *vc = [[MHMDetailInfoController alloc] initWithListModels:_mouthArray];
        
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    Class class = self.jumpControllers[indexPath.row];
    MHMBaseViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topViewHeight, self.view.width, self.view.height - topViewHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (UISegmentedControl *)dateSegmentControl {
    if (!_dateSegmentControl) {
        NSArray *items = @[ @"日", @"周", @"月", @"年" ];
        _dateSegmentControl = [[UISegmentedControl alloc] initWithItems:items];
        _dateSegmentControl.selectedSegmentIndex = 0;
        _dateSegmentControl.frame = CGRectMake(0,30 , ScreenWidth - 8, 40);
        _dateSegmentControl.layer.cornerRadius = 5;
        _dateSegmentControl.tintColor = RGB(255, 128, 0);
    }
    return _dateSegmentControl;
}

- (MHMLineChartView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [[MHMLineChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 8, 182)];
    }
    return _lineChartView;
}

- (MHMHealthManager *)healthManager {
    if (!_healthManager) {
        _healthManager = [[MHMHealthManager alloc] init];
    }
    return _healthManager;
}

- (NSArray *)titles {
    return @[ @"显示所有数据", @"显示周数据",@"显示月数据" ,@"数据来源" ];
}

- (NSArray *)jumpControllers {
    return @[ [MHMDetailInfoController class], [MHMDetailInfoController class], [MHMDetailInfoController class],[MHMInfoSourceController class] ];
}
@end
