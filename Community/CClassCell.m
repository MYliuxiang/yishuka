//
//  CClassCell.m
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "CClassCell.h"
#import "SendNoticeVC.h"

@implementation CClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ClassModel *)model
{
    _model = model;
    self.classLabel.text = _model.title;
    self.peopleLable.text = [NSString stringWithFormat:@"共%d人",[_model.count intValue]];
    self.techerLabel.text = [NSString stringWithFormat:@"授课老师：%@",_model.teacher_name];
    if ([_model.is_notice integerValue] == 0) {
        //学生
        self.gonggaoBtn.hidden = YES;
    }else{
    
        //老师
        self.gonggaoBtn.hidden = NO;
    
    }


}

- (IBAction)buttonAC:(id)sender {
    
    SendNoticeVC *vc = [[SendNoticeVC alloc] init];
    vc.model = self.model;
    [[self ViewController].navigationController pushViewController:vc animated:YES];
    
    
    
}
@end
