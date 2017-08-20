//
//  TeacherCell.h
//  Community
//
//  Created by 刘翔 on 16/6/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BulletiModel.h"
#import "ClassroomDetailsVC.h"
#import "BulletinBoardVC.h"
#import "LSluzhiVC.h"


@interface TeacherCell : UITableViewCell<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate,ZLPhotoPickerViewControllerDelegate,luzhidelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *palceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UIButton *qiandaoBtn;
- (IBAction)qiaodaoAC:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonAC:(UIButton *)sender;

@property (nonatomic,retain) BulletiModel *model;



@property (nonatomic,strong) NSMutableArray                     *assets;
@property(nonatomic,strong)NSMutableArray                       *SpAry; //视频数组
@property(nonatomic,strong)NSMutableArray                       *imgSpAry;//视频图片
@property(nonatomic,strong)BulletinBoardVC *boaedVC;

@end
