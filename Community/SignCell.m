//
//  SignCell.m
//  Community
//
//  Created by 刘翔 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SignCell.h"

@implementation SignCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.cornerRadius = 25;
    self.imageView.layer.masksToBounds = YES;
}

@end
