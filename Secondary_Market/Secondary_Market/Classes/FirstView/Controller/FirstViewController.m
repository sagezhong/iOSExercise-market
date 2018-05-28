//
//  FirstViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 19/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "FirstViewController.h"
#import "SDCycleScrollView.h"
#import "GoodsTableViewCell.h"
#import "goodsInfoModel.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UINavigationBar *myBar;

@property (nonatomic, strong) UISearchBar *mySearchBar;

@property (nonatomic, strong) NSArray *imageM;

@property (nonatomic, strong) NSMutableArray *modelArray;

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
    
    //创建图片轮播器
    UIImage *image1 =[UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    UIImage *image3 = [UIImage imageNamed:@"3"];
    UIImage *image4 = [UIImage imageNamed:@"4"];
    UIImage *image5 = [UIImage imageNamed:@"5"];
    
    self.imageM = [NSArray arrayWithObjects:image1,image2,image3,image4,image5, nil];
    
    
    SDCycleScrollView *imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200) imageNamesGroup:self.imageM];
    
    _tableView.tableHeaderView =imageScrollView;
    
    

    [self.view addSubview: _tableView];
    [self.view addSubview:self.myBar];
    
    [self firstRequest];
    [self setRefreshControls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)firstRequest {
    
    //请求参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"status",@"1",@"pageNumber" ,nil];
    
    //发送请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:@"http://119.23.230.116/xianyu/GoodsList" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //把json转成字典
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"打印看看里面是什么%@",dict);
        //取出list中的json字符串
        NSString *goodsJson = [dict objectForKey:@"list"];
        
        NSArray *goodsArray;
        //把json字符串转成二进制流再转成数组
        NSData *jsonData = [goodsJson dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        goodsArray =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        
        
        //通过循环把数组付给模型 然后再给cell数组
        
        for (NSDictionary *item in goodsArray) {
            goodsInfoModel *model = [goodsInfoModel order];
            [model turnGoodsInfoToModel:item];
            
            [self.modelArray addObject:model];
        }
     
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"无法连接到服务器"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    
}

- (void)setRefreshControls {
    //设置下拉刷新 上啦加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self loadNewData];
        });
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
    //设置底部insert
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
}

//刷新方法loadNewDate
- (void)loadNewData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"status",@"1",@"pageNumber",nil];
    
    [manager POST:@"http://119.23.230.116/xianyu/GoodsList" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers |NSJSONReadingMutableLeaves error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        <#code#>
    }];
    
    
}

//加载方法loadMoreDate
- (void)loadMoreDate {
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

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
