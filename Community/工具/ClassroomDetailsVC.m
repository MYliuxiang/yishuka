//
//  ClassroomDetailsVC.m
//  Community
//
//  Created by 刘翔 on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ClassroomDetailsVC.h"
#import "CRCell.h"
#import "CROneCell.h"
#import "ZHRecordButton.h"
#import "LJArewardView.h"
#import "VideoCell.h"
#import "LSluzhiVC.h"

@interface ClassroomDetailsVC ()<LJArewardViewDelegate,FMGVideoPlayViewDelegate,UIAlertViewDelegate,ZLPhotoPickerViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate,UIActionSheetDelegate,luzhidelegate>

@property (nonatomic,strong) NSMutableArray                     *assets;
@property(nonatomic,strong)NSMutableArray                       *SpAry; //视频数组
@property(nonatomic,strong)NSMutableArray                       *imgSpAry;//视频图片

@end



@implementation ClassroomDetailsVC{

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    self.text = self.textstr;
    
//    self.fmVideoPlayer = [FMGVideoPlayView videoPlayView];// 创建播放器
//    self.fmVideoPlayer.delegate = self;

    self.dataList = [NSMutableArray array];
    _pageIndex = 1;
    
    self.a = 0;
    self.flowlaout.itemSize = CGSizeMake((kScreenWidth / 320 * 70 - 10) / 3 * 4,kScreenWidth / 320 * 70 - 10);
    self.flowlaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //    self.layout.headerReferenceSize = CGSizeMake(kScreenWidth , 50);
    self.flowlaout.minimumLineSpacing = 0;
    self.flowlaout.minimumInteritemSpacing = 5;
    _collection.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collection.allowsMultipleSelection = YES;//默认为NO,是否可以多选
    self.collection.backgroundColor = Color_bg;
    [_collection registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellWithReuseIdentifier:@"VideoCellID"];
    _collection.allowsMultipleSelection = NO;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadData)];

//    [self creatHeader];
    [self _loadCours];
    
    [self _loadData];
    
    self.recordButton.layer.cornerRadius = 3;
    self.recordButton.layer.masksToBounds = YES;
    self.recordButton.layer.borderWidth = .5;
    self.recordButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.contentText.layer.cornerRadius = 3;
    self.contentText.layer.masksToBounds = YES;
    self.contentText.layer.borderWidth = .5;
    self.contentText.layer.borderColor = [UIColor grayColor].CGColor;
    self.recordButton.hidden = YES;
    
    [self.yuyin setImage:[UIImage imageNamed:@"评论输入"] forState:UIControlStateSelected];
    __weak typeof(self) this         = self;
    self.recordButton.recordComplete = ^(ZHRecordStatus status, NSString *recordPath) {
        
        if (status == ZHRecordStatusComplete && recordPath)
        {
            
        }
        
    };
    
    self.contentText.delegate = self;
//    [self.toolView setTranslatesAutoresizingMaskIntoConstraints:NO]; //默认就NO
    self.isBack = NO;
    [self addleftBtntitleString:@"通告牌" imageString:@"返回"];
    

}

- (void)back
{
    [self close:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)_loadData
{

    NSDictionary *params;
    
    params = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":self.hid,@"course_id":self.course_id};
    
    
    [WXDataService requestAFWithURL:URL_courseMp4InfoCommentList params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        _pageIndex ++;
        
        if(result){
            NSDictionary *dic = result[@"result"];
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                
                NSMutableArray *marray = [NSMutableArray array];
                self.total = dic[@"count"];
                
                if([self.total intValue] == 0){
                    self.botoomView.hidden = YES;
                    
                }else{
                
                    self.botoomView.hidden = NO;

                [self.liuyanBtn setTitle:[NSString stringWithFormat:@"%d条评论",[self.total intValue]] forState:UIControlStateNormal];
                }
                
                NSArray *array = dic[@"list"];
                
                for (NSDictionary *subDic in array) {
                    CommentModel *model = [[CommentModel alloc] initWithDataDic:subDic];
//                    model.hid = subDic[@"id"];
                    [self.dataList addObject:model];
                }
                
//                    self.dataList = marray;
                
                if ([dic[@"page"] intValue] == 0) {
                    //没有更多了
                   
                        [_tableView.mj_footer endRefreshingWithNoMoreData];
                    
                    
                }else{
                    //还有更多
                        [_tableView.mj_footer endRefreshing];
                }
                
                [_tableView reloadData];
                
            }
            
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
              
                self.botoomView.hidden = YES;
                [_tableView.mj_footer endRefreshing];
//                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        self.liuyanBtn.hidden = YES;
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        [_tableView.mj_footer endRefreshing];
        
    }];
    


}

