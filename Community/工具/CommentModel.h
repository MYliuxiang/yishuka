//
//  CommentModel.h
//  Community
//
//  Created by Viatom on 16/7/4.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface CommentModel : LXBaseModel

@property (nonatomic,copy) NSString *title;//评论内容
@property (nonatomic,copy) NSString *nickname;//用户姓名
@property (nonatomic,copy) NSString *headimgurl;//头像

@end
