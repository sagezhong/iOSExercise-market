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
#import "CheckGoodsViewController.h"
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchBar *mySearchBar;

@property (nonatomic, strong) NSArray *imageM;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) NSMutableArray *nextArray;

@end

@implementation FirstViewController

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray *)nextArray {
    if (_nextArray == nil) {
        _nextArray = [NSMutableArray array];
    }
    return _nextArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    // tableView视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //自定义navbar
  //  UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
   // navBar.barTintColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    //创建搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 5, self.view.bounds.size.width-15, 30)];
    searchBar.placeholder = @"搜索商品";
    
    searchBar.showsCancelButton = NO;
    searchBar.delegate = self;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateHighlighted];


    
    self.mySearchBar = searchBar;
    for (UIView *view in self.mySearchBar.subviews) {
       
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
 
    //自定义导航栏组件
   // UINavigationItem *navItem = [[UINavigationItem alloc] init];
    
    // searchView 背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    bgView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:self.mySearchBar];
   
    self.navigationItem.titleView = bgView;
    
    //创建左侧按钮
  /*
    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [navItem setLeftBarButtonItem:leftButton];
  */

   // [navBar pushNavigationItem:navItem animated:NO];
   // self.myBar = navBar;
    
    //创建图片轮播器
    UIImage *image1 =[UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    UIImage *image3 = [UIImage imageNamed:@"3"];
    UIImage *image4 = [UIImage imageNamed:@"4"];
    UIImage *image5 = [UIImage imageNamed:@"5"];
    
    self.imageM = [NSArray arrayWithObjects:image1,image2,image3,image4,image5, nil];
    
    
    SDCycleScrollView *imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 170) imageNamesGroup:self.imageM];
    
    _tableView.tableHeaderView =imageScrollView;
    
    

    [self.view addSubview: self.tableView];
   // [self.view addSubview:self.myBar];
    
   [self firstRequest];
    [self setRefreshControls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void ) viewWillAppear:(BOOL)animated {
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateHighlighted];
}

