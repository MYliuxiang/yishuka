//
//  AddAnnouncementVC.h
//  Community
//
//  Created by 刘翔 on 16/3/31.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface AddAnnouncementVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIView *timeView;
    UIDatePicker *datepick;
    BOOL _wasKeyboardManagerEnabled;


}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)NSArray *titles;
@property (nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,assign)CGPoint mpoint;
@property (nonatomic,retain)UITextField *seleText;
@end
