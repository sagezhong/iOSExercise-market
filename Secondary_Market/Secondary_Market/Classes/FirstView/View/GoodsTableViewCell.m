//
//  GoodsTableViewCell.m
//  Secondary_Market
//
//  Created by 史莱斯 on 28/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "GoodsTableViewCell.h"

@implementation GoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
     if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview {
    //用户头像
    _userImage = [[UIImageView alloc] init];
    _userImage.frame = CGRectMake(20, 20, 40, 40);
    [self addSubview:_userImage];
    
    
    //用户名字
    
    _userName = [[UILabel alloc] init];
    _userName.frame = CGRectMake(70, 20, 150, 20);
    _userName.font = [UIFont systemFontOfSize:18];
    _userName.textColor = [UIColor blackColor];
    
    [self addSubview:_userName];
    
    
    //发布时间
    _createTime = [[UILabel alloc] init];
    _createTime.frame = CGRectMake(70, 45, 150, 15);
    _createTime.font = [UIFont systemFontOfSize:13];
    _createTime.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_createTime];
    
    
    //商品价格
    _goodsPrice = [[UILabel alloc] init];
    _goodsPrice.frame = CGRectMake(self.bounds.size.width-80, 20, 80, 20);
    _goodsPrice.font = [UIFont systemFontOfSize:18];
    _goodsPrice.textColor = [UIColor redColor];
    
    [self addSubview:_goodsPrice];
    
    
    
    //图片
    
    _goodsImage = [[PYPhotosView alloc] init];
    _goodsImage.layoutType = 1;
    _goodsImage.py_x = 20;
    _goodsImage.py_y = 80;
    _goodsImage.photoMargin = 5;
    _goodsImage.photoWidth = 120;
    _goodsImage.photoHeight = 100;
    
    [self addSubview:_goodsImage];
    
    //商品标题
    _goodsName = [[UILabel alloc] init];
    _goodsName.frame = CGRectMake(20, 200, self.bounds.size.width, 20);
    [_goodsName setFont:[UIFont fontWithName:@"Helvetica_Bold" size:19]];
    _goodsName.textColor = [UIColor blackColor];
    
    [self addSubview: _goodsName];
    
}

- (void)setCellGoodsImage:(NSString *)string {
    //设置物品图片, NSString切割
    NSArray *array = [string componentsSeparatedByString:@"|"];
    _goodsImage.originalUrls = array;
    _goodsImage.thumbnailUrls = array;
}

- (void)setCellUserName:(NSString *)string {
    _userName.text = string;
}

- (void)setCellGoodsPrice:(NSString *)string {
    _goodsPrice.text = string;
}

- (void)setCellGoodsName:(NSString *)string {
    _goodsName.text = string;
}

- (void)setCellCreateTime:(NSString *)string {
    _createTime.text = string;
}





@end