- (void)_loadCours
{
    NSDictionary *dic = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":self.hid,@"course_id":self.course_id};
    NSLog(@"%@",dic);
    
//    NSDictionary *dic = @{@"":@"",@"":@"",@"":@""}
    
    [WXDataService requestAFWithURL:URL_courseMp4Info params:dic httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                NSArray *timeList = result[@"result"][@"list"];
                NSMutableArray *marray = [NSMutableArray array];
                for (NSDictionary *subdic in timeList) {
                  
                    CourseDModel *listmodel = [[CourseDModel alloc] initWithDataDic:subdic];
                    listmodel.cid = subdic[@"id"];
                    listmodel.content = subdic[@"description"];
                    [marray addObject:listmodel];
                }
                CourseModel *model = [[CourseModel alloc] initWithDataDic:result[@"result"][@"info"]];
                model.cid = result[@"result"][@"info"][@"id"];
                model.courseList = marray;
                self.cModel = model;
                
                [self creatHeader];
                
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
    }];


}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        _fullVc = [[FullViewController alloc] init];
    }
    return _fullVc;
}

- (void)close:(BOOL)isfull
{
    if (isfull) {
        
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.tableView addSubview:_fmVideoPlayer];
            _fmVideoPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 320 * 150);
        }];
        
        if (_fmVideoPlayer.playOrPauseBtn.selected == YES) {
            
            [_fmVideoPlayer.player play];
            
        }else{
            [_fmVideoPlayer.player pause];
            
            
        }

        [_fmVideoPlayer removeFromSuperview];
        [_fmVideoPlayer.player pause];
        _fmVideoPlayer.delegate = nil;
        _fmVideoPlayer = nil;
        
        
    }else{
    
        [_fmVideoPlayer removeFromSuperview];
        [_fmVideoPlayer.player pause];
        _fmVideoPlayer.delegate = nil;
        _fmVideoPlayer = nil;

    
    }

}

- (void)dealloc
{
    
    [_fmVideoPlayer removeFromSuperview];
    [_fmVideoPlayer.player pause];
    _fmVideoPlayer.delegate = nil;
    _fmVideoPlayer = nil;
    

    
}


- (void)videoplayViewSwitchOrientation:(BOOL)isFull{
    if (isFull) {
        [self.navigationController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self.fmVideoPlayer];
            _fmVideoPlayer.center = self.fullVc.view.center;
            
            //            [_fmVideoPlayer.player play];
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _fmVideoPlayer.frame = self.fullVc.view.bounds;
                
                //                self.fmVideoPlayer.danmakuView.frame = self.fmVideoPlayer.frame;
                
            } completion:nil];
            
            if (_fmVideoPlayer.playOrPauseBtn.selected == YES) {
                
                [_fmVideoPlayer.player play];
                
            }else{
                [_fmVideoPlayer.player pause];
                
                
            }
            
        }];
    } else {
        
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.tableView addSubview:_fmVideoPlayer];
            _fmVideoPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 320 * 150);
        }];
        
        if (_fmVideoPlayer.playOrPauseBtn.selected == YES) {
            
            [_fmVideoPlayer.player play];
            
        }else{
            [_fmVideoPlayer.player pause];
            
            
        }
        //        [_fmVideoPlayer.player play];
    }
    
}


