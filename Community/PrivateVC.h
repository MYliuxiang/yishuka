//
//  PrivateVC.h
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "PrivateCell.h"
#import "NoteModel.h"
@interface PrivateVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    int _pageIndex;
    BOOL _isdownLoad;

}
- (IBAction)fankuiAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fankuiBtn;

- (IBAction)yiduAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,retain)NSMutableArray *dataList;
@end
