//
//  FounddetailsVC.h
//  Community
//
//  Created by lijiang on 16/3/31.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "FMGVideoPlayView.h"
#import "FullViewController.h"
@interface FounddetailsVC : BaseViewController<FMGVideoPlayViewDelegate>

@property (nonatomic, strong) FMGVideoPlayView *fmVideoPlayer; // 播放器
@property (nonatomic, strong) FullViewController *fullVc;
@property(nonatomic,copy)NSString *ID;
@property (nonatomic,copy) NSString *textstr;
@end
