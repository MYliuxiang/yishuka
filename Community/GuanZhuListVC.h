//
//  GuanZhuListVC.h
//  Community
//
//  Created by lijiang on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface GuanZhuListVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end