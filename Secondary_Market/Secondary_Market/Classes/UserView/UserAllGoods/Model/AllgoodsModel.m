//
//  AllgoodsModel.m
//  Secondary_Market
//
//  Created by Maktub on 3/6/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "AllgoodsModel.h"

@implementation AllgoodsModel
+ (instancetype)order {
    return [[self alloc] init];
}

- (AllgoodsModel *)turnGoodsInfoToModel:(NSDictionary *)dict {
    
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
