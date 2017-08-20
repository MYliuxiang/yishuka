//
//  CROneCell.m
//  Community
//
//  Created by 刘翔 on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "CROneCell.h"

@implementation CROneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = _headImageView.height / 2.0;
    self.headImageView.layer.masksToBounds = YES;
    self.commentLabel.textColor = Color_text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommentModel *)model
{
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headimgurl]];
    self.nameLabel.text = model.nickname;
    self.commentLabel.text = model.title;

}

@end














