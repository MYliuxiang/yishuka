//
//  TeXukechengVC.h
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "SpecialModel.h"
@interface TeXukechengVC : BaseViewController

@property(nonatomic,assign)BOOL isSpecial;
@property(nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,copy) NSString *ID;
@end
