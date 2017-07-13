//
//  AddFootViewController.m
//  MyHealthModule
//
//  Created by L on 2017/4/27.
//
//

#import "AddFootViewController.h"
#import <HealthKit/HealthKit.h>
#import "Head.h"
#import "ZSHealthKitManager.h"
#define SCREEN  [UIScreen mainScreen].bounds.size
#define Color_RGB(r,g,b,a) ([UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:(a)])
@interface AddFootViewController ()<UITextFieldDelegate>{
    UILabel *testLab1;
    UITextField *bushuTextField;
    UIView * _bgVC;
    UILabel * numberLabel;
    ZSHealthKitManager *_manager;


}
@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation AddFootViewController
-(void)viewWillDisappear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [ZSHealthKitManager shareInstance];
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];//获取写权限
        NSSet *readDataTypes = [self dataTypesToRead];//获取写权限
        
        self.healthStore = [[HKHealthStore alloc] init];
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"fail");
            }
        }];
    }
    [self initUIView];
}

-(void)initUIView{
    _bgVC = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _bgVC.backgroundColor = Color_RGB(247, 35, 42, 1);
    [self.view addSubview:_bgVC];
    [self setBgView];
    
    bushuTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN.width/2-50 , 100, 100, 30)];
//    [bushuTextField setFont:[UIFont systemFontOfSize:16]];
//    [bushuTextField setBorderStyle:UITextBorderStyleNone];
//    [bushuTextField setKeyboardType:UIKeyboardTypeNumberPad];
//    [bushuTextField setReturnKeyType:UIReturnKeyDone];
//    //    [bushuTextField setBackgroundColor:[UIColor grayColor]];
//    bushuTextField.delegate = self;
//    [bushuTextField setPlaceholder:@"步数"];
//    [self.view addSubview:bushuTextField];
    [bushuTextField setFont:[UIFont systemFontOfSize:15]];
    [bushuTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [bushuTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [bushuTextField setReturnKeyType:UIReturnKeyDone];
    bushuTextField.delegate = self;
    bushuTextField.placeholder=@"请输入步数";
    [self.view addSubview:bushuTextField];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame =CGRectMake(SCREEN.width/2-50, WScreen/2, 100, 30);
//    btn3.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:35.0/255.0 blue:42/255.0 alpha:1];
//    btn3.layer.cornerRadius=15;
//    btn3.layer.masksToBounds=YES;
    btn3.layer.borderWidth=1;
    btn3.layer.borderColor=[UIColor whiteColor].CGColor;
    [btn3 setTitle:@"确定添加" forState:UIControlStateNormal];
    btn3.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(changeTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:btn3];
//    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnBack.frame =CGRectMake(20, 30, 20, 15);
//    [btnBack setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
//    [btnBack addTarget:self action:@selector(goToBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view  addSubview:btnBack];

    
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, SCREEN.height/2+50, SCREEN.width/2.8, 50)];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    numberLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:numberLabel];
    
    UIButton * getbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getbtn.frame=CGRectMake(SCREEN.width/2-50, numberLabel.frame.origin.y+numberLabel.frame.size.height, 100, 30);
    getbtn.backgroundColor=[UIColor redColor];
    getbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [getbtn setTitle:@"查询步数" forState:UIControlStateNormal];
//    [getbtn addTarget:self action:@selector(getNewNumberClick) forControlEvents:UIControlEventTouchUpInside];
    [getbtn addTarget:self action:@selector(getNewNumberClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getbtn];
    
    
}
//-(void)goToBack{
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}
-(void)changeTest{
    if (bushuTextField.text && ![bushuTextField.text isEqualToString:@""]) {
        [self recordWeight:[bushuTextField.text doubleValue]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入步数" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)getNewNumberClick {
    [_manager authorizeHealthKit:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"success");
            [_manager getStepCount:^(double value, NSError *error) {
                NSLog(@"1count-->%.0f", value);
                NSLog(@"1error-->%@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    numberLabel.text=[NSString stringWithFormat:@"%.f步", value];
                });
            }];
        }
        else {
            
        }
    }];
    
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [bushuTextField resignFirstResponder];
}


- (NSSet *)dataTypesToWrite {
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObject:stepType];
}

- (NSSet *)dataTypesToRead {
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObjects:stepType , nil];
}


-(void)recordWeight:(double)step{
    //http://stackoverflow.com/questions/30753506/apple-health-kit-error-domain-com-apple-healthkit-code-5-authorization-not-dete
    //    categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    if ([HKHealthStore isHealthDataAvailable] ) {
        HKQuantity *stepQuantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:step];
        HKQuantitySample *stepSample = [HKQuantitySample quantitySampleWithType:stepType quantity:stepQuantity startDate:[NSDate date] endDate:[NSDate date]];
        __block typeof(self) weakSelf = self;
        [self.healthStore saveObject:stepSample withCompletion:^(BOOL success, NSError *error) {
            if (success) {
                __block typeof(weakSelf) strongSelf = weakSelf;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"步数已加上" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                    [alert show];
                    
                    strongSelf -> bushuTextField.text = @"";
                });
                
                NSLog(@"The data has print");
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加步数失败" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alert show];
                NSLog(@"The error is %@",error);
            }
        }];
    }
}


-(void)healthTest{
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    [healthStore requestAuthorizationToShareTypes:nil  readTypes:nil completion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
            return;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        });
        
    }];
}
- (void)setBgView {
    UIBezierPath * bPath = [UIBezierPath bezierPathWithRect:_bgVC.frame];
    UIBezierPath * aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(0, SCREEN.height/2+80)];
    [aPath addQuadCurveToPoint:CGPointMake(SCREEN.width, SCREEN.height/2+80) controlPoint:CGPointMake(SCREEN.width/2, SCREEN.height/2)];
    [aPath addLineToPoint:CGPointMake(SCREEN.width, SCREEN.height)];
    [aPath addLineToPoint:CGPointMake(0, SCREEN.height)];
    [aPath addLineToPoint:CGPointMake(0, SCREEN.height/2+80)];
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    [bPath appendPath:[aPath bezierPathByReversingPath]];
    layer.path = bPath.CGPath;
    [_bgVC.layer setMask:layer];
    
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
