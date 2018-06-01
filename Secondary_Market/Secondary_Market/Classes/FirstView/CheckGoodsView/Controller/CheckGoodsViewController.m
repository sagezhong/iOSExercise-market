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
#import "goodsInfoTableViewCell.h"


@interface CheckGoodsViewController () <UITableViewDelegate,UITableViewDataSource>

{
    CGFloat height;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) goodsInfoTableViewCell *cell;



@end

@implementation CheckGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    NSLog(@"看一下有没有值传过来   %@",self.checkGoodsModel.goodName);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    UIView *createView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    createView.backgroundColor = [UIColor whiteColor];
    createView.alpha = 0.7;
    
    UIButton *createBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 150, 30)];
    createBtn.layer.cornerRadius =5;
    [createBtn setTitle:@"留言" forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    createBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    [createBtn addTarget:self action:@selector(createOrder) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *createBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(375-170, 10, 150, 30)];
    createBtn1.layer.cornerRadius =5;
    [createBtn1 setTitle:@"购买" forState:UIControlStateNormal];
    [createBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    createBtn1.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    [createView addSubview:createBtn1];
    [createView addSubview:createBtn];
    [self.view addSubview:createView];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       return 70;
   }else {
       return height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    
    
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
    else {
        goodsInfoTableViewCell *cell = [[goodsInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSNumber *result = self.checkGoodsModel.goodPrice;
        [cell setCellGoodPrice:[NSString stringWithFormat:@"¥%@",result]];
        [cell setCellGoodsInfo:self.checkGoodsModel.goodInfo];
        [cell setCellGoodsTitle:self.checkGoodsModel.goodName];
        CGSize cellSize = [cell setCellGoodsImage:self.checkGoodsModel.goodImage];
        CGFloat a = 160;
        CGFloat b =cellSize.height;
        CGFloat c = 335;
        height = a + b - c;
        NSLog(@"%f",height);
        NSLog(@"%@",self.checkGoodsModel.goodImage);
        
        
        return cell;
    }
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
