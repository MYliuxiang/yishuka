//
//  BulletinBoardVC.m
//  Community
//
//  Created by 刘翔 on 16/3/24.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BulletinBoardVC.h"
#import "BulletinboardHeader.h"
#import "BullectinCell.h"
#import "ClassroomVC.h"
#import "LognViewController.h"
#import "StendsEndCell.h"
#import "TeacherCell.h"
#import "AddViewController.h"
#import "LSluzhiVC.h"



@interface BulletinBoardVC ()
{
    BulletinboardHeader *heder;

}

@property (nonatomic,strong) NSMutableArray                     *assets;
@property(nonatomic,strong)NSMutableArray                       *SpAry; //视频数组
@property(nonatomic,strong)NSMutableArray                       *imgSpAry;//视频图片
@property(nonatomic,copy)NSString *classid;
@property(nonatomic,copy)NSString *bid;
@property(nonatomic,copy)NSString *title22;


@end

@implementation BulletinBoardVC{

    NSURL        *_videoURL;
    NSString     *_mp4Quality;
    UIAlertView  *_alert;
    NSDate       *_startDate;
    NSString     *_mp4Path;

}


- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

- (NSMutableArray *)imgSpAry{
    _imgSpAry = [NSMutableArray array];
    
    return _imgSpAry;
}

- (NSMutableArray *)SpAry{
    _SpAry = [NSMutableArray array];
    return _SpAry;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewDataWithDateStr:self.lxdate];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    if ([UserDefaults boolForKey:ISLogin] == NO ) {
//        [MyLogin gotoLoginViewWithTarget:self];
//        return;
//    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteAction:) name:@"delete111" object:nil];
    
    self.dataList = [NSMutableArray array];
    self.timeList = [NSMutableArray array];
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dateStr = [outputFormatter stringFromDate:[NSDate date]];
    self.lxdate = self.dateStr;
    [self _initViews];
    self.text = @"通告牌";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    [self _loadData];
    
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
    // 格式化日期格式
    formatter. dateFormat = @"yyyy年MM月dd日 EEEE" ;
    self.dateStr1 = [formatter stringFromDate:[NSDate date]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(luzhi:) name:@"luzhi1" object:nil];
    
}


- (void)deleteAction:(NSNotification *)nsnot{
    
//    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
//    [outputFormatter setLocale:[NSLocale currentLocale]];
//    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
//    
//    self.dateStr = [outputFormatter stringFromDate:[NSDate date]];
    
    NSDictionary *dic = nsnot.userInfo;
    self.dateStr = dic[@"riqi"];

    [self _loadData];

}

- (void)_loadData
{
//    [YYDiskCache]
    
//    NSDictionary *dic = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"time":self.dateStr};
//    
    [LXCachNetWorking postREquestCacheUrlStr:URL_infoList withDic:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"time":self.dateStr} success:^(id result) {
        NSLog(@"%@",result);
        
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSArray *timeList = result[@"result"][@"time_list"];
            NSMutableArray *marray = [NSMutableArray array];
            for (NSDictionary *subdic in timeList) {
                TimeModel *model = [[TimeModel alloc] initWithDataDic:subdic];
                [marray addObject:model];
            }
            self.timeList = marray;
            self.lastWeek = result[@"result"][@"lastWeek"];
            self.nextWeek = result[@"result"][@"nextWeek"];

            heder.dateStr = self.dateStr;
            heder.lastWeek = self.lastWeek;
            heder.nextWeek = self.nextWeek;
            heder.dataList = self.timeList;
            
            NSString *member_group = result[@"result"][@"member_group"];
            if ([member_group integerValue] == 1) {
                //学生
                self.IStecher = NO;
            }else{
            
                //老师
                self.IStecher = YES;
            }
            
            
            NSMutableArray *marray1 = [NSMutableArray array];
            NSArray *list = result[@"result"][@"list"];
            for (NSDictionary *subdic in list) {
                BulletiModel *model = [[BulletiModel alloc] initWithDataDic:subdic];
                model.bid = subdic[@"id"];
                model.content = subdic[@"description"];
                model.title = subdic[@"title"];
                [marray1 addObject:model];
            }
            
            self.dataList = marray1;
            
            [self.tableView reloadData];
            
        }
        
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
            
        }

        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
    }netBlock:^(NSInteger netType) {
        NSLog(@"net%ld",netType);
    }];

}

