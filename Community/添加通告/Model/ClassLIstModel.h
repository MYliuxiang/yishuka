//
//  ClassLIstModel.h
//  Community
//
//  Created by 李江 on 16/7/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface ClassLIstModel : LXBaseModel

@property(nonatomic,copy)NSString *classid; // 班级ID
@property(nonatomic,copy)NSString *title; //班级名称
@property(nonatomic,copy)NSString *address; //上课地址
@property(nonatomic,copy)NSString *course_id; //课程类别ID
@property(nonatomic,copy)NSString *course_title; //课程类别名称




@end
