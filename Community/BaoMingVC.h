//
//  BaoMingVC.h
//  Community
//
//  Created by 刘翔 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface BaoMingVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSString *BMid;
@property(nonatomic,assign)BOOL isbaoming;
@property(nonatomic,assign)NSString *titleString;

@end
