//
//  SModel.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface SModel : LXBaseModel


@property (nonatomic,copy) NSString *sid;//班级ID
@property (nonatomic,copy) NSString *name;//姓名
@property (nonatomic,copy) NSString *headimgurl;//任课老师
@property (nonatomic,copy) NSString *group;//学生数量

@end
