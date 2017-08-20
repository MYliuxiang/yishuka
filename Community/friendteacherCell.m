//
//  friendteacherCell.m
//  Community
//
//  Created by 李江 on 16/4/12.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "friendteacherCell.h"

@implementation friendteacherCell

- (void)awakeFromNib {
  
    self.type.layer.masksToBounds = YES;
    self.type.layer.cornerRadius = self.type.height/2.0;
    self.teacherImg.layer.cornerRadius = self.teacherImg.height/2.0;
    self.teacherImg.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
