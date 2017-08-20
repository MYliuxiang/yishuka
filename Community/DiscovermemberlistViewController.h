//
//  DiscovermemberlistViewController.h
//  Community
//
//  Created by 李立 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface DiscovermemberlistViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end
