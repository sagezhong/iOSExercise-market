//
//  CheckGoodsViewController.m
//  Secondary_Market
//
//  Created by Maktub on 31/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "CheckGoodsViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "MJRefresh.h"


@interface CheckGoodsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation CheckGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    NSLog(@"看一下有没有值传过来   %@",self.checkGoodsModel.goodName);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModelWIthGoodsDictionry:(NSDictionary *)dic {
    self.checkGoodsModel = [CheckGoodsModel order];
    [self.checkGoodsModel turnGoodsInfoToModel:dic];
    
    
    

}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = self.checkGoodsModel.userId;
    cell.detailTextLabel.text = self.checkGoodsModel.createTiem;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    UIImage * icon = [UIImage imageNamed:@"userImage"];
    CGSize itemSize = CGSizeMake(40, 40);//固定图片大小为36*36
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
    UIGraphicsEndImageContext();//*3
    
    return cell;
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
