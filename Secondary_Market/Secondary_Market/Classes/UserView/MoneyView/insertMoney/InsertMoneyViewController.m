//
//  InsertMoneyViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 1/6/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "InsertMoneyViewController.h"

@interface InsertMoneyViewController ()

@property (nonatomic, strong) UILabel *moneyNumeber;

@end

@implementation InsertMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *money = [userDefaults objectForKey:@"money"];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"零钱";
    
    UIImageView *moneyViwe = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"钱袋"]];
    moneyViwe.frame = CGRectMake(295/2, 100, 80, 80);
   // [self.view addSubview:moneyViwe];
    
    UILabel *moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(275/2, 200, 100, 20)];
    moneyLable.text = @"我的零钱";
    moneyLable.textAlignment = NSTextAlignmentCenter;
    
 //   [self.view addSubview:moneyLable];
    
    UILabel *moneyNumber = [[UILabel alloc] initWithFrame:CGRectMake(175/2, 220, 200, 80)];
    moneyNumber.text = [NSString stringWithFormat:@"¥%@",money];
    moneyNumber.textAlignment = NSTextAlignmentCenter;
    moneyNumber.font = [UIFont systemFontOfSize:50];
    self.moneyNumeber = moneyNumber;
 //   [self.view addSubview:moneyNumber];
    
    UIButton *insertBtn = [[UIButton alloc] initWithFrame:CGRectMake(75/2, 320, 300, 40)];
    insertBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:87/255.0 blue:89/255.0 alpha:0.85];
    [insertBtn setTitle:@"充值" forState:UIControlStateNormal];
    [insertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [insertBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    insertBtn.layer.cornerRadius = 5;
    
    [insertBtn addTarget:self action:@selector(insert) forControlEvents:UIControlEventTouchUpInside];
    
   // [self.view addSubview:insertBtn];
    
    UIScrollView *bgView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    bgView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-44);
    bgView.showsVerticalScrollIndicator = NO;
    [bgView addSubview:moneyViwe];
    [bgView addSubview:moneyLable];
    [bgView addSubview:self.moneyNumeber];
    [bgView addSubview:insertBtn];
    
    [self.view addSubview:bgView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insert {
    
    
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
