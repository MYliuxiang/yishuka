//
//  friendsCell.m
//  Community
//
//  Created by 李江 on 16/4/12.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "friendsCell.h"

@implementation friendsCell




- (void)awakeFromNib {
    
    self.type.layer.masksToBounds = YES;
    self.type.textAlignment = NSTextAlignmentCenter;
    self.type.layer.cornerRadius = 10;
    self.Userimg.layer.cornerRadius = self.Userimg.height/2.0;
    self.Userimg.layer.masksToBounds = YES;
 
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