- (void)creatHeader
{
    self.headerView.width = kScreenWidth;
    _teachImageView.layer.cornerRadius = _teachImageView.height / 2.0;
    _teachImageView.layer.masksToBounds = YES;
    [self.teachImageView sd_setImageWithURL:[NSURL URLWithString:self.cModel.member_headimgurl]];
    self.techerNameLabel.text = self.cModel.member_name;
    [self.dianzanBtn setTitle:self.cModel.hit_count forState:UIControlStateNormal];
    [self.countBtn setTitle:self.cModel.read_count forState:UIControlStateNormal];
    self.videoImageView.clipsToBounds = YES;
    if ([self.cModel.is_del intValue] == 0) {
            //学生
        self.deletedBtn.hidden = YES;
        CourseDModel *model = self.cModel.courseList[0];
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
        self.contentLabel.text = model.content;
        
    }else{
        
        self.deletedBtn.hidden = NO;

    CourseDModel *model = self.cModel.courseList[0];
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.contentLabel.text = model.content;
    }
    
    if([self.cModel.is_zan intValue] == 0){
    
        //未点赞
        self.dianzanBtn.selected = NO;
        
    }else{
    
        self.dianzanBtn.selected = YES;

    }
    
    if([self.cModel.is_like intValue] == 0){
        //未收藏
        self.shoucangBtn.selected = NO;
        
    }else{
        
        self.shoucangBtn.selected = YES;

    }

    
    
    
    [self.headerView setupAutoHeightWithBottomView:self.botoomView bottomMargin:0];
    self.headerView.height = self.botoomView.bottom + kScreenWidth / 320 * 220 - 220 + 20;
    [self.collection reloadData];
    
      [_collection selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//    self.headerView.height = self.botoomView.bottom;
    self.tableView.tableHeaderView = self.headerView;


}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.cModel.is_del intValue] == 0) {
        //学生
        return self.cModel.courseList.count;
    }else{
    
        return self.cModel.courseList.count + 1;
    
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCellID" forIndexPath:indexPath];
//    cell.model = self.dataList[indexPath.row];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
    if (self.cModel.courseList.count == indexPath.row) {
        
        view.backgroundColor = [UIColor clearColor];
        
    }else{
    
        view.backgroundColor = Color_nav;

    }
    cell.selectedBackgroundView = view;
    if (indexPath.row != self.cModel.courseList.count) {
        cell.model = self.cModel.courseList[indexPath.row];

    }else{
    
        cell.imageName = @"添加视频";
    }
   
    [cell setNeedsLayout];
    return cell;
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [_collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];


}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [_collection deselectItemAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == self.cModel.courseList.count) {
        //添加视频
        
        UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"本地视频",@"录制视频",nil];
        
        [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
        
    }else{
        
            if (self.a != indexPath.row) {
               
                self.a = indexPath.row;
                [_fmVideoPlayer removeFromSuperview];
                [_fmVideoPlayer.player pause];
                _fmVideoPlayer.delegate = nil;
                _fmVideoPlayer = nil;

                
                CourseDModel *model = self.cModel.courseList[indexPath.row];
                [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
                self.contentLabel.text = model.content;
                [self.headerView setupAutoHeightWithBottomView:self.botoomView bottomMargin:0];
                self.headerView.height = self.botoomView.bottom + kScreenWidth / 320 * 220 - 220;
                
                [self.tableView beginUpdates];
                [self.tableView setTableHeaderView:self.headerView];
                [self.tableView endUpdates];
            }
            
        
    
        
    }
    
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
    luzhiVC.hkid = self.cModel.cid;
    luzhiVC.Class_id = self.cModel.class_id;
    luzhiVC.delegate =self;
    luzhiVC.title = self.textstr;
    [self.navigationController pushViewController:luzhiVC animated:YES];

}

