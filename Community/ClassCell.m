//
//  ClassCell.m
//  Community
//
//  Created by lijiang on 16/4/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.teacherImg.layer.cornerRadius = self.teacherImg.height/2.0;
    self.teacherImg.layer.masksToBounds = YES;
    
    self.type.layer.cornerRadius = self.type.height/2.0;
    self.type.layer.masksToBounds = YES;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"查看通告详情"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    
    self.detail.attributedText = content;
    
    self.detail.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailAction)];
    [self.detail addGestureRecognizer:tap];
}


- (void)detailAction{

    NSLog(@"点击了");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
