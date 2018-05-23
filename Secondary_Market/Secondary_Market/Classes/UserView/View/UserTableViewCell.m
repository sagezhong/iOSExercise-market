//
//  UserTableViewCell.m
//  Secondary_Market
//
//  Created by Maktub on 23/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 用户头像设置
        UIImage *userimage = [UIImage imageNamed:@"logo"];
        self.userImageView = [[UIImageView alloc] initWithImage:userimage];
        self.userImageView.frame = CGRectMake(20, 15, 60, 60);
        [self addSubview: self.userImageView];
        
        // 用户昵称
        self.userName = [[UILabel alloc] init];
        self.userName.frame = CGRectMake(100, 25, 200, 25);
        NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
        if ([[userDefaults objectForKey:@"name"]isEqual: @""]) {
            self.userName.text = @"未设置用户名";
        } else {
            self.userName.text = [userDefaults objectForKey:@"name"];
        }
        self.userName.textColor = [UIColor blackColor];
        self.userName.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.userName];
        
        //固定文本:账户
        self.idName = [[UILabel alloc] init];
        self.idName.frame = CGRectMake(100, 50, 40, 20);
        
        self.idName.text = @"账号：";
        self.idName.textColor = [UIColor blackColor];
        self.idName.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.idName];
        
        // 用户账号
        self.userId = [[UILabel alloc ] init];
        self.userId.frame = CGRectMake(140, 50, 150, 20);
        self.userId.font = [UIFont systemFontOfSize:12];
        self.userId.text = [userDefaults objectForKey:@"id"];
        self.userId.textColor = [UIColor blackColor];
        self.userId.textAlignment = NSTextAlignmentLeft;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self addSubview:self.userId];
        
        
    }
    return self;
}


@end
