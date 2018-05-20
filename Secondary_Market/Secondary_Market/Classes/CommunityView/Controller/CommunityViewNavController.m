//
//  CommunityViewNavController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 19/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "CommunityViewNavController.h"
#import "CommunityViewController.h"

@interface CommunityViewNavController ()

@end

@implementation CommunityViewNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor =  [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    CommunityViewController *vc = [[CommunityViewController alloc] init];
    [self addChildViewController:vc];
    return self;
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
