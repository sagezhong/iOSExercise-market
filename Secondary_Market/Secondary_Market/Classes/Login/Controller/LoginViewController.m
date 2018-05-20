//
//  LoginViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 20/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "RootViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    _loginView = [[LoginView alloc] init];
    _loginView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    //给登录按钮注册登录事件
    
    [self.loginView.loginBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Login {
    NSString *url = @"http://119.23.230.116/xianyu/login?account=xiaoqiang&password=xiaoqiang";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
    
    
}

- (void) HaveInterner
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.loginView.userName resignFirstResponder];
    [self.loginView.password resignFirstResponder];
}

@end