- (void)_initViews
{
    
    heder = [[BulletinboardHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    heder.clickBlock = ^(TimeModel *model){
    
        NSLog(@"%@",model.time);
        if ([model.time isEqualToString:self.dateStr]) {
            heder.height = 100;
//            self.tableView.tableHeaderView = heder;

            [self.tableView beginUpdates];
            [self.tableView setTableHeaderView:heder];
            [self.tableView endUpdates];
            [self.tableView reloadData];


        }else{
        
            heder.height = 140;
//            self.tableView.tableHeaderView = heder;
            [self.tableView beginUpdates];
            [self.tableView setTableHeaderView:heder];
            [self.tableView endUpdates];
            [self.tableView reloadData];
            
        }
        self.lxdate = model.time;
        [self loadNewDataWithDateStr:model.time];
    
    };
    self.tableView.tableHeaderView = heder;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 45 - 15, 20 + (self.nav.height - 20 - 50 / 2.0) / 2.0 , 45, 60 / 2.0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"回课记" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(rightAC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)loadNewDataWithDateStr:(NSString *)datestr
{
    [LXCachNetWorking postREquestCacheUrlStr:URL_infoList withDic:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"time":datestr} success:^(id result) {
        NSLog(@"%@",result);
        
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSArray *timeList = result[@"result"][@"time_list"];
            NSMutableArray *marray = [NSMutableArray array];
            for (NSDictionary *subdic in timeList) {
                TimeModel *model = [[TimeModel alloc] initWithDataDic:subdic];
                [marray addObject:model];
            }
//            self.timeList = marray;
//            self.lastWeek = result[@"result"][@"lastWeek"];
//            self.nextWeek = result[@"result"][@"nextWeek"];
//            
//            heder.dateStr = self.dateStr;
//            heder.lastWeek = self.lastWeek;
//            heder.nextWeek = self.nextWeek;
//            heder.dataList = self.timeList;
            
            NSString *member_group = result[@"result"][@"member_group"];
            if ([member_group integerValue] == 1) {
                //学生
                self.IStecher = NO;
            }else{
                
                //老师
                self.IStecher = YES;
            }
            
            
            NSMutableArray *marray1 = [NSMutableArray array];
            NSArray *list = result[@"result"][@"list"];
            for (NSDictionary *subdic in list) {
                BulletiModel *model = [[BulletiModel alloc] initWithDataDic:subdic];
                model.bid = subdic[@"id"];
                model.content = subdic[@"description"];
                [marray1 addObject:model];
            }
            
            self.dataList = marray1;
            
            [self.tableView reloadData];
            
        }
        
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
    }netBlock:^(NSInteger netType) {
        NSLog(@"net%ld",netType);
    }];


}

//回课记
- (void)rightAC
{

    ClassroomVC *classroomVC = [[ClassroomVC alloc]init];
    [self.navigationController pushViewController:classroomVC animated:YES];
}

#pragma mark ---------UITableView Delegate ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 3;
    if (self.dataList.count == 0) {
        return 1;
    }else{
    
        return self.dataList.count;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.dataList.count == 0) {
        
        if (self.IStecher) {
           
            static NSString *identifire = @"tcellID";
            NodataTCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NodataTCell" owner:nil options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.add_Button addTarget:self action:@selector(addBAC) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [inputFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *inputDate = [inputFormatter dateFromString:self.lxdate];
            
            int a = [self compareOneDay:inputDate withAnotherDay:[NSDate date]];
            
            
            if (a >= 0) {
                
                cell.add_Button.hidden = NO;
                
            }else{
            
                cell.add_Button.hidden = YES;
            }
            
            return cell;
        }else{
        
                    static NSString *identifire = @"scellID";
                    NodataSCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
                    if (cell == nil) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"NodataSCellTableViewCell" owner:nil options:nil]lastObject];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return cell;
        
        }
        
        
    }else{
    
        BulletiModel *model = self.dataList[indexPath.section];

        if(!self.IStecher){
        
            if ([model.status intValue] == 1) {
                
                //已结束
                
                static NSString *identifire = @"StendsEndCellID";
                StendsEndCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"StendsEndCell" owner:nil options:nil]lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = model;
                return cell;
                
            }else{
            
                //未上课 3-上课中
                static NSString *identifire = @"cellID1";
                BullectinCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"BullectinCell" owner:nil options:nil] lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = model;
                return cell;
            
            }
            
        }else{
            
            static NSString *identifire = @"TeacherCellID";
            TeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherCell" owner:nil options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
            
        }
        
    }
        

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        return .1;
    }else{
    
        if (section == 0) {
            return 5;
        }else{
        
            return 5;
        }
    
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        return .1;
    }else{
    
        if (section == self.dataList.count - 1) {
           
            if (self.IStecher) {
                
                return 80;
                
            }else{
                
                return .1;
                
            }

        }else{
        
            return .1;
        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataList.count == 0) {
        return kScreenHeight - 64 - 49 - heder.height;
    }else{

        BulletiModel *model = self.dataList[indexPath.section];

    
        if (self.IStecher) {
            
            return [TeacherCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
            
        }else{
        
            if ([model.status intValue] == 1) {
                //结束
                return [StendsEndCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
//                return [self.tableView cellHeightForIndexPath:indexPath model:self.dataList[indexPath.row] keyPath:@"StendsEndCellID" cellClass:[StendsEndCell class] contentViewWidth:kScreenWidth];
                
            }else{
            
            
                return [BullectinCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
                
            }
            
        
        }
    
    }

}


- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    if (self.dataList.count == 0) {
        return nil;
    }else{
        if (self.dataList.count - 1 == section) {
           
            if (self.IStecher) {
                
                
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                [inputFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *inputDate = [inputFormatter dateFromString:self.lxdate];
                
                int a = [self compareOneDay:inputDate withAnotherDay:[NSDate date]];
                
                
                if (a >= 0) {
                    
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 160) / 2.0, 20, 160, 40)];
                    [button setImage:[UIImage imageNamed:@"通告牌－课程－添加"] forState:UIControlStateNormal];
                    [button setTitle:@"添加通告" forState:UIControlStateNormal];
                    button.titleLabel.font = [UIFont systemFontOfSize:17];
                    [button addTarget:self action:@selector(addBAC) forControlEvents:UIControlEventTouchUpInside];
                    [button setTitleColor:Color(252, 176, 42) forState:UIControlStateNormal];
                    button.layer.cornerRadius = 2;
                    button.layer.masksToBounds = YES;
                    button.layer.borderWidth = 1;
                    button.layer.borderColor = Color(252, 176, 42).CGColor;
                    [view addSubview:button];
                    return view;
                }
                
                
                
                return nil;
                
                
                
                
                
                
                
                
              
                
            }else{
                
                return nil;
                
            }

        }else{
        
            return nil;
        }
        
    }





}

