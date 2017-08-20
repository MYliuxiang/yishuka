//
//  TeacherCell.m
//  Community
//
//  Created by 刘翔 on 16/6/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "TeacherCell.h"
#import "SignAginVC.h"
#import "AddViewController.h"
#import "BulletinBoardVC.h"
#import "LSluzhiVC.h"
#import "BulletinBoardVC.h"


@implementation TeacherCell{
    
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.button.layer.cornerRadius = 2;
    self.button.layer.masksToBounds = YES;
    
    
    self.classLabel.textColor = Color_text;
    self.noteLabel.textColor = Color_text;
    self.palceLabel.textColor = Color_text;
    self.timeLabel.textColor = Color_text;
    
    _boaedVC =(BulletinBoardVC *)[self ViewController];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BulletiModel *)model
{
    _model = model;
    
    self.titleLabel.text = _model.title;
    self.classLabel.text = [NSString stringWithFormat:@"班级：%@",_model.class_name];
    self.noteLabel.text = [NSString stringWithFormat:@"备注：%@",_model.content];;
    self.palceLabel.text = [NSString stringWithFormat:@"地点：%@",_model.address];
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@-%@",_model.starttime,_model.endtime];
    
    if ([_model.status intValue] == 1) {
        
        //已结束
        self.statusImageView.hidden = NO;
        [self.button setTitle:@"查看回课" forState:UIControlStateNormal];
        self.button.layer.borderColor = Color(252, 176, 42).CGColor;
        self.button.layer.borderWidth = 1;
        self.button.backgroundColor = Color(252, 176, 42);
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        
        if([self.model.is_course_mp4 intValue] == 1){
            
            //有回课
            
            [self.button setTitle:@"查看回课" forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.button.userInteractionEnabled = YES;
            
        }else{
            
            self.button.userInteractionEnabled = YES;
            [self.button setTitle:@"录制回课" forState:UIControlStateNormal];
            self.button.layer.borderColor = [UIColor redColor].CGColor;
            self.button.layer.borderWidth = 1;
            self.button.backgroundColor = [UIColor whiteColor];
            [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:@"通告牌－课程－录像"] forState:UIControlStateNormal];
            self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            
        }

        
    }else if ([_model.status intValue] == 2){
        //未上课
        self.button.userInteractionEnabled = YES;

        self.statusImageView.hidden = YES;
        
        [self.button setTitle:@"修改通告" forState:UIControlStateNormal];
        self.button.layer.borderColor = Color(252, 176, 42).CGColor;
        self.button.layer.borderWidth = 1;
        self.button.backgroundColor = [UIColor whiteColor];
        [self.button setTitleColor:Color(252, 176, 42) forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);



    }else{
        //上课中
        self.button.userInteractionEnabled = YES;
        self.statusImageView.hidden = YES;
//        [self.button setTitle:@"录制回课" forState:UIControlStateNormal];
//        self.button.layer.borderColor = [UIColor redColor].CGColor;
//        self.button.layer.borderWidth = 1;
//        self.button.backgroundColor = [UIColor whiteColor];
//        [self.button setTitleColor:Color(252, 48, 33) forState:UIControlStateNormal];
//        [self.button setImage:[UIImage imageNamed:@"通告牌－课程－录像"] forState:UIControlStateNormal];
//        self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
        
        [self.button setTitle:@"查看回课" forState:UIControlStateNormal];
        self.button.layer.borderColor = Color(252, 176, 42).CGColor;
        self.button.layer.borderWidth = 1;
        self.button.backgroundColor = Color(252, 176, 42);
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        
        if([self.model.is_course_mp4 intValue] == 1){
            
            //有回课
            
            [self.button setTitle:@"查看回课" forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.button.userInteractionEnabled = YES;
            
        }else{
            
            self.button.userInteractionEnabled = YES;
            [self.button setTitle:@"录制回课" forState:UIControlStateNormal];
            self.button.layer.borderColor = [UIColor redColor].CGColor;
            self.button.layer.borderWidth = 1;
            self.button.backgroundColor = [UIColor whiteColor];
            [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:@"通告牌－课程－录像"] forState:UIControlStateNormal];
            self.button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            
        }

        
    }
    
}


- (IBAction)buttonAC:(UIButton *)sender {
    
    
    if ([_model.status intValue] == 1) {
        
        if([self.model.is_course_mp4 intValue] == 1){
            
            //有回课
            
            ClassroomDetailsVC *vc = [[ClassroomDetailsVC alloc] init];
            vc.isketangji = YES;
            vc.textstr = self.model.title;
            vc.hid = self.model.mp4_id;
            vc.course_id = self.model.bid;
            [[self ViewController].navigationController pushViewController:vc animated:YES];
            

        }else{
            NSLog(@"录制回课");
            
//            BulletinBoardVC *vc = ( BulletinBoardVC*)[self ViewController];
            
            NSDictionary *dic = @{@"classid":_model.class_id,@"bid":_model.bid,@"title":
                                      _model.title};
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"luzhi1" object:nil userInfo:dic];
            
   
            
        }

        
     
        
    }else if ([_model.status intValue] == 2){
        //未上课
        NSLog(@"修改通告");
        
        AddViewController * addvc = [[AddViewController alloc]init];
        BulletinBoardVC *VC = (BulletinBoardVC*)[self ViewController];
//        addvc.dateStr = self.dateStr;
//        addvc.dateStr1 = self.dateStr1;
        addvc.bid = _model.bid;
        addvc.index = 2;
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *inputDate = [inputFormatter dateFromString:VC.lxdate];
        
        NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
        // 格式化日期格式
        formatter. dateFormat = @"yyyy年MM月dd日 EEEE" ;
        addvc.dateStr1 =  [formatter stringFromDate:inputDate];
        addvc.dateStr = VC.lxdate;
        [VC.navigationController pushViewController:addvc animated:YES];
        
    }else{
        //上课中
       
        NSLog(@"录制回课");
        NSDictionary *dic = @{@"classid":_model.class_id,@"bid":_model.bid,@"title":
                                  _model.title};
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"luzhi1" object:nil userInfo:dic];

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
    pickerVc.delegate = _boaedVC;
    [pickerVc showPickerVc:_boaedVC];
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
    [_boaedVC presentViewController:pickerView animated:YES completion:nil];
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
    [_boaedVC dismissViewControllerAnimated:YES completion:nil];
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
    luzhiVC.hkid = _model.bid;
    luzhiVC.Class_id = _model.class_id;
    luzhiVC.delegate =self;
    [_boaedVC.navigationController pushViewController:luzhiVC animated:YES];
    
}
//
//- (void)luzhiwancheng{
//
//    [self _loadCours];
//    [_collection reloadData];
//
//}


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






- (IBAction)qiaodaoAC:(UIButton *)sender {
    
    SignAginVC *recordfinishVC = [[SignAginVC alloc]init];
    recordfinishVC.model = self.model;
    [[self ViewController].navigationController pushViewController:recordfinishVC animated:YES];
}
@end
