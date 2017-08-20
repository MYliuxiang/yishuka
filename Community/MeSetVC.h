//
//  MeSetVC.h
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface MeSetVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIImageView *avatarImageView;
    UILabel *nameLabel;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSArray *titles;
@property (nonatomic,retain)NSArray *imagenames;
@end
