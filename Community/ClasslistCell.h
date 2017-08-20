//
//  ClasslistCell.h
//  Community
//
//  Created by 李立 on 16/5/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClasslistCell : UITableViewCell
@property(nonatomic,strong)UIImageView *classImageView;
@property(nonatomic,strong)UILabel *classLabel;
@property(nonatomic,strong)UILabel *peopleLabel;
@property(nonatomic,strong)UILabel *teacherLabel;
@property(nonatomic,strong)UIButton *fabuButton;

-(void)initClassLabel:(NSString *)classsLabel PeopleLabel:(NSString *)peopleLabel
         TeacherLabel:(NSString *)teacherLabel;
@end