#pragma mark ---------添加通告--------------
- (void)addBAC
{
    
    AddViewController * addvc = [[AddViewController alloc]init];
    addvc.dateStr = self.lxdate;
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:self.lxdate];
    
    
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
    // 格式化日期格式
    formatter. dateFormat = @"yyyy年MM月dd日 EEEE" ;
    self.dateStr1 = [formatter stringFromDate:inputDate];
    addvc.dateStr1 = self.dateStr1;
    [self.navigationController pushViewController:addvc animated:YES];
    
    

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    
    }

}


-(void)luzhi:(NSNotification *)fotion{
    
    NSDictionary *dic = fotion.userInfo;
    _classid = dic[@"classid"];
    _bid = dic[@"bid"];
    
    _title22 = dic[@"title"];
    

    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"本地视频",@"录制视频",nil];
    
    [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];

}




#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
            break;
        case 0:
            [self openLocalvideo];
            break;
        case 1:
            [self pickVideo];
            
            break;
            
            
            
    }
}


//选择视频
- (void)openLocalvideo{
    self.assets= [NSMutableArray new];
    //    // 创建控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    // 最多能选1张图片
    pickerVc.maxCount = 1;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.photoStatus = PickerPhotoStatusVideos;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
}

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    self.assets = assets.mutableCopy;
    [self uploadimgView];
}


