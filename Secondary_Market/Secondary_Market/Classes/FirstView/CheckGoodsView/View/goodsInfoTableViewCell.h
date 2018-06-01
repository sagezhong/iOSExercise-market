//
//  goodsInfoTableViewCell.h
//  Secondary_Market
//
//  Created by Maktub on 1/6/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotoBrowser.h"

@interface goodsInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *goodsPrice;

@property (nonatomic, strong) UILabel *goodsTitle;

@property (nonatomic, strong) UILabel *goodsInfo;

@property (nonatomic, strong) PYPhotosView *goodsImage;


- (CGSize)setCellGoodsImage:(NSString *)string;

- (void)setCellGoodPrice:(NSString *)string;

- (void)setCellGoodsTitle:(NSString *)string;

- (void)setCellGoodsInfo:(NSString *)string;
@end
