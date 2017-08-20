//
//  TeacherModel.h
//  Community
//
//  Created by 刘翔 on 16/6/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface TeacherModel : LXBaseModel

@property(nonatomic,retain)NSString *tid;//教师ID
@property(nonatomic,retain)NSString *name;//教师姓名
@property(nonatomic,retain)NSString *headimgurl;//属性 1-标准课程 2-特需课程
@property(nonatomic,retain)NSString *cdescription;//简介

@end
