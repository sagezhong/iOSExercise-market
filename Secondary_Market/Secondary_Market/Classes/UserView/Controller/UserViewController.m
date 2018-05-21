//
//  UserViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 19/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "UserViewController.h"
#import "LoginNavController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我";
    UIButton *quiteBtn = [[UIButton alloc] init];
    quiteBtn.frame = CGRectMake(125/2, 500, 250, 40);
    [quiteBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quiteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quiteBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1.0];
    [quiteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    quiteBtn.layer.cornerRadius = 5;
    [quiteBtn addTarget:self action:@selector(Quit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:quiteBtn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Quit {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool: NO forKey:@"haveLogin"];
    
    [userDefaults synchronize];
    
    LoginNavController *vc = [[LoginNavController alloc] init];
    
    [self presentViewController:vc animated:NO completion:nil];
    
    
    
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
