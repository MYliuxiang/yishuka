//
//  texukechengDetailVC.h
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "KClassModel.h"
#import "ClassInfoModel.h"
#import "TeacherModel.h"
@interface texukechengDetailVC : BaseViewController<UIWebViewDelegate>
{
    UIWebView *_webView;

}
@property (nonatomic,retain) KClassModel *model;
@property (nonatomic,retain) ClassInfoModel *cmodel;
@property (nonatomic,retain) TeacherModel *tmodel;
@property (nonatomic,assign) CGFloat myheight;
@property (nonatomic,assign) BOOL isfull;


@end
