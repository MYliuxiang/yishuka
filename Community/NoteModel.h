//
//  NoteModel.h
//  Community
//
//  Created by Viatom on 16/6/21.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface NoteModel : LXBaseModel

@property (nonatomic,copy)NSString *nid; //私信ID
@property (nonatomic,copy)NSString *addtime; //时间
@property (nonatomic,copy)NSString *nickname; //姓名
@property (nonatomic,copy)NSString *content; //私信内容
@property (nonatomic,copy)NSString *headimgurl; //头像(班级公告没有头像字段)
@property (nonatomic,copy)NSString *is_class; //是否班级公告 0-否 1-是
@property (nonatomic,copy)NSString *member_id; 


@end
