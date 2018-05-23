//
//  UserViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 19/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "UserViewController.h"
#import "LoginNavController.h"
#import "UserTableViewCell.h"
#import "UserInfoViewController.h"

@interface UserViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.title = @"我";
/*    UIButton *quiteBtn = [[UIButton alloc] init];
    quiteBtn.frame = CGRectMake(125/2, 500, 250, 40);
    [quiteBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quiteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quiteBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1.0];
    [quiteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    quiteBtn.layer.cornerRadius = 5;
    [quiteBtn addTarget:self action:@selector(Quit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:quiteBtn];
   */
    
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UserTableViewCell *cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
    return 1;
    }
    if (section == 1) {
        return 5;
    }
    else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UserInfoViewController *UserVC = [[UserInfoViewController alloc] init];
        [self.navigationController pushViewController:UserVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
