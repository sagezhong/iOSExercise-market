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
#import "SVProgressHUD.h"
#import "UserInfomation.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _loginView = [[LoginView alloc] init];
    _loginView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    //给登录按钮注册登录事件
    
    [self.loginView.loginBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registerBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_loginView];
    

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//按下注册按钮
- (void)Register
{
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//按下登录按钮
- (void)Login {
    if (_loginView.userName.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入你的用户名"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } else if (_loginView.password.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    else {
        [self LoginNetwork];
    }
    
}
// 登录访问
- (void)LoginNetwork {
    // 异步任务主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *userStr = [_loginView.userName text];
        NSString *passStr = [_loginView.password text];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10.0f;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain" ,nil];
        
        //请求参数
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userStr,@"id",passStr,@"password", nil];
        
        [manager GET:@"http://119.23.230.116/xianyu/login/" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //打印结果
           // NSLog(@"结果%@",responseObject);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           //  NSLog(@"返回结果: %@",dict);
            
            NSString *LoginResult = [dict objectForKey:@"data"];
            NSDictionary *userdict = [dict objectForKey:@"user"];
            NSLog(@"%@",LoginResult);
            NSLog(@"%@",userdict);
            NSLog(@"%@",[userdict objectForKey:@"name"]);
            
            if ([LoginResult isEqual: @"没有此账号"]) {
                [SVProgressHUD showInfoWithStatus:@"该用户尚未注册"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
           else if ([LoginResult isEqual:@"密码错误"]) {
               
                [SVProgressHUD showInfoWithStatus:@"账户或密码错误"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            
           else if ([LoginResult isEqual:@"登录成功"]) {
                [SVProgressHUD showInfoWithStatus:@"登录成功"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                
                // 存储用户的信息
                
              // NSDictionary *userdic = [NSDictionary dictionaryWithObjectsAndKeys:userStr,@"id",passStr,@"password", nil];
               
              // NSLog(@"%@",userdic);
                [UserInfomation saveUserInfomation:userdict];
                // 更改用户登录状态
              
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setBool:YES forKey:@"haveLogin"];
               
                [userDefaults synchronize];
               // 打印用户注册时间
           //    NSDate *date = [userDefaults objectForKey:@"registertime"];
            //   NSLog(@"date:%@",date);

              
              
                NSLog(@"检测登录成功");
               
               //跳转至 首页
               RootViewController *vc = [[RootViewController alloc] init];
               [self presentViewController:vc animated:YES completion:nil];
            
                
                
                
            }
            
            // NSLog(@"date结果是:%@",LoginResult);
            
            //
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            [SVProgressHUD showInfoWithStatus:@"网络状态异常"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
            });
            
            
            
        }];
        
        
    });
    
    
/*  页面跳转
    RootViewController *vc = [[RootViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
*/
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
