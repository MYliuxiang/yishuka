//
//  MemberListVCViewController.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "SClasscell.h"
#import "SModel.h"


@interface MemberListVCViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataList;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *titlestr;

@end
