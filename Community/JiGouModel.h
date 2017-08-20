//
//  JiGouModel.h
//  Community
//
//  Created by 刘翔 on 16/6/20.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface JiGouModel : LXBaseModel

@property (nonatomic,copy)NSString *jid;
@property (nonatomic,copy)NSString *subtitle;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *thumb;
@property (nonatomic,copy)NSString *is_join;
@property (nonatomic,copy)NSString *lon;
@property (nonatomic,copy)NSString *lat;
@property (nonatomic,copy)NSString *distance;


@end
