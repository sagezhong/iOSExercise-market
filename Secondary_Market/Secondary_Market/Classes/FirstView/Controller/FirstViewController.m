//
//  FirstViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 19/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UINavigationBar *myBar;

@property (nonatomic, strong) UISearchBar *mySearchBar;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    // tableView视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //自定义navbar
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navBar.barTintColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    //创建搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50/2, 10, 200, 44)];
    searchBar.placeholder = @"搜索商品";
    
    searchBar.showsCancelButton = NO;
    
    self.mySearchBar = searchBar;
    
 
    //自定义导航栏组件
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    
    // searchView 背景


    navItem.titleView = searchBar;
    
    //创建左侧按钮
  /*
    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [navItem setLeftBarButtonItem:leftButton];
  
*/
    [navBar pushNavigationItem:navItem animated:NO];
    self.myBar = navBar;

    [self.view addSubview: _tableView];
    [self.view addSubview:self.myBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = @"通知";
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.text = @"恭喜你注册成功";
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    UIImage *image = [UIImage imageNamed:@"通知"];
    cell.imageView.image = image;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.mySearchBar resignFirstResponder];
}



@end
