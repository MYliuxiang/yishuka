//
//  BaseViewController.h
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property(nonatomic,retain)UIView *nav;
@property(nonatomic,retain)UIButton *backButtton;
@property (assign,nonatomic) BOOL navbarHiden;
@property(assign,nonatomic)BOOL isBack;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,retain)UIButton *rightbutton;
@property(nonatomic,strong)UILabel *leftText;
@property(nonatomic,strong)UILabel *rightText;
@property (nonatomic,assign) BOOL ISFANHUI;
- (void)addrightImage:(NSString *)imageString;

- (void)addrightBtntitleString:(NSString *)titleString imageString:(NSString *)imageString;

- (void)rightAction;
- (void)addleftBtntitleString:(NSString *)titleString imageString:(NSString *)imageString;

- (void)back;

@end
