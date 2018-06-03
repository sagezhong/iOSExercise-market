//
//  CompleteViewController.m
//  Secondary_Market
//
//  Created by Maktub on 1/6/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "CompleteViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

#define myGraycolor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]
@interface CompleteViewController ()

@property (nonatomic, strong) UITextField *inputMoney;
@property (nonatomic, strong) UINavigationBar *myBar;

@end

@implementation CompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView  *bgView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    bgView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+1);
    bgView.showsVerticalScrollIndicator = NO;
    bgView.backgroundColor = myGraycolor;
    
    //各个子控件
    UIView *whiteBgView = [[UIView alloc] init];
    whiteBgView.frame = CGRectMake(15, 74, 340, 270);
    whiteBgView.backgroundColor = [UIColor whiteColor];
    
    // 银行卡文字
    UILabel *cardLabel = [[UILabel alloc] init];
    cardLabel.frame = CGRectMake(20, 20, 50, 20);
    cardLabel.text = @"储蓄卡";
    cardLabel.font = [UIFont systemFontOfSize:15];
    cardLabel.textColor = [UIColor blackColor] ;
    [whiteBgView addSubview:cardLabel];
    
    // 具体银行卡
    UILabel *bank = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 140, 20)];
    bank.text = @"工商银行(1234)";
    bank.font = [UIFont systemFontOfSize:15];
    bank.textColor = [UIColor lightGrayColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 300, 1)];
    lineView.backgroundColor = myGraycolor;
    [whiteBgView addSubview:lineView];
    [whiteBgView addSubview:bank];
    
    UILabel *insertMoney = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 80, 20)];
    insertMoney.text = @"充值金额";
    insertMoney.font = [UIFont systemFontOfSize:15];
    
    [whiteBgView addSubview:insertMoney];

    UILabel *fuhao = [[UILabel alloc] initWithFrame:CGRectMake(20, 125, 30, 30)];
    fuhao.text = @"¥";
    fuhao.font = [UIFont systemFontOfSize:30];
    
    [whiteBgView addSubview:fuhao];
    
    self.inputMoney = [[UITextField alloc] initWithFrame:CGRectMake(50, 125, 300, 40)];
    self.inputMoney.keyboardType = UIKeyboardTypeNumberPad;
    self.inputMoney.font = [UIFont systemFontOfSize:50];
  //  [[UITextField  appearance] setTintColor:[UIColor blackColor]];
    self.inputMoney.tintColor = [UIColor blackColor];
    
    [whiteBgView addSubview:self.inputMoney];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 300, 1)];
    lineView2.backgroundColor = myGraycolor;
    
    [whiteBgView addSubview:lineView2];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 300, 50)];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:0.85];
    btn.layer.cornerRadius = 5;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(money) forControlEvents:UIControlEventTouchUpInside];
    [whiteBgView addSubview:btn];
    
    
    
    
    
    
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navBar.barTintColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    //自定义导航栏的title，用UILabel实现
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"充值零钱";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    //设置title
    navItem.titleView = titleLabel;
    
    
    //创建左侧按钮
    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [navItem setLeftBarButtonItem:leftButton];
    navBar.tintColor = [UIColor whiteColor];
    [navBar pushNavigationItem:navItem animated:NO];
    self.myBar = navBar;
    [bgView addSubview:whiteBgView];
    [self.view addSubview:bgView];
    [self.view addSubview:self.myBar];
    [self.inputMoney becomeFirstResponder];
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

- (void)click {
    [self.inputMoney resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)money {
    NSString *money = [self.inputMoney text];
    if ([money isEqual:@""]) {
  
        [SVProgressHUD showInfoWithStatus:@"金额不能为空"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else {
        [self back];
    }
    
}

- (void)back {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *userID = [userDefaults objectForKey:@"id"];
        NSString *balance =[self.inputMoney text];
      //  double a = [balance doubleValue];
      //  NSString *tmp= [userDefaults objectForKey:@"balance"];
       // double b = [tmp doubleValue];
      //  double c = a + b;
      //  NSNumber *result = [NSNumber numberWithDouble:c];
        NSNumber *beforeMoney = [userDefaults objectForKey:@"balance"];
        
        double a = [balance doubleValue];
        double b = [beforeMoney doubleValue];
        double c = a + b;
        
        NSNumber *result = [NSNumber numberWithDouble:c];
        
        
        NSLog(@"%@",result);
        
        
        
        
      
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10.0f;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"id",result,@"balance", nil];
        [manager POST:@"http://119.23.230.116/xianyu/updateUserById/" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic);
            NSString *result1 = [dic objectForKey:@"data"];
            NSLog(@"看一看%@",result1);
            if ([result1 isEqual:@"更新成功"]) {
                
            
         
            [SVProgressHUD showInfoWithStatus:@"充值成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            [userDefaults setObject:result forKey:@"balance"];
            [self dismissViewControllerAnimated:YES completion:nil];
            }else {
                [SVProgressHUD showInfoWithStatus:@"充值失败，请重试"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"连接服务器失败"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        
        
    });
    
}

@end
