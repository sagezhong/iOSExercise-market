//
//  goodsInfoModel.m
//  Secondary_Market
//
//  Created by Maktub on 28/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "goodsInfoModel.h"

@implementation goodsInfoModel

+ (instancetype)order {
    return [[self alloc] init];
}

- (goodsInfoModel *)turnGoodsInfoToModel:(NSDictionary *)dict {
    
    self.goodsId =[dict objectForKey:@"id"];
    
    self.userId = [dict objectForKey:@"userId"];
    
    self.goodName = [dict objectForKey:@"name"];
    
    self.goodInfo = [dict objectForKey:@"info"];
    
    self.goodImage = [dict objectForKey:@"image"];
    
    self.goodPrice = [dict objectForKey:@"price"];
    
    self.createTiem = [dict objectForKey:@"createtime"];
    
    return self;
    
}

@end
