//
//  CourseModel.h
//  Community
//
//  Created by Viatom on 16/7/1.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface CourseModel : LXBaseModel
@property(nonatomic,copy)NSString *cid;//通告ID
@property(nonatomic,copy)NSString *member_id;//老师ID
@property(nonatomic,copy)NSString *member_name;//老师姓名
@property(nonatomic,copy)NSString *member_headimgurl;//老师头像
@property(nonatomic,copy)NSString *read_count;//阅读数
@property(nonatomic,copy)NSString *hit_count;//点赞数
@property(nonatomic,copy)NSString *is_like;//是否收藏 0-未收藏 1-已收藏
@property(nonatomic,copy)NSString *is_zan;//是否收藏 0-未收藏 1-已收藏

@property(nonatomic,copy)NSString *is_del;//是否有权限删除 0-无 1-有
@property(nonatomic,retain)NSArray *courseList;
@property(nonatomic,copy)NSString *class_id; //班级id

@end