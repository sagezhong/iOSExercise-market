//
//  UserInfoViewController.m
//  Secondary_Market
//
//  Created by Maktub on 23/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "UserInfoViewController.h"
#import "SetNameViewController.h"
#import "SetSexViewController.h"
#import "SetDepViewController.h"
#import "SetPhoneViewController.h"

@interface UserInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;



@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回多少组cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        cell.textLabel.text = @"用户名";
        if ([[userDefaults objectForKey:@"name"] isEqual:@""]) {
            cell.detailTextLabel.text = @"未设置";
        } else{
            cell.detailTextLabel.text = [userDefaults objectForKey:@"name"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.row == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        

        cell.textLabel.text = @"账号";
        cell.detailTextLabel.text = [userDefaults objectForKey:@"id"];
        
        return cell;
    } else if (indexPath.row == 2) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"性别";
        if ([[userDefaults objectForKey:@"sex"] isEqual:@""]) {
            cell.detailTextLabel.text = @"未设置";
        } else {
            cell.detailTextLabel.text = [userDefaults objectForKey:@"sex"];
        }
        
        return cell;
    } else if (indexPath.row == 3) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"系别";
        
        if ([[userDefaults objectForKey:@"department"] isEqual:@""]) {
            cell.detailTextLabel.text = @"未设置";
        } else {
            cell.detailTextLabel.text = [userDefaults objectForKey:@"department"];
        }
        return cell;
    }else if (indexPath.row == 4) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"手机号";
        if ([[userDefaults objectForKey:@"phone"] isEqual:@""]) {
            cell.detailTextLabel.text = @"未设置";
        } else {
            cell.detailTextLabel.text = [userDefaults objectForKey:@"phone"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"注册时间";
      /*  NSDictionary *timedic = [userDefaults objectForKey:@"registertime"];
        NSLog(@"%@",timedic); //打印看看
        
        NSString *year = [timedic objectForKey:@"year"];
        NSString *month = [timedic objectForKey:@"month"];
        NSString *day = [timedic objectForKey:@"day"];
        */
        NSString *time = [userDefaults objectForKey:@"registertime"];
        cell.detailTextLabel.text = time;
        
        

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.row ==0 ) {
        SetNameViewController *vc = [[SetNameViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = YES;
        
    } else if (indexPath.row ==2 ) {
        SetSexViewController *vc = [[SetSexViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    } else if (indexPath.row == 3) {
        SetDepViewController *vc = [[SetDepViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    } else if (indexPath.row == 4 ) {
        
        SetPhoneViewController *vc = [[SetPhoneViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        self.hidesBottomBarWhenPushed = YES;
        
    }
    

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
