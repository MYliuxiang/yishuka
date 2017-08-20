//
//  KClassVC.h
//  Community
//
//  Created by Viatom on 16/7/6.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "KClassModel.h"
#import "SpecialModel.h"
#import "TeacherModel.h"

@interface KClassVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataList;
@property (nonatomic,retain) SpecialModel *model;
@property (nonatomic,retain) TeacherModel *tmodel;
@property (nonatomic,assign) BOOL istc;

@end
