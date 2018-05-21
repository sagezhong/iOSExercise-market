//
//  LoginView.m
//  Secondary_Market
//
//  Created by Maktub on 20/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    //用户图标
    UIImage *userImage = [UIImage imageNamed:@"username"];
    self.userView = [[UIImageView alloc] initWithImage:userImage];
    
    //密码图标
    UIImage *passwordImage = [UIImage imageNamed:@"password"];
    self.passwordView = [[UIImageView alloc] initWithImage:passwordImage];
    
    
    
    //账户输入框
    self.userName = [[UITextField alloc] init];
    self.userName.frame = CGRectMake(75/2, 200, 300, 50);
    self.userName.placeholder = @"请输入你的账号";
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.leftView = self.userView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    self.userName.keyboardType = UIKeyboardTypeASCIICapable;
    self.userName.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.userName];

    //密码输入框
    self.password = [[UITextField alloc] init];
    self.password.frame = CGRectMake(75/2, 250, 300, 50);
    self.password.placeholder = @"请输入你的密码";
    self.password.secureTextEntry = YES;
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.leftView = self.passwordView;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    self.password.keyboardType = UIKeyboardTypeDefault;
    self.password.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.password];
    
    //用户头像
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    self.logo = [[UIImageView alloc] initWithImage:logoImage];
    self.logo.frame = CGRectMake(375/2-75/2, 100, 75, 75);
    [self addSubview:self.logo];
    
    //登录按钮
    self.loginBtn = [[UIButton alloc] init];
    self.loginBtn.frame = CGRectMake(75/2, 325, 300, 40);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1.0];
    [self.loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    self.loginBtn.layer.cornerRadius = 5;
    [self addSubview:self.loginBtn];
    
    //注册按钮
    self.registerBtn = [[UIButton alloc] init];
    self.registerBtn.frame = CGRectMake(70/2, 380, 40, 40);
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self addSubview:self.registerBtn];
    
    //忘记密码
    self.seekBtn = [[UIButton alloc] init];
    self.seekBtn.frame = CGRectMake(355-75/2-55, 380, 80, 40);
    [self.seekBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.seekBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.seekBtn setTitleColor:[UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    self.seekBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.seekBtn];
    
    
    

    
    
    
    
    return self;
}

@end
