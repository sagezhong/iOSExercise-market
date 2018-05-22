//
//  UserInfomation.m
//  Secondary_Market
//
//  Created by 史莱斯 on 21/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "UserInfomation.h"

@implementation UserInfomation

+ (void)saveUserInfomation:(NSDictionary *)userDictionry
{
    NSString *userID = [userDictionry objectForKey:@"id"];     //用户id 为学号
    if ([userID isKindOfClass:[NSNull class]]) {
        userID = @"";                     //默认为空
    }
    
    NSString *loginPassword = [userDictionry objectForKey:@"password"]; //用户密码
    if ([loginPassword isKindOfClass:[NSNull class]]) {
        loginPassword = @"";   //默认为空
    }
    
    NSString *userName = [userDictionry objectForKey:@"name"]; //用户名
    if ([userName isKindOfClass:[NSNull class]]) {
        userName = @"";   //默认为空
    }
    
    NSString *userDepartment = [userDictionry objectForKey:@"department"];
    if ([userDepartment isKindOfClass:[NSNull class]]) {
        userDepartment = @"";
    }
    
    NSString *userPhone =  [userDictionry objectForKey:@"phone"];   //用户手机
    if ([userPhone isKindOfClass:[NSNull class]]) {
        userPhone = @"";
    }
    
    NSString *userSex = [userDictionry objectForKey:@"sex"];  //用户性别
    if ([userSex isKindOfClass:[NSNull class]]) {
        userSex = @"";
    }
    
    NSDate *userRegisterTime = [userDictionry objectForKey:@"registertime"];
    if ([userRegisterTime isKindOfClass:[NSNull class]]) {
        userRegisterTime = [[NSDate alloc] init];                              // 用户注册时间
    }
    

    
    //存储用户信息
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userID forKey:@"id"];
    [userDefaults setObject:loginPassword forKey:@"password"];
    [userDefaults setObject:userPhone forKey:@"phone"];
    [userDefaults setObject:userName forKey:@"name"];
    [userDefaults setObject:userSex forKey:@"sex"];
    [userDefaults setObject:userDepartment forKey:@"department"];
    [userDefaults setObject:userRegisterTime forKey:@"registertime"];
  //  [userDefaults setObject:userDic forKey:@"userInformation"];
    [userDefaults synchronize];
    
    //通过这样封装 取用户数据先从userDefaults取出 userInformation对应的字典, 再从字典中取出用户信息
    
    
    
}
@end















