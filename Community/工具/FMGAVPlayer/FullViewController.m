//
//  FullViewController.m
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "FullViewController.h"
#import "FullView.h"

@interface FullViewController ()

@end

@implementation FullViewController

- (void)loadView
{
    FullView *fullView = [[FullView alloc] init];
    self.view = fullView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


//- (BOOL)shouldAutorotate
//{
//    return YES;
//}

//// 支持的屏幕方向，此处可直接返回 UIInterfaceOrientationMask 类型
//// 也可以返回多个 UIInterfaceOrientationMask 取或运算后的值
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