- (void)uploadimgView{
    
    ZLPhotoAssets *asset = self.assets[0];
    UIImage *image;
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        image = asset.originImage;
    }else if ([asset isKindOfClass:[NSString class]]){
        //        [cell.imageview1 sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"pc_circle_placeholder"]];
    }else if([asset isKindOfClass:[UIImage class]]){
        image = (UIImage *)asset;
    }
    
    [[self imgSpAry]addObject:image];
    
    for (int i =0; i<self.assets.count; i++) {
        ZLPhotoAssets *asset = self.assets[i];
        if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
            if (asset.isVideoType) {
                //                NSURL *playurl = asset.asset.defaultRepresentation.url;
                
                ALAssetRepresentation *representation = asset.asset.defaultRepresentation;
                
                long long size = representation.size;
                NSMutableData* data = [[NSMutableData alloc] initWithCapacity:size];
                void* buffer = [data mutableBytes];
                [representation getBytes:buffer fromOffset:0 length:size error:nil];
                NSData *fileData = [[NSData alloc] initWithBytes:buffer length:size];
                
                //File URL
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时
                
                //候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
                [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
                
                NSString *resultPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[formater stringFromDate:[NSDate date]]]];
                
                [[NSFileManager defaultManager] removeItemAtPath:resultPath error:nil];
                [fileData writeToFile:resultPath atomically:NO];
                NSURL *url = [NSURL fileURLWithPath:resultPath];
                
                _videoURL = url;
                
                
                //计算视频长度
                //              NSString *videoLen  = [NSString stringWithFormat:@"%.0f", [self getVideoDuration:_videoURL]];
                //                NSInteger videotime = [videoLen integerValue];
                
                //限制视频的大小
                // if (videotime>30) {
                //                    [MBProgressHUD showError:@"所选视频大于30秒" toView:self.view];
                //                    return;
                //                        }
                [self encodeVideo];
                
            }
            
        }
    }
}




//录制视频
- (void)pickVideo{
    self.SpAry = [NSMutableArray new];
    UIImagePickerController* pickerView = [[UIImagePickerController alloc] init];
    pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    pickerView.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
    [self presentViewController:pickerView animated:YES completion:nil];
    //设置最长录制时间
    //    pickerView.videoMaximumDuration = 30;
    pickerView.delegate = self;
}




#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    self.imgSpAry= [NSMutableArray new];
    _videoURL = info[UIImagePickerControllerMediaURL];
    
    NSString* path = [_videoURL path];
    UISaveVideoAtPathToSavedPhotosAlbum(path,nil, nil, nil);
    
    //获取视频的缩略图
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:_videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    [[self imgSpAry]addObject:thumb];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self encodeVideo];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//压缩
- (void)encodeVideo{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:_videoURL options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    _mp4Quality = AVAssetExportPresetMediumQuality;
    
    
    if ([compatiblePresets containsObject:_mp4Quality])
        
    {
        _alert = [[UIAlertView alloc] init];
        [_alert setTitle:@"正在转码,请稍后..."];
        
        UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activity.frame = CGRectMake(140,
                                    80,
                                    CGRectGetWidth(_alert.frame),
                                    CGRectGetHeight(_alert.frame));
        [_alert addSubview:activity];
        [activity startAnimating];
        [_alert show];
        _startDate = [NSDate date];
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:_mp4Quality];
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        _mp4Path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        exportSession.outputURL = [NSURL fileURLWithPath: _mp4Path];
        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                {
                    [_alert dismissWithClickedButtonIndex:0 animated:NO];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:[[exportSession error] localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                    [alert show];
                    break;
                }
                    
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"Export canceled");
                    [_alert dismissWithClickedButtonIndex:0
                                                 animated:YES];
                    break;
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"Successful!");
                    [self performSelectorOnMainThread:@selector(convertFinish) withObject:nil waitUntilDone:NO];
                    break;
                default:
                    break;
            }
        }];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"AVAsset doesn't support mp4 quality"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
}


//压缩完成
- (void) convertFinish
{
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
    CGFloat duration = [[NSDate date] timeIntervalSinceDate:_startDate];
    NSString *convertTime = [NSString stringWithFormat:@"%.2f s", duration];
    NSString *mp4Size = [NSString stringWithFormat:@"%ld kb", (long)[self getFileSize:_mp4Path]];
    NSLog(@"视频时间长短%@",convertTime);
    NSLog(@"视频大小%@",mp4Size);
    NSData *sssdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://localhost/private%@", _mp4Path]]];
    [[self SpAry] addObject:sssdata];
    
    LSluzhiVC *luzhiVC = [[LSluzhiVC alloc]init];
    
    luzhiVC.imgAry = _imgSpAry;
    luzhiVC.spAry = _SpAry;
    luzhiVC.hkid = _bid;
    luzhiVC.Class_id = _classid;
    luzhiVC.delegate =self;
    luzhiVC.title = _title22;
    [self.navigationController pushViewController:luzhiVC animated:YES];
    
}

- (void)luzhiwancheng{

    [self _loadData ];
}


//计算视频时间长短
- (NSInteger) getFileSize:(NSString*) path
{
    NSFileManager * filemanager = [[NSFileManager alloc]init] ;
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue]/1024;
        else
            return -1;
    }
    else
    {
        return -1;
    }
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
