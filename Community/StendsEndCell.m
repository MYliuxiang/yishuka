//
//  StendsEndCell.m
//  Community
//
//  Created by 刘翔 on 16/6/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "StendsEndCell.h"
#import "ClassroomDetailsVC.h"

@implementation StendsEndCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.huikeBtn.layer.cornerRadius = 2;
    self.huikeBtn.layer.masksToBounds = YES;

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
    self.noteLabel.text = [NSString stringWithFormat:@"备注：%@",_model.content];;
    self.palceLabel.text = [NSString stringWithFormat:@"地点：%@",_model.address];
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@-%@",_model.starttime,_model.endtime];
    
    [self setupAutoHeightWithBottomView:self.huikeBtn bottomMargin:20];
    
    
    if([self.model.is_course_mp4 intValue] == 1){
    
        //有回课
        [self.huikeBtn setTitle:@"查看回课" forState:UIControlStateNormal];
        [self.huikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.huikeBtn.userInteractionEnabled = YES;
        self.huikeBtn.backgroundColor = Color_nav;

        

    
    }else{
        

        self.huikeBtn.layer.borderColor = [UIColor redColor].CGColor;
        self.huikeBtn.layer.borderWidth = 1;
        self.huikeBtn.backgroundColor = [UIColor whiteColor];
     
        [self.huikeBtn setTitle:@"暂无回课" forState:UIControlStateNormal];
        self.huikeBtn.userInteractionEnabled = NO;
        [self.huikeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
      

    
    }
    

    
}


- (IBAction)HuiKe:(UIButton *)sender {
    
    ClassroomDetailsVC *vc = [[ClassroomDetailsVC alloc] init];
    vc.isketangji = YES;
    vc.textstr = self.model.title;
    vc.hid = self.model.mp4_id;
    vc.course_id = self.model.bid;
    [[self ViewController].navigationController pushViewController:vc animated:YES];
    
}


@end









