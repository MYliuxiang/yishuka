//
//  ClassTeamCell.m
//  Community
//
//  Created by lijiang on 16/4/15.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ClassTeamCell.h"

@implementation ClassTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.teacherImg.layer.masksToBounds = YES;
    self.teacherImg.layer.cornerRadius = self.teacherImg.height/2.0;
    
    self.type.layer.masksToBounds = YES;
    self.type.layer.cornerRadius = self.type.height/2.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
