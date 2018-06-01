//
//  goodsInfoTableViewCell.m
//  Secondary_Market
//
//  Created by Maktub on 1/6/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "goodsInfoTableViewCell.h"

@implementation goodsInfoTableViewCell

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
    
    //价格
    _goodsPrice = [[UILabel alloc] init];
    _goodsPrice.frame = CGRectMake(20, 20, 100, 20);
    _goodsPrice.font = [UIFont systemFontOfSize:17];
    _goodsPrice.textColor = [UIColor redColor];
    [self addSubview:_goodsPrice];
    
    //商品标题
    _goodsTitle = [[UILabel alloc] init];
    _goodsTitle.frame = CGRectMake(20, 45, 335, 20);
    _goodsTitle.textColor = [UIColor blackColor];
    [self addSubview:_goodsTitle];
    
    //商品信息
    _goodsInfo = [[UILabel alloc] init];
    _goodsInfo.frame = CGRectMake(20, 70, 335, 40);
    _goodsInfo.numberOfLines = 0;
    _goodsInfo.textColor = [UIColor grayColor];
    [self addSubview:_goodsInfo];
    
    
    _goodsImage = [PYPhotosView photosView];
    _goodsImage.py_x = 20;
    _goodsImage.py_y = 140;
    _goodsImage.autoLayoutWithWeChatSytle = NO;
    _goodsImage.photosMaxCol = 1;
    _goodsImage.photoMargin = 10;
    _goodsImage.photoWidth = 335;
    _goodsImage.photoHeight = 335;
    _goodsImage.oneImageFullFrame = NO;
    
    [self addSubview:_goodsImage];
    

}

- (CGSize)setCellGoodsImage:(NSString *)string {
    //设置物品图片, NSString切割
    //去掉string第一个字符
    NSArray *array;
    if (string.length > 1) {
        NSString *string1 =[string substringFromIndex:1];
        NSString *string2 = [string1 substringWithRange:NSMakeRange(0, [string1 length]-1)];
        array = [string2 componentsSeparatedByString:@"|"];
    } else {
        array = [string componentsSeparatedByString:@"|"];
    }
    
    
    
    
    self.goodsImage.originalUrls = array;
    self.goodsImage.thumbnailUrls = array;
    // NSLog(@"打印看一下%@",array);
    
    CGSize mysize = [self.goodsImage sizeWithPhotoCount:array.count photosState:0];
    NSLog(@"%f",mysize.width);
    NSLog(@"%f",mysize.height);
    return mysize;
    
}

- (void)setCellGoodPrice:(NSString *)string {
    
    self.goodsPrice.text = string;
}

- (void)setCellGoodsTitle:(NSString *)string {
    self.goodsTitle.text = string;
}

- (void)setCellGoodsInfo:(NSString *)string {
    self.goodsInfo.text = string;
}

@end
