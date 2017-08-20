//
//  KetangModel.h
//  Community
//
//  Created by 刘翔 on 16/6/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface KetangModel : LXBaseModel

@property(nonatomic,copy)NSString *hid;//回课记ID
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *url;//视频地址
@property(nonatomic,copy)NSString *addtime;//时间
@property(nonatomic,copy)NSString *read_count;//阅读数
@property(nonatomic,copy)NSString *comment_count;//评论数
@property(nonatomic,copy)NSString *course_id;//相关通告ID
@property(nonatomic,copy)NSString *agency_title;
@property(nonatomic,copy)NSString *thumb;



@end
