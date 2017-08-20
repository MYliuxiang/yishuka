//
//  SignModel.h
//  Community
//
//  Created by 刘翔 on 16/6/27.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface SignModel : LXBaseModel

@property (nonatomic,copy) NSString *sid;//签到ID
@property (nonatomic,copy) NSString *member_id;//用户ID
@property (nonatomic,copy) NSString *status;//状态(0-未签 1-已到 2-请假 3-缺席)
@property (nonatomic,copy) NSString *name;//姓名
@property (nonatomic,copy) NSString *headimgurl;//头像
@property (nonatomic,copy) NSString *mobilePhone;//手机号
//@property (nonatomic,copy) NSString *name;//手机号


@end
