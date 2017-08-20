//
//  BulletinBoardVC.h
//  Community
//
//  Created by 刘翔 on 16/3/24.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "BulletiModel.h"
#import "TimeModel.h"
#import "NodataSCellTableViewCell.h"
#import "NodataTCell.h"
#import "LSluzhiVC.h"

@interface BulletinBoardVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate,ZLPhotoPickerViewControllerDelegate,luzhidelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL IStecher;
@property (nonatomic,retain) NSMutableArray *dataList;
@property (nonatomic,retain) NSMutableArray *timeList;
@property (nonatomic,copy) NSString *lastWeek;
@property (nonatomic,copy) NSString *nextWeek;
@property (nonatomic,copy) NSString *dateStr;
@property (nonatomic,copy) NSString *dateStr1;
@property (nonatomic,copy) NSString *lxdate;


@end
