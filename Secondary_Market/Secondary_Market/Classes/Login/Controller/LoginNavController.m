//
//  LoginNavController.m
//  Secondary_Market
//
//  Created by Maktub on 20/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "LoginNavController.h"
#import "LoginViewController.h"

@interface LoginNavController ()

@end

@implementation LoginNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.navigationBar.barTintColor =  [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self addChildViewController:vc];
    return self;
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
