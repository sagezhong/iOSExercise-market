//
//  CheckGoodsModel.h
//  Secondary_Market
//
//  Created by Maktub on 30/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckGoodsModel : NSObject

@property (nonatomic , strong) NSNumber *goodsId;   //订单编号

@property (nonatomic, strong) NSString *userId;    //订单用户id

@property (nonatomic, strong) NSString *goodName;  //物品名称;

@property (nonatomic, strong) NSString *goodImage; //物品图片

@property (nonatomic, strong) NSString *goodInfo;   //物品描述;

@property (nonatomic, strong) NSString *createTiem; //发布时间

@property (nonatomic, strong) NSNumber *goodPrice;   //价格

+ (instancetype)order;

- (CheckGoodsModel *)turnGoodsInfoToModel:(NSDictionary *)dict;

@end
