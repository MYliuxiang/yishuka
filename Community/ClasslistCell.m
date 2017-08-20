//
//  ClasslistCell.m
//  Community
//
//  Created by 李立 on 16/5/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ClasslistCell.h"
#import "SendnoticeViewController.h"
@implementation ClasslistCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //1.创建子视图
        [self initCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

//1.创建子视图
-(void)initCell
{
    //班级图片
    _classImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 40, 40)];
    _classImageView.backgroundColor = [UIColor greenColor];
    _classImageView.layer.masksToBounds = YES;
    //描边
    _classImageView.layer.cornerRadius = 40/2; //圆角（圆形）
    [self.contentView addSubview:_classImageView];
    
    //班级
    _classLabel = [[UILabel alloc]initWithFrame:CGRectMake(_classImageView.right+5, _classImageView.top, 200, 20)];
    _classLabel.font = [UIFont boldSystemFontOfSize:14];
    _classLabel.textColor = [UIColor blackColor];
    _classLabel.text = @"朝阳少年宫舞蹈班2015级班";
    [self.contentView addSubview:_classLabel];
    
    //人数
    _peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_classImageView.right+5, _classLabel.bottom, 200, 20)];
    _peopleLabel.textAlignment = NSTextAlignmentLeft;
    _peopleLabel.font = [UIFont systemFontOfSize:14];
    _peopleLabel.textColor = [UIColor grayColor];
    _peopleLabel.text = @"共12人";
    [self.contentView addSubview:_peopleLabel];
    
    //授课老师
    _teacherLabel = [[UILabel alloc]initWithFrame:CGRectMake(_classImageView.right+5, _peopleLabel.bottom+5, 200, 20)];
    _teacherLabel.textAlignment = NSTextAlignmentLeft;
    _teacherLabel.font = [UIFont systemFontOfSize:14];
    _teacherLabel.textColor = [UIColor grayColor];
    _teacherLabel.text = @"授课老师:张薪薪";
    [self.contentView addSubview:_teacherLabel];
    
    
    _fabuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fabuButton.frame = CGRectMake(kScreenWidth-80, 80/2.0-10, 60, 20);
    _fabuButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_fabuButton setTitle:@"发公告" forState:UIControlStateNormal];
    [_fabuButton addTarget:self action:@selector(fabuButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_fabuButton setTitleColor:Color_nav forState:UIControlStateNormal];
    [self.contentView addSubview:_fabuButton];
    
}

//发公告按钮
-(void)fabuButtonAction
{
    SendnoticeViewController *sendnoticeVC = [[SendnoticeViewController alloc]init];
    [self.ViewController.navigationController pushViewController:sendnoticeVC animated:YES];

}

-(void)initClassLabel:(NSString *)classsLabel PeopleLabel:(NSString *)peopleLabel TeacherLabel:(NSString *)teacherLabel
{
    _classLabel.text = classsLabel;
    _peopleLabel.text = [NSString stringWithFormat:@"共%@人",peopleLabel];
    _teacherLabel.text =[NSString stringWithFormat:@"授课老师:%@",teacherLabel];


}
@end
