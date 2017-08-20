//
//  MapJG.h
//  Community
//
//  Created by 刘翔 on 16/6/21.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface MapJG : LXBaseModel

@property (nonatomic,copy)NSString *jid;//机构ID
@property (nonatomic,copy)NSString *title;//机构名称
@property (nonatomic,copy)NSString *subtitle;//分校名称
@property (nonatomic,copy)NSString *address;//地址
@property (nonatomic,copy)NSString *lon;//经度
@property (nonatomic,copy)NSString *lat;//纬度

@end
