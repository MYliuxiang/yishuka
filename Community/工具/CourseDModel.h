//
//  CourseDModel.h
//  Community
//
//  Created by Viatom on 16/7/1.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface CourseDModel : LXBaseModel

@property(nonatomic,copy)NSString *cid;//回课记ID
@property(nonatomic,copy)NSString *thumb;//视频图
@property(nonatomic,copy)NSString *url;//视频地址
@property(nonatomic,copy)NSString *content;//描述

@end
