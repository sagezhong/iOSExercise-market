//
//  UserTableViewCell.h
//  Secondary_Market
//
//  Created by Maktub on 23/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userImageView; //用户头像

@property (nonatomic, strong) UILabel *userName; //用户昵称

@property (nonatomic, strong) UILabel *idName; //固定文本

@property (nonatomic, strong) UILabel *userId; //用户账号



@end
