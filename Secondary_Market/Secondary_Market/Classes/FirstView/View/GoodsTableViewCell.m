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
    self.userImage = [[UIImageView alloc] init];
    self.userImage.frame = CGRectMake(20, 20, 40, 40);
    UIImage *image = [UIImage imageNamed:@"userImage"];
    self.userImage.image =image;
    [self addSubview:self.userImage];
    
    
    //用户名字
    
    self.userName = [[UILabel alloc] init];
    self.userName.frame = CGRectMake(70, 20, 150, 20);
    self.userName.font = [UIFont systemFontOfSize:18];
    self.userName.textColor = [UIColor blackColor];
    
    [self addSubview:self.userName];
    
    
    //发布时间
    self.createTime = [[UILabel alloc] init];
    self.createTime.frame = CGRectMake(70, 45, 150, 15);
    self.createTime.font = [UIFont systemFontOfSize:13];
    self.createTime.textColor = [UIColor lightGrayColor];
    
    [self addSubview:self.createTime];
    
    
    //商品价格
    self.goodsPrice = [[UILabel alloc] init];
    self.goodsPrice.frame = CGRectMake(self.bounds.size.width-70, 20, 100, 20);
    self.goodsPrice.font = [UIFont systemFontOfSize:18];
    self.goodsPrice.textColor = [UIColor redColor];
    self.goodsPrice.textAlignment = NSTextAlignmentRight;
    
    
    
    [self addSubview:self.goodsPrice];
    
    
    
    //图片

    
    self.goodsImage = [[PYPhotosView alloc] init];

    self.goodsImage.py_x = 20;
    self.goodsImage.py_y = 80;
    self.goodsImage.autoLayoutWithWeChatSytle = NO;
    self.goodsImage.photosMaxCol = 10;
    self.goodsImage.photoMargin = 20;
    self.goodsImage.photoWidth = 120;
    self.goodsImage.photoHeight = 100;
    self.goodsImage.oneImageFullFrame = NO;
  //  self.goodsImage.placeholderImage = [UIImage imageNamed:@"userImage"];
    [self addSubview:self.goodsImage];
   
    
    //商品标题
    self.goodsName = [[UILabel alloc] init];
    self.goodsName.frame = CGRectMake(20, 200, self.bounds.size.width, 20);
    
    self.goodsName.textColor = [UIColor blackColor];
    
    [self addSubview: self.goodsName];
    
}

- (void)setCellGoodsImage:(NSString *)string {
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
    NSLog(@"打印看一下%@",array);
    
    CGSize mysize = [self.goodsImage sizeWithPhotoCount:array.count photosState:0];
    NSLog(@"%f",mysize.width);
    NSLog(@"%f",mysize.height);
   
}

- (void)setCellUserName:(NSString *)string {
    self.userName.text = string;
}

- (void)setCellGoodsPrice:(NSNumber *)string {
    self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",string];
}

- (void)setCellGoodsName:(NSString *)string {
    self.goodsName.text = string;
}

- (void)setCellCreateTime:(NSString *)string {
    self.createTime.text = string;

}





@end
