//
//  MyLogin.m
//  YDYWProject
//
//  Created by 郭俊威 on 14-10-21.
//  Copyright (c) 2014年 iOS. All rights reserved.
//

#import "MyLogin.h"


@implementation MyLogin

+ (void)gotoLoginViewWithTarget:(id)target
{
    UIViewController *vc = (UIViewController*)target;

    LognViewController *lognVC = [[LognViewController alloc]init];
    lognVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:lognVC animated:YES completion:nil];
//    [vc.navigationController pushViewController:vc animated:NO];

}

@end
