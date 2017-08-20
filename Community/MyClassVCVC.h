//
//  MyClassVCVC.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "CClassCell.h"
#import "ClassModel.h"
#import "MemberListVCViewController.h"

@interface MyClassVCVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataList;

@end
