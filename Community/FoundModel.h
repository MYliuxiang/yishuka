//
//  FoundModel.h
//  Community
//
//  Created by 李江 on 16/6/27.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LXBaseModel.h"

@interface FoundModel : LXBaseModel

//address = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02\U6d77\U6dc0\U533a\U5317\U6d3c\U8def17\U53f7";
//description = "\U7b80\U4ecb";
//id = 4;
//mobile = 18500335900;
//name = "\U5c0f\U5b9b";
//subtitle = "\U6821\U533a\U540d\U79f01";
//"thumb_mp4" = "Public/Upload/image/20160617/5763955f8fa94.jpg";
//title = "\U673a\U6784\U540d\U79f0";

@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *Founddescription;
@property(nonatomic,copy)NSString *foundid;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *thumb_list;



@end
