//
//  GoodsTableViewCell.h
//  Secondary_Market
//
//  Created by 史莱斯 on 28/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotoBrowser.h"

@interface GoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) PYPhotosView *goodsImage; //商品图片

@property (nonatomic, strong) UILabel *userName;      //用户名

@property (nonatomic, strong) UILabel *goodsPrice;    //商品价格

@property (nonatomic, strong) UIImageView *userImage;  //用户头像

@property (nonatomic, strong) UILabel *goodsName;   //商品标题

@property (nonatomic, strong) UILabel *goodsInfo;    //商品描述

@property (nonatomic, strong) UILabel *createTime;   //商品创建时间

- (void)setCellGoodsImage:(NSString *)string;

- (void)setCellUserName:(NSString *)string;

- (void)setCellGoodsPrice:(NSString *)string;

- (void)setCellGoodsName:(NSString *)string;

- (void)setCellCreateTime:(NSString *)string;

@end
