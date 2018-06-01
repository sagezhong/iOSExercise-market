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
#import "UserSetViewController.h"
#import "MoneyViewController.h"

@interface UserViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
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
//刷新tableView
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}



#pragma mark  - TableView代理方法
//返回多少组cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


//返回每组多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
    return 1;
    }
    if (section == 2) {
        return 5;
    }
    else {
        return 1;
    }
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
    UserTableViewCell *cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"我的钱包";
        cell.imageView.image = [UIImage imageNamed:@"钱包"];
       
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    } else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"我发布的";
            cell.detailTextLabel.text = @"0";
            cell.imageView.image = [UIImage imageNamed:@"发布"];
            
            return cell;
        } else if (indexPath.row == 1) {
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"我卖出的";
            cell.detailTextLabel.text = @"0";
            cell.imageView.image = [UIImage imageNamed:@"卖出"];
            
            return cell;
        } else if (indexPath.row ==2) {
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"我买到的";
            cell.detailTextLabel.text = @"0";
            cell.imageView.image = [UIImage imageNamed:@"购买"];
            
            return cell;
        }else if (indexPath.row == 3) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"我的收藏";
            cell.detailTextLabel.text = @"0";
            cell.imageView.image = [UIImage imageNamed:@"收藏"];
            
            return cell;
        } else {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"我的社区";
            cell.detailTextLabel.text = @"";
            cell.imageView.image = [UIImage imageNamed:@"互动社区"];
            
            return cell;
        }
        
    }
    else {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = @"设置";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:@"设置"];
        return cell;
    }
}

//设置每组cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

//选择cell后的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        self.hidesBottomBarWhenPushed = YES;
        UserInfoViewController *UserVC = [[UserInfoViewController alloc] init];
        [self.navigationController pushViewController:UserVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.section == 1) {
        self.hidesBottomBarWhenPushed = YES;
        MoneyViewController *vc = [[MoneyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.section == 3) {
        
        self.hidesBottomBarWhenPushed = YES;
        UserSetViewController *UserSetVC = [[UserSetViewController alloc] init];
        [self.navigationController pushViewController:UserSetVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
