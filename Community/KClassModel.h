//
//  KClassModel.h
//  Community
//
//  Created by Viatom on 16/7/6.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface KClassModel : LXBaseModel

@property (nonatomic,copy) NSString *cid;//班级ID
@property (nonatomic,copy) NSString *title;//班级名称
@property (nonatomic,copy) NSString *is_full;//是否满员 0-否 1-是

@end
