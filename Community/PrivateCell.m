//
//  PrivateCell.m
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "PrivateCell.h"

@implementation PrivateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImage.layer.cornerRadius = 20;
    self.headerImage.layer.masksToBounds = YES;
    self.lineimageView.hidden = YES;
    self.lineimageView.backgroundColor = Color_line;
    
    self.redimg.layer.cornerRadius = 4;
    self.redimg.layer.masksToBounds = YES;
    self.redimg.backgroundColor = [UIColor redColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NoteModel *)model
{
    _model = model;
    if ([model.is_class integerValue] == 1) {
        self.headerImage.image = [UIImage imageNamed:@"班级头像"];
    } else {
       [self.headerImage sd_setImageWithURL:[NSURL URLWithString:_model.headimgurl]];
    }
    
    self.nameLabel.text = _model.nickname;
    self.timeLabel.text = _model.addtime;
    self.contentLabel.text = _model.content;

}


@end








