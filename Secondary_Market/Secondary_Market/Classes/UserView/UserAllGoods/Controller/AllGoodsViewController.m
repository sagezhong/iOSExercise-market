//
//  AllGoodsViewController.m
//  Secondary_Market
//
//  Created by Maktub on 3/6/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "AllGoodsViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "AllgoodsModel.h"
#import "AllgoodsTableViewCell.h"
#import "CheckGoodsViewController.h"


@interface AllGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) NSMutableArray *nextArray;

@end



@implementation AllGoodsViewController


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
    
    self.title = @"我发布的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self.view addSubview:self.tableView];
    
    [self RefreshDate];
    [self setRefreshControls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRefreshControls {
    //设置下拉刷新 上啦加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self RefreshDate];
        });
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
    
    
    //设置底部insert
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
}


- (void)RefreshDate {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSString *userId = [userDefaults objectForKey:@"id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 3.0f;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"1",@"pageNumber",nil];
    
    [manager POST:@"http://119.23.230.116/xianyu/GoodsList" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //把json转成字典
        //  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers |NSJSONReadingMutableLeaves error:nil];
        //取出商品的json字符串
        NSArray *goodsArray = [responseObject objectForKey:@"list"];
        
        
        [self.modelArray removeAllObjects];
        
        //通过模型赋值
        
        for (NSDictionary *item in goodsArray) {
            NSLog(@"这是什么%@",item);
            [self.nextArray addObject:item];
            AllgoodsModel *model = [AllgoodsModel order];
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

- (void)loadMoreDate {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@"id"];
    
    NSInteger i = self.modelArray.count;
    NSInteger pagenumber;
    
    if ((i/10)*10 == i) {
        pagenumber = (i/10) + 1;
    }else {
        pagenumber = (i/10) + 2;
    }
    
    NSString *pagenumberStr = [NSString stringWithFormat:@"%ld",pagenumber];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"id",pagenumberStr,@"pageNumber" ,nil];
    
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
                AllgoodsModel *model = [AllgoodsModel order];
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
    AllgoodsTableViewCell * cell =(AllgoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[AllgoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    AllgoodsModel *myGoods = self.modelArray[indexPath.row];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CheckGoodsViewController *vc = [[CheckGoodsViewController alloc] init];
    [vc setModelWIthGoodsDictionry:self.nextArray[indexPath.row]];
    //  NSLog(@"打印看一下有没有%@",self.nextArray[indexPath.row]);
    NSLog(@"看一下索引正确吗%ld",(long)indexPath.row);
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

@end
