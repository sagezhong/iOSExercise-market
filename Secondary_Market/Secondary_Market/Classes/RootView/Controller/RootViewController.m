//
//  RootViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 19/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewNavigationController.h"
#import "CommunityViewNavController.h"
#import "MessageViewNavController.h"
#import "UserViewNavController.h"



@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mcTabbar = [[MCTabBar alloc] init];
    [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    _mcTabbar.tintColor = [UIColor colorWithRed:27.0/255.0 green:118.0/255.0 blue:208/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _mcTabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
    FirstViewNavigationController *nav1 = [[FirstViewNavigationController alloc] init];
    CommunityViewNavController *nav2 = [[CommunityViewNavController alloc] init];
    UINavigationController *navnull = [[UINavigationController alloc] init];
    MessageViewNavController *nav3 = [[MessageViewNavController alloc] init];
    UserViewNavController *nav4 = [[UserViewNavController alloc] init];
    
    nav1.title = @"首页";
    nav2.title = @"社区";
    nav3.title = @"消息";
    nav4.title = @"我";
    
   
    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
    [self addChildViewController:navnull];
    [self addChildViewController:nav3];
    [self addChildViewController:nav4];
    
    self.tabBar.tintColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabfirst_n"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabfirst_s"];
    
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabcm_n"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabcm_s"];
    
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabms_n"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabms_s"];
    
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabme_n"];
    nav4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabme_s"];
    

/*    MyTabBar *myTabBar = [[MyTabBar alloc] init];
    myTabBar.myTabBarDelegate = self;
         //利用KVC替换默认的TabBar
    [self setValue:myTabBar forKey:@"tabBar"];
 */
  
    //修改tabbar 文字颜色
/*
    NSMutableDictionary *atts=[NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = [UIColor blackColor];
    NSMutableDictionary *selectedAtts=[NSMutableDictionary dictionary];
    selectedAtts[NSFontAttributeName] = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    
    [nav1.tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    [nav1.tabBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
    
    [nav2.tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    [nav2.tabBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
    
    [nav3.tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    [nav3.tab/Users/shilaisi/Downloads/add.pngBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
    
    [nav4.tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    [nav4.tabBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];

*/
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction
{
    NSLog(@"点击");
    
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
