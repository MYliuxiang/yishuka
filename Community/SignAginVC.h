//
//  SignAginVC.h
//  Community
//
//  Created by 刘翔 on 16/5/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "BulletiModel.h"
#import "SignModel.h"
@interface SignAginVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)BulletiModel *model;

@property (nonatomic,retain) NSMutableArray *dataList;
@end

