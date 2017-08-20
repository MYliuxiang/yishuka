//
//  CourseListCell.m
//  Community
//
//  Created by 刘翔 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "CourseListCell.h"
#import "BaoMingVC.h"

@implementation CourseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView1.layer.cornerRadius = 3;
    self.imageView1.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonAC:(id)sender {
    
    BaoMingVC *vc = [[BaoMingVC alloc] init];
    vc.isbaoming = YES;
    [[self ViewController].navigationController pushViewController:vc animated:YES];
}
@end