- (void)firstRequest {
    
    //请求参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"status",@"1",@"pageNumber" ,nil];
    
    //发送请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain" ,nil];
    
    [manager POST:@"http://119.23.230.116/xianyu/GoodsList" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
     //   NSLog(@"%@",responseObject);
        //把json转成字典
    //    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        
    //    NSLog(@"打印看看里面是什么%@",dict);
        //取出list中的json字符串
       // NSString *goodsJson = [responseObject objectForKey:@"list"];
        NSArray *goodsArray = [responseObject objectForKey:@"list"];
        
      //  NSLog(@"这个是什么 %@",goodsArray);

        

        //把json字符串转成二进制流再转成数组
        //NSString *change = [goodsJson stringByReplacingOccurrencesOfString:@"(" withString:@"["];
        //NSString *result = [change stringByReplacingOccurrencesOfString:@")" withString:@"]"];
        
        
        
      //  NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
       // NSError *err;
        //goodsArray =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        
        
        //通过循环把数组付给模型 然后再给cell数组
        
        for (NSDictionary *item in goodsArray) {
            goodsInfoModel *model = [goodsInfoModel order];
            [model turnGoodsInfoToModel:item];
            [self.nextArray addObject:item];
            
            [self.modelArray addObject:model];
           
         //   NSLog(@"看一看NextArray%@",self.nextArray);
        }
      //  NSLog(@"看看数组有没有：%@",self.modelArray);
        [self.tableView reloadData];
        
        
        
        
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
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
}

//刷新方法loadNewDate
- (void)loadNewData {
    NSLog(@"刷新了吗");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 3.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"status",@"1",@"pageNumber",nil];
    
    [manager POST:@"http://119.23.230.116/xianyu/GoodsList" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //把json转成字典
      //  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers |NSJSONReadingMutableLeaves error:nil];
        //取出商品的json字符串
         NSArray *goodsArray = [responseObject objectForKey:@"list"];
        
        //把json转成二进制再转成数组
        

        
      //  NSData *jsonData = [goodsJson dataUsingEncoding:NSUTF8StringEncoding];
      //  NSError *err;
      //  goodsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        //移除当前数组
        [self.modelArray removeAllObjects];
        
        //通过模型赋值
        
        for (NSDictionary *item in goodsArray) {
            NSLog(@"这是什么%@",item);
            [self.nextArray addObject:item];
            goodsInfoModel *model = [goodsInfoModel order];
            [model turnGoodsInfoToModel:item];
            NSLog(@"model正常吗%@",model.goodsId);
            [self.modelArray addObject:model];
            
            
         
            
        }
        NSLog(@"数组正常吗%@",self.modelArray);
        //刷新 回调成功的话 重新给设置一次上拉加载，就没有如果加载全部后再刷新上拉不会加载的问题了。
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"无法连接到服务器"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    
    [self.tableView.mj_header endRefreshing];
}

//加载方法loadMoreDate
- (void)loadMoreDate {
    
    NSInteger i = self.modelArray.count;
    NSInteger pagenumber;
    
    if ((i/10)*10 == i) {
        pagenumber = (i/10) + 1;
    }else {
        pagenumber = (i/10) + 2;
    }
    
    NSString *pagenumberStr = [NSString stringWithFormat:@"%ld",pagenumber];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"status",pagenumberStr,@"pageNumber" ,nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:@"http://119.23.230.116/xianyu/GoodsList" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //把json转成字典
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //取出字典中的json字符串
        NSArray *goodsArray = [dict objectForKey:@"list"];
        
        
        
      
        if (goodsArray.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            //用模型赋值
            for (NSDictionary *item in goodsArray) {
                [self.nextArray addObject:item];
                goodsInfoModel *model = [goodsInfoModel order];
                [model turnGoodsInfoToModel:item];
                [self.modelArray addObject:model];
            }
        }
        [self.tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"无法连接到服务器"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    
    [self.tableView.mj_footer endRefreshing];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"打印看看%lu",(unsigned long)self.modelArray.count);
    return self.modelArray.count;
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell 的重用标识
    static NSString *cellID = @"goodsCell";
    //从重用队列中取出cell对象
    GoodsTableViewCell * cell =(GoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
  
    if (cell == nil) {
        cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    goodsInfoModel *myGoods = self.modelArray[indexPath.row];
    NSLog(@"看看mygoods%@",myGoods.userId);
    [cell setCellUserName:myGoods.userId];
    NSLog(@"看一下goodname%@",myGoods.goodName);
    [cell setCellGoodsName:myGoods.goodName];
    NSLog(@"看一下time%@",myGoods.createTiem);
    [cell setCellCreateTime:myGoods.createTiem];
    NSLog(@"看一下price%@",myGoods.goodPrice);
    [cell setCellGoodsPrice:myGoods.goodPrice];
    NSLog(@"看一下image%@",myGoods.goodImage);
    [cell setCellGoodsImage:myGoods.goodImage];
  
  //  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //cell.textLabel.text = @"测试";
//    [cell setCellUserName:@"测试"];
//    [cell setCellCreateTime:@"2018"];
//    [cell setCellGoodsName:@"测试"];
//    [cell setCellGoodsPrice:@"100"];
//    [cell setCellGoodsImage:@"https://wx1.sinaimg.cn/mw690/48fb9c13ly1frnz0c6739j2vr1kz.jpg|https://wx2.sinaimg.cn/mw690/48fb9c13ly1frnz0iz1lmj22z01zd1ky.jpg|https://winaimg.cn/mw690/48fb9c13ly1frnz0iz1lmj22z01zd1ky.jpg|https://wx2.sinaimg.cn/mw690/48fb9c13ly1frnz1tp20u00k0wip.jpg"];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  0.01;
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    /* 点击button时以动画效果出现cancelButton */
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CheckGoodsViewController *vc = [[CheckGoodsViewController alloc] init];
    [vc setModelWIthGoodsDictionry:self.nextArray[indexPath.row]];
   // NSLog(@"打印看一下有没有%@",self.nextArray[indexPath.row]);
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
     self.hidesBottomBarWhenPushed = NO;
  
}


@end
