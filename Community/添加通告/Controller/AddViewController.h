//
//  AddViewController.h
//  Community
//
//  Created by 李江 on 16/7/6.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface AddViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (nonatomic,copy) NSString *dateStr;
@property (nonatomic,copy) NSString *dateStr1;
@property (nonatomic,copy) NSString *bid;//通告ID
@property (nonatomic,assign)NSInteger index;//修改

@end