- (void)luzhiwancheng{

    [self _loadCours];
    [_collection reloadData];

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




- (void)awakeFromNib
{
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.row == 0) {
//        static NSString *identifire = @"cellID";
//        CRCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"CRCell" owner:nil options:nil] lastObject];
//            
//        }
//        
//        return cell;
//
//    }else{
    
    static NSString *identifire = @"cellID1";
        CROneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CROneCell" owner:nil options:nil] lastObject];
            
        }
    cell.model = self.dataList[indexPath.row];
        return cell;

//    }
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    self.botoomView.height = 30;
//    [self.liuyanBtn setTitle:[NSString stringWithFormat:@"%d次",[self.total intValue]] forState:UIControlStateNormal];
//    return self.botoomView;
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return [CROneCell whc_CellHeightForIndexPath:indexPath tableView:tableView] + 10;

}


- (void)giveKabiStr:(NSString *)kabistr
{
    NSLog(@"===咖币%@",kabistr);
    
}


- (IBAction)yuyin:(id)sender {
  
    self.yuyin.selected = !self.yuyin.selected;
    if (self.yuyin.selected) {
        //语音
        self.contentText.hidden = YES;
        self.recordButton.hidden = NO;
        self.sender.enabled = NO;
        [self.view endEditing:YES];
        self.contentText.text = @"";
        self.heightContrants.constant = self.contentText.contentSize.height > 30? self.contentText.contentSize.height + 10 : 40;

        
    }else{
    
        //文字
        self.contentText.hidden = NO;
        self.recordButton.hidden = YES;
        self.sender.enabled = YES;

    }
    
    
}

#pragma mark - 文本框代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        //确定
        [self.view endEditing:YES];
        return NO;
    }
   
      // 02.为（VFL）创建参数
    self.heightContrants.constant = textView.contentSize.height > 30? textView.contentSize.height + 10 : 40;

    
    return YES;


}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length == 0) {
        self.label.text = @"评论内容";
    }else{
        self.label.text = @"";
    }
    
}

#pragma mark - 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
    
}

- (IBAction)record:(id)sender {
    
    
    
}


- (IBAction)sender:(id)sender {
    
    
    if (self.contentText.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入评论内容！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [WXDataService requestAFWithURL:URL_courseMp4CommentSub params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"course_id":self.cModel.cid,@"content":self.contentText.text} httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                self.botoomView.hidden = NO;

                self.total = [NSString stringWithFormat:@"%d",[self.total intValue] + 1];
                    [self.liuyanBtn setTitle:[NSString stringWithFormat:@"%d条评论",[self.total intValue]] forState:UIControlStateNormal];
                //收藏成功
                _contentText.text = @"";
                self.label.text = @"评论内容";
                [MBProgressHUD showSuccess:@"评论成功！" toView:self.view];
                CommentModel *model = [[CommentModel alloc] initWithDataDic:result[@"result"]];
                model.title = result[@"result"][@"content"];
                [self.dataList insertObject:model atIndex:0];
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
                [_tableView beginUpdates];
                [_tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
                [_tableView endUpdates];
                
                
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];

}

//删除
- (IBAction)deletedAC:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此视频" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
  
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        NSArray *arry = [_collection indexPathsForSelectedItems];
        NSIndexPath *indexpath = arry[0];
        CourseDModel *model = self.cModel.courseList[indexpath.row];
        
        NSDictionary *dic = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":model.cid};
        [WXDataService requestAFWithURL:URL_courseMp4Del params:dic httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
            
            
            if(result){
                
                if ([[result objectForKey:@"status"] integerValue] == 0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功！" toView:self.view];
                    
                    NSMutableArray *array = [NSMutableArray arrayWithArray:self.cModel.courseList];
                    [array removeObject:model];
                    if (array.count == 0) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
                        
                        self.cModel.courseList = array;
                        
                        
                        
                        [_collection reloadData];
                        [_collection selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
                        
                        
                        CourseDModel *model = self.cModel.courseList[0];
                        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
                        self.contentLabel.text = model.content;
                        [self.headerView setupAutoHeightWithBottomView:self.botoomView bottomMargin:0];
                        self.headerView.height = self.botoomView.bottom + kScreenWidth / 320 * 220 - 220;
                        [self.tableView beginUpdates];
                        [self.tableView setTableHeaderView:self.headerView];
                        [self.tableView endUpdates];
                        
                    }
                    
                    
                }
                //没有数据了
                if ([[result objectForKey:@"status"] integerValue] == 1) {
                    
                    [MBProgressHUD showError:result[@"msg"] toView:self.view];
                    
                }
                
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
            
            [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
            
            
        }];

    }

}


