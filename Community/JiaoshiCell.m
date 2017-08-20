//
//  JiaoshiCell.m
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "JiaoshiCell.h"

@implementation JiaoshiCell

- (void)awakeFromNib {
    // Initialization code
    
    self.connentLabel.font = [UIFont systemFontOfSize:14.0f];
    self.connentLabel.numberOfLines = 0;
    self.connentLabel.lineHeightMultiple = 1.2f;
    self.connentLabel.lineSpacing = 0.0f;
//    self.connentLabel.text = @"人生若只如初见，http://g.cn何事秋风悲http://baidu.com画扇。等闲变却故人心，dudl@qq.com却道故人心易变。13612341234骊山语罢清宵半，泪雨零铃终不怨。#何如 薄幸@锦衣郎，比翼连枝当日愿。";
    self.connentLabel.dataDetectorTypes = MLDataDetectorTypeAll;
    self.connentLabel.allowLineBreakInsideLinks = YES;
    self.connentLabel.linkTextAttributes = nil;
    self.connentLabel.activeLinkTextAttributes = nil;
    
  

}

- (void)setModel:(TeacherModel *)model
{
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headimgurl]];
    self.nameLabel.text = _model.name;
    self.connentLabel.text = [NSString stringWithFormat:@"%@\n教授课程 >",_model.cdescription];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n教授课程 >",_model.cdescription]];
  
    [attrStr addAttribute:NSLinkAttributeName value:@"123456" range:NSMakeRange(attrStr.length - 1 - 6, 7)];
//    [attrStr addAttribute:NSLinkAttributeName value:@"13612341234" range:NSMakeRange(10, 2)];
    //设置text之前针对自定义link样式的例子
    [self.connentLabel setBeforeAddLinkBlock:^(MLLink *link) {
        if (link.linkType == MLLinkTypeOther) {
            link.linkTextAttributes = @{NSForegroundColorAttributeName:Color_nav};
            link.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor lightGrayColor]};
        }
    }];
    self.connentLabel.attributedText = attrStr;
    
    //测试给一个含有链接的attrStr，并且自动检测其value所对应linkType
    self.connentLabel.dataDetectorTypesOfAttributedLinkValue = MLDataDetectorTypeAll;
    
    [self.connentLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
        
        
        KClassVC *texuVC = [[KClassVC alloc]init];
        texuVC.tmodel = model;
        texuVC.istc = YES;
        [[self ViewController].navigationController pushViewController:texuVC animated:YES];
        
        
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
