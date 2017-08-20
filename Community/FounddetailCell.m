//
//  FounddetailCell.m
//  Community
//
//  Created by lijiang on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FounddetailCell.h"

@implementation FounddetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _image_user.layer.cornerRadius = 25 / 2.0;
    _image_user.layer.masksToBounds = YES;
    _lineView.backgroundColor = Color_bg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
