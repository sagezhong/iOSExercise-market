//
//  UserSetViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 24/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "UserSetViewController.h"
#import "LoginNavController.h"

@interface UserSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

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
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    
    //退出登录按钮
   /*
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
    
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 2;
    } else if (section == 3) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        cell.textLabel.text =@"帐号与安全";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"新消息通知";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"图片质量";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else {
            cell.textLabel.text = @"通用";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"帮助与反馈";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else {
            cell.textLabel.text = @"关于转转";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    } else if (indexPath.section == 3) {
        cell.textLabel.text = @"切换帐号";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    } else {
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        [self Quit];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
