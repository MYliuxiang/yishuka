//
//  BaseNavigationController.m
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import "BaseNavigationController.h"
#import "MainTabBarController.h"

@interface BaseNavigationController ()


@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
    
    //设置系统返回按钮的颜色
//    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    //取消导航栏的透明效果
    self.navigationBar.translucent = NO;
//    self.delegate = self;
    
//    self.navigationBar.hidden = YES;
    //设置导航栏的样式
    
//     self.navigationBar.barStyle = UIBarStyleBlack;
    
    //设置导航栏的背景图片

    [self.navigationBar setBarTintColor:Color_nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    // 实现显示导航按钮
//    if (navigationController.viewControllers.count == 1) {
//        
//        // 显示标签栏
//        MainTabBarController *mainTBC = (MainTabBarController *)navigationController.tabBarController;
//        mainTBC.tabBar.hidden = NO;
//    } else {
//        // 隐藏标签栏
//        MainTabBarController *mainTBC = (MainTabBarController *)navigationController.tabBarController;
//        mainTBC.tabBar.hidden = YES;
//    }
//}
//

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







@end
