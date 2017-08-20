//
//  ClassroomDetailsVC.h
//  Community
//
//  Created by 刘翔 on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "ZHRecordButton.h"
#import "KetangModel.h"
#import "CourseModel.h"
#import "CourseDModel.h"
#import "FMGVideoPlayView.h"
#import "FullViewController.h"
#import "SendletterVC.h"
#import "CommentModel.h"

@interface ClassroomDetailsVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{
    int _pageIndex;

}

@property (nonatomic, strong) FMGVideoPlayView *fmVideoPlayer; // 播放器

@property (nonatomic, strong) FullViewController *fullVc;

@property (nonatomic,retain) NSMutableArray *dataList;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIButton *deletedBtn;

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
- (IBAction)deletedAC:(id)sender;

- (IBAction)playAction:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlaout;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teachImageView;
@property (weak, nonatomic) IBOutlet UILabel *techerNameLabel;
- (IBAction)sendNotice:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;
@property (weak, nonatomic) IBOutlet UIButton *liuyanBtn;

- (IBAction)shoucangAC:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *botoomView;

- (IBAction)countAC:(id)sender;


- (IBAction)dianzanAC:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContrants;
@property (weak, nonatomic) IBOutlet UIButton *yuyin;
- (IBAction)yuyin:(id)sender;
- (IBAction)record:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sender;
- (IBAction)sender:(id)sender;
@property (weak, nonatomic) IBOutlet ZHRecordButton *recordButton;
@property(nonatomic,assign)BOOL isketangji;

@property (nonatomic,copy)NSString *textstr;
@property (nonatomic,copy)NSString *hid;

@property (nonatomic,copy)NSString *course_id;

@property (nonatomic,retain)KetangModel *model;
@property (nonatomic,retain)CourseModel *cModel;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,assign) int a;

@end