- (IBAction)playAction:(id)sender {
    
    if (self.fmVideoPlayer == nil) {
        self.fmVideoPlayer = [FMGVideoPlayView videoPlayView];// 创建播放器
        self.fmVideoPlayer.delegate = self;
    }
    
    NSArray *array = [self.collection indexPathsForSelectedItems];
    NSIndexPath *indexPath = array[0];
    CourseDModel *model = self.cModel.courseList[indexPath.row];
    [_fmVideoPlayer setUrlString:model.url];
    
// [_fmVideoPlayer setUrlString:@"http://flv2.bn.netease.com/videolib3/1605/20/QVMmc2460/SD/movie_index.m3u8"];
    _fmVideoPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 320 * 150);
    [self.tableView addSubview:_fmVideoPlayer];
    _fmVideoPlayer.contrainerViewController = self;
    [_fmVideoPlayer.player play];
    [_fmVideoPlayer showToolView:NO];
    _fmVideoPlayer.playOrPauseBtn.selected = YES;
    _fmVideoPlayer.hidden = NO;
    
    
    
}

//发私信
- (IBAction)sendNotice:(id)sender {
    
    SendletterVC *vc = [[SendletterVC alloc] init];
    vc.sid = self.cModel.member_id;
    vc.name = self.cModel.member_name;
    vc.headimgurl = self.cModel.member_headimgurl;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//收藏
- (IBAction)shoucangAC:(id)sender {
    
    UIButton *button = sender;
//    if(!button.selected){
        
        CourseDModel *model = self.cModel.courseList[0];

    NSDictionary *dic = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"course_id":self.cModel.cid};
    [WXDataService requestAFWithURL:URL_courseMp4Collection params:dic httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                button.selected = !button.selected;
                [MBProgressHUD showSuccess:@"成功！" toView:self.view];
                
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];
//    
//    }else{
//    
//        
//        CourseDModel *model = self.cModel.courseList[0];
//        
//        [WXDataService requestAFWithURL:Url_myCollectionDel params:@{@"member_id":[UserDefaults objectForKey:Userid],@"id":model.cid} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
//            
//            if ([[result objectForKey:@"status"] integerValue] == 0) {
//                
//                button.selected = !button.selected;
//                [MBProgressHUD showSuccess:@"成功！" toView:self.view];
//                
//            }
//            
//            if ([[result objectForKey:@"status"] integerValue] == 1) {
//                
//                [MBProgressHUD showError:result[@"msg"] toView:self.view];
//                
//            }
//            
//            
//        } errorBlock:^(NSError *error) {
//            
//            [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
//
//        }];
//
//        
//    
//    }
   
    
   
}

- (IBAction)countAC:(id)sender {
    
}

//点赞
- (IBAction)dianzanAC:(id)sender {
    
    UIButton *button = sender;
    NSDictionary *dic = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"course_id":self.cModel.cid};
    [WXDataService requestAFWithURL:URL_courseMp4InfoLikeSub params:dic httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                if (button.selected) {
                    
                self.cModel.hit_count = [NSString stringWithFormat:@"%d",[self.cModel.hit_count intValue] - 1];
                     [self.dianzanBtn setTitle:[NSString stringWithFormat:@"%d",[self.cModel.hit_count intValue] ] forState:UIControlStateNormal];
                }else{
                self.cModel.hit_count = [NSString stringWithFormat:@"%d",[self.cModel.hit_count intValue] + 1];
                [self.dianzanBtn setTitle:[NSString stringWithFormat:@"%d",[self.cModel.hit_count intValue]] forState:UIControlStateNormal];
                }
                button.selected = !button.selected;
                [MBProgressHUD showSuccess:@"成功！" toView:self.view];

            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];
    

}
@end
