//
//  SClasscell.m
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SClasscell.h"
#import "SendletterVC.h"

@implementation SClasscell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.statusLabel.layer.cornerRadius = 7.5;
    self.statusLabel.layer.masksToBounds = YES;
    self.thumbImageView.layer.cornerRadius = 45 / 2.0;
    self.thumbImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SModel *)model
{
    _model = model;
    self.label1.text = _model.name;
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:_model.headimgurl]];
    if ([_model.group intValue] == 2) {
        
        self.statusLabel.text = @"老师";
        self.statusLabel.backgroundColor = Color_nav;

    }else{
    
        self.statusLabel.text = @"学生";
        self.statusLabel.backgroundColor = Color(158, 203, 237);
    }

}

- (IBAction)buttonAC:(id)sender {
    
    SendletterVC *vc = [[SendletterVC alloc] init];
    vc.model = self.model;
    vc.headimgurl = self.model.headimgurl;
    [[self ViewController].navigationController pushViewController:vc animated:YES];
    
}
@end
