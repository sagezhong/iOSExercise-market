//
//  MoneyTableViewCell.m
//  Secondary_Market
//
//  Created by Maktub on 31/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "MoneyTableViewCell.h"

@implementation MoneyTableViewCell

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
        [self addSubViews];
    }
    return self;
}

- (void) addSubViews {
    
   
    self.moneyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"钱"]];
    self.moneyView.frame = CGRectMake(335/2, 20, 40, 40);
    
    [self addSubview:self.moneyView];
    
    self.money = [[UILabel alloc] init];
    self.money.frame = CGRectMake(275/2, 70, 100, 20);
    self.money.font = [UIFont systemFontOfSize:15];
    self.money.textColor = [UIColor whiteColor];
    self.money.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.money];
    
    
    self.moneyNumber = [[UILabel alloc] initWithFrame:CGRectMake(275/2, 90, 100, 20)];
    self.moneyNumber.font = [UIFont systemFontOfSize:15];
    self.moneyNumber.textColor = [UIColor lightGrayColor];
    self.moneyNumber.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.moneyNumber];
    
    self.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:0.85];
    
    
    
    
    
    

}

@end
