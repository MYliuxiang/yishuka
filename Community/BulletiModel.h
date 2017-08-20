//
//  BulletiModel.h
//  Community
//
//  Created by 刘翔 on 16/6/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface BulletiModel : LXBaseModel


@property (nonatomic,copy) NSString *bid;//通告ID
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *class_id;//班级ID
@property (nonatomic,copy) NSString *class_name;//班级名称
@property (nonatomic,copy) NSString *starttime;//开始时间(格式10:45)
@property (nonatomic,copy) NSString *endtime;//结束时间(格式11:30)
@property (nonatomic,copy) NSString *address;//上课地址
@property (nonatomic,copy) NSString *content;//简介
@property (nonatomic,copy) NSString *status;//状态(1-已结束 2-未上课 3-上课中)
@property (nonatomic,copy) NSString *is_course_mp4;//是否有回课 1-有 0-无
@property (nonatomic,copy) NSString *mp4_id;//是否有回课 1-有 0-无









@end
