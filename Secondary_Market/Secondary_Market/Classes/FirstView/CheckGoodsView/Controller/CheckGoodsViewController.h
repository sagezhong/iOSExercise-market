//
//  CheckGoodsViewController.h
//  Secondary_Market
//
//  Created by Maktub on 31/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckGoodsModel.h"

@interface CheckGoodsViewController : UIViewController

@property (nonatomic, strong) CheckGoodsModel *checkGoodsModel;



- (void)setModelWIthGoodsDictionry:(NSDictionary *)dic;

@end
