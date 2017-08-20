//
//  BullectinCell.m
//  Community
//
//  Created by 刘翔 on 16/3/24.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BullectinCell.h"
#import "SignVC.h"
#import "AddAnnouncementVC.h"
#import "RecordFinishVC.h"
#import "SignVC.h"
#import "SignAginVC.h"
@implementation BullectinCell

- (void)awakeFromNib {
    // Initialization code
//    self.button.layer.cornerRadius = 2;
//    self.button.layer.masksToBounds = YES;
    
   
    self.classLabel.textColor = Color_text;
    self.noteLabel.textColor = Color_text;
    self.palceLabel.textColor = Color_text;
    self.timeLabel.textColor = Color_text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(BulletiModel *)model
{
    _model = model;

    self.titleLabel.text = _model.title;
    self.classLabel.text = [NSString stringWithFormat:@"班级：%@",_model.class_name];
    self.noteLabel.text = [NSString stringWithFormat:@" 备注：%@",_model.content];;
    self.palceLabel.text = [NSString stringWithFormat:@"地点：%@",_model.address];
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@-%@",_model.starttime,_model.endtime];
    
    if ([_model.status intValue] == 2) {
        
        [self.statuesBtn setTitle:@"未上课" forState:UIControlStateNormal];
        
    }else{
    
        [self.statuesBtn setTitle:@"上课中" forState:UIControlStateNormal];
    
    }

}

@end
