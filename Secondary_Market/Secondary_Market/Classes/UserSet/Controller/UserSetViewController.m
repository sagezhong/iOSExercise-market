//
//  UserSetViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 24/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "UserSetViewController.h"
#import "LoginNavController.h"

@interface UserSetViewController ()

@end

@implementation UserSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *quiteBtn = [[UIButton alloc] init];
    quiteBtn.frame = CGRectMake(125/2, 500, 250, 40);
    [quiteBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quiteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quiteBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1.0];
    [quiteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
