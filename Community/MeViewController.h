//
//  MeViewController.h
//  Community
//
//  Created by 李江 on 16/3/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "Phone.h"
#import "MyClassVCVC.h"
#import "ModifyPssWordVC.h"

@interface MeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    UIImageView *avatarImageView;
    UILabel *nameLabel;
    UILabel *guanzhu;
    UILabel *fensi;
    UILabel *shoucang;

}
@property (nonatomic,assign) BOOL ISSelf;
@property (nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,retain)NSArray *titles;
@property (nonatomic,retain)NSArray *imageNames;
@property (nonatomic,retain)Phone *phone;
@end
