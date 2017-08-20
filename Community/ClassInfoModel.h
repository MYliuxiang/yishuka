//
//  ClassInfoModel.h
//  Community
//
//  Created by Viatom on 16/7/7.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface ClassInfoModel : LXBaseModel

@property (nonatomic,copy) NSString *cid;//班级ID
@property (nonatomic,copy) NSString *title;//班级名称
@property (nonatomic,copy) NSString *cdescription;//课程内容
@property (nonatomic,copy) NSString *content;//课程安排
@property (nonatomic,copy) NSString *is_join;//是否已加入

@end
