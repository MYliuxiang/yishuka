//
//  OthersHomeVC.h
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface OthersHomeVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *avatarImageView;
    UIButton *isguzhuBtn;
    UILabel *guanzhu;
    UILabel *fensi;

    
}

@property (nonatomic,retain)NSMutableArray *dataList;

@end
