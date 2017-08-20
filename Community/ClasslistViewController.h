//
//  ClasslistViewController.h
//  Community
//
//  Created by 李立 on 16/5/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface ClasslistViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;
@end
