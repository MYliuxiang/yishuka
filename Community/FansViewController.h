//
//  FansViewController.h
//  Community
//
//  Created by 李立 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface FansViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@end
