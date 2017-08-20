//
//  ClassromeCell.m
//  Community
//
//  Created by 刘翔 on 16/3/27.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ClassromeCell.h"

@implementation ClassromeCell

- (void)awakeFromNib {
    // Initialization code
    _yinyingView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, (kScreenWidth - 10) / 2.0 - 10, 250 - 5)];
    _yinyingView.backgroundColor = [UIColor blackColor];
    _yinyingView.alpha = .7;
    _yinyingView.hidden = YES;
    [self.contentView addSubview:_yinyingView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(((kScreenWidth - 10) / 2.0 - 36) / 2.0, (250 - 40) / 2.0, 36, 40)];
    _imageView.image = [UIImage imageNamed:@"del_01"];
    _imageView.hidden = YES;
    [self.contentView addSubview:_imageView];
    
}

- (void)setModel:(KetangModel *)model
{
    
    _model = model;
    self.label2.text = _model.title;
    self.label3.text = [NSString stringWithFormat:@"%d次",[_model.read_count intValue]];
    self.label4.text = [NSString stringWithFormat:@"%d条评论",[_model.comment_count intValue]];
    self.label1.text = _model.agency_title;
    _timelable.text = _model.addtime;
    _timelable.textColor = Color_text;
    [self.thumb sd_setImageWithURL:[NSURL URLWithString:_model.thumb]];
    

}

@end
