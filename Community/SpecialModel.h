//
//  SpecialModel.h
//  Community
//
//  Created by 刘翔 on 16/6/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface SpecialModel : LXBaseModel

@property(nonatomic,retain)NSString *sid;//分类ID
@property(nonatomic,retain)NSString *title;//分类名称
@property(nonatomic,retain)NSString *type;//属性 1-标准课程 2-特需课程
@property(nonatomic,retain)NSString *aid;//机构ID

@end
