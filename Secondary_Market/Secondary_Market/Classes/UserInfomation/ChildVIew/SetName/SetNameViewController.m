//
//  SetNameViewController.m
//  Secondary_Market
//
//  Created by 史莱斯 on 24/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "SetNameViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "TextFieldCell.h"

@interface SetNameViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITextField *userName;

@property (nonatomic, strong) TextFieldCell *cell;

@end

@implementation SetNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置名字";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)click {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [self.cell.setField text];
    NSString *name = [userDefaults objectForKey:@"name"];
    if ([userName isEqual:name]) {
        [SVProgressHUD showInfoWithStatus:@"请修改后再完成"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else if ([userName isEqual:@""]) {
        [SVProgressHUD showInfoWithStatus:@"用户名不能为空"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else {
        [self back];
    }
    
}

- (void)back {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *userID = [userDefaults objectForKey:@"id"];
        NSString *userName =[self.cell.setField text];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10.0f;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"id",userName,@"name", nil];
        [manager POST:@"http://119.23.230.116/xianyu/updateUserById/" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD showInfoWithStatus:@"修改成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic);
            
            
            [userDefaults setObject:userName forKey:@"name"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"连接服务器失败"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        
        
        
        
    });
    
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    self.cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    self.cell.setField.text = [userDefaults objectForKey:@"name"];
    
    
    
    return self.cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
}


@end
