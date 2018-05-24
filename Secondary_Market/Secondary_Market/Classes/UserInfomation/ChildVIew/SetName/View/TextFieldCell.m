//
//  TextFieldCell.m
//  Secondary_Market
//
//  Created by Maktub on 24/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.setField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, self.bounds.size.width+30, self.bounds.size.height)];
        self.setField.clearButtonMode = UITextFieldViewModeAlways;

        
        [self addSubview:self.setField];
        
        
        
    }
    
    return self;
}



@end
