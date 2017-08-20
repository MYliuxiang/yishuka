//
//  StarVC.h
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "TopscreenView.h"

@interface StarVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    TopscreenView *topView;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)videoAction:(id)sender;
- (IBAction)paixunAction:(id)sender;
- (IBAction)chakanAction:(id)sender;

@end
