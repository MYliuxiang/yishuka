//
//  ClassModel.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface ClassModel : LXBaseModel

@property (nonatomic,copy) NSString *cid;//班级ID
@property (nonatomic,copy) NSString *title;//班级名称
@property (nonatomic,copy) NSString *teacher_name;//任课老师
@property (nonatomic,copy) NSString *count;//学生数量
@property (nonatomic,copy) NSString *is_notice;//是否有权


@end
