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
    self.moneyView.frame = CGRectMake(150, 10, 75, 75);
    
    [self addSubview:self.moneyView];
    
    self.money = [[UILabel alloc] init];
    self.money.frame = CGRectMake(100, 100, 175, 40);
    self.money.font = [UIFont systemFontOfSize:30];
    self.money.textColor = [UIColor whiteColor];
    self.money.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.money];
    
    self.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    
    
    
    
    
    

}

@end
