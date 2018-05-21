//
//  RegisterView.m
//  Secondary_Market
//
//  Created by Maktub on 21/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

- (instancetype)init
{
    self = [super init];
    
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    self.logo = [[UIImageView alloc] initWithImage:logoImage];
    self.logo.frame = CGRectMake(375/2-75/2, 100, 75, 75);
    [self addSubview:self.logo];
    
    //账户注册
    self.userName = [[UITextField alloc] init];
    self.userName.frame = CGRectMake(75/2, 200, 300, 50);
    self.userName.placeholder = @"请输入注册的账号";
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    self.userName.clearButtonMode = UITextFieldViewModeAlways;
    self.userName.returnKeyType = UIReturnKeyNext;
    [self addSubview:self.userName];
    
    //输入密码框
    self.password = [[UITextField alloc] init];
    self.password.frame = CGRectMake(75/2, 250, 300, 50);
    self.password.placeholder = @"请输入注册密码";
    self.password.secureTextEntry = YES;
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.keyboardType =UIKeyboardTypeDefault;
    self.password.returnKeyType = UIReturnKeyNext;
    self.password.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.password];
    
    //密码输入框2
    self.password2 = [[UITextField alloc] init];
    self.password2.frame = CGRectMake(75/2, 300, 300, 50);
    self.password2.placeholder = @"再次输入注册密码";
    self.password2.secureTextEntry = YES;
    self.password2.borderStyle = UITextBorderStyleRoundedRect;
    self.password.keyboardType =UIKeyboardTypeDefault;
    self.password2.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.password2];
    
    //注册按钮
    self.registerBtn = [[UIButton alloc] init];
    self.registerBtn.frame = CGRectMake(75/2, 375, 300, 40);
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1.0];
    [self.registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    self.registerBtn.layer.cornerRadius = 5;
    [self addSubview:self.registerBtn];
    
    
    
    
    
    return self;
}

@end
