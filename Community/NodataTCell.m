//
//  NodataTCell.m
//  Community
//
//  Created by 刘翔 on 16/6/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "NodataTCell.h"

@implementation NodataTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _add_Button.layer.cornerRadius = 2;
    _add_Button.layer.masksToBounds = YES;
    _add_Button.layer.borderWidth = 1;
    _add_Button.layer.borderColor = Color(252, 176, 42).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
