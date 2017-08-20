//
//  BaseViewController.m
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "MainTabBarController.h"
@interface BaseViewController ()<UIAlertViewDelegate>
{
 UILabel *titleLable;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //关闭系统右滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

//     self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = Color_bg;
    self.navbarHiden = NO;
    [self _initnav];




}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;

}

- (void)_initnav
{
    _nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _nav.backgroundColor =  Color_nav;
    [self.view addSubview:_nav];
    
    
    _backButtton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButtton.frame = CGRectMake(5, 20, 60, 44);
    _backButtton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_backButtton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_backButtton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [_nav addSubview:_backButtton];
    if (self.navigationController.viewControllers.count > 1) {
        //有
        self.isBack = YES;
        
    }else{
        
        //没有
        self.isBack = NO;
    }
    
    
    titleLable = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 50, 100)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor=[UIColor whiteColor];
    [titleLable setFont:[UIFont systemFontOfSize:19]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    //    titleText.numberOfLines = 2;
    [self.nav addSubview:titleLable];
    [self.view bringSubviewToFront:self.nav];
    
}

- (void)setISFANHUI:(BOOL)ISFANHUI
{
    _ISFANHUI = ISFANHUI;
    if (_ISFANHUI == YES) {
        
        [_backButtton setTitle:@"返回" forState:UIControlStateNormal];


    }else{
    
        [_backButtton setTitle:@"" forState:UIControlStateNormal];
    
    }


}

- (void)setText:(NSString *)text
{
    _text = text;
    [titleLable setText:_text];
    [titleLable sizeToFit];
    titleLable.center = CGPointMake(kScreenWidth / 2.0, 42);

    
}

- (void)setIsBack:(BOOL)isBack
{
    _isBack = isBack;
    _backButtton.hidden = !_isBack;
    
}

- (void)setNavbarHiden:(BOOL)navbarHiden
{
    _navbarHiden = navbarHiden;
    if (_navbarHiden) {
        _nav.hidden = YES;
    }else{
        
        _nav.hidden = NO;
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"按钮");
}

- (void)addrightImage:(NSString *)imageString
{
    
    _rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightbutton.frame = CGRectMake(kScreenWidth - 50 / 2.0 - 15, 20 + (self.nav.height - 20 - 50 / 2.0) / 2.0 , 50 / 2.0, 50 / 2.0);
    //        [button setTitle:@"返 回" forState:UIControlStateNormal];
    [_rightbutton setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    [_rightbutton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.nav addSubview:_rightbutton];


}


//添加右边按钮
- (void)addrightBtntitleString:(NSString *)titleString imageString:(NSString *)imageString
{
    
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 0, 120, _nav.height)];
    rightView.backgroundColor = [UIColor clearColor];
    rightView.userInteractionEnabled = YES;
    [_nav addSubview:rightView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20 + (rightView.height - 20 - 15) / 2.0, 15, 15)];
    imageView.image = [UIImage imageNamed:imageString];
    [rightView addSubview:imageView];
    
    _rightText = [[UILabel alloc] initWithFrame: CGRectMake(imageView.right + 5, 20, 80, rightView.height - 20)];
    _rightText.backgroundColor = [UIColor clearColor];
    _rightText.textColor= Color(174, 0, 11);
    [_rightText setFont:[UIFont systemFontOfSize:15]];
    _rightText.textAlignment = NSTextAlignmentRight;
    [_rightText setText:titleString];
    [rightView addSubview:_rightText];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightAction)];
    [rightView addGestureRecognizer:tap];
    
    
}

- (void)rightAction
{


}



//添加右边按钮
- (void)addleftBtntitleString:(NSString *)titleString imageString:(NSString *)imageString
{
    
    UIView * lifttView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 120, _nav.height)];
    lifttView.backgroundColor = [UIColor clearColor];
    lifttView.userInteractionEnabled = YES;
    [_nav addSubview:lifttView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20 + (lifttView.height - 20 - 15) / 2.0, 15, 15)];
    imageView.image = [UIImage imageNamed:imageString];
    [lifttView addSubview:imageView];
    
    _leftText = [[UILabel alloc] initWithFrame: CGRectMake(imageView.right + 5, 20, 80, lifttView.height - 20)];
    _leftText.backgroundColor = [UIColor clearColor];
    _leftText.textColor= [UIColor whiteColor];
    [_leftText setFont:[UIFont systemFontOfSize:15]];
    _leftText.textAlignment = NSTextAlignmentLeft;
    [_leftText setText:titleString];
    [lifttView addSubview:_leftText];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftAction)];
    [lifttView addGestureRecognizer:tap];
    
    
}


- (void)leftAction{

    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"按钮");
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
