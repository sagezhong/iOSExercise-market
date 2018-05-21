//
//  RegisterViewController.m
//  Secondary_Market
//
//  Created by Maktub on 21/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UserInfomation.h"


@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    
    _registerView = [[RegisterView alloc] init];
    _registerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.registerView.registerBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _registerView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Register {
    
    NSString *password1 = [_registerView.password text];
    NSString *password2 = [_registerView.password2 text];
    BOOL result = [password1 isEqualToString: password2];
    
    
    if (_registerView.userName.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入用户名"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else if (_registerView.password.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else if (_registerView.password2.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入确认密码"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } else if (result == NO){
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    
    else {
        [self RegisterNetwork];
    }
    
}

- (void)RegisterNetwork{
    
    //异步任务主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *userStr = [_registerView.userName text];
        NSString *passStr = [_registerView.password text];
        
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10.0f;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
        
        //请求参数
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userStr,@"id",passStr,@"password", nil];
        [manager GET:@"http://119.23.230.116/xianyu/register/" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString *RegisterResult = [dict objectForKey:@"data"];
            NSLog(@"%@",RegisterResult);
            
            if ([RegisterResult isEqual:@"改用户已经注册"]) {
                [SVProgressHUD showInfoWithStatus:@"该账号已经被注册"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            if ([RegisterResult isEqual:@"注册成功"]) {
                [SVProgressHUD showInfoWithStatus:@"注册成功！请返回登录页面登录"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showInfoWithStatus:@"网络状态异常"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        
        
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.registerView.userName resignFirstResponder];
    [self.registerView.password2 resignFirstResponder];
    [self.registerView.password resignFirstResponder];
}

@end
