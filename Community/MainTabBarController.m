//
//  MainTabBarController.m
//  iCheated
//
//  Created by yunhe on 15/5/29.
//  Copyright (c) 2015年 01. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "MeViewController.h"
#import "SmartFurnitureVC.h"
#import "FoundViewController.h"
#import "BulletinBoardVC.h"
@interface MainTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

static MainTabBarController *mainTVC = nil;

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainTVC = self;
    self.delegate = self;
//    self.tabBar.alpha = .9;
    
    //自定义标签栏
    [self _initTabBar];
//    self.tabBar.selectedImageTintColor = [UIColor colorWithRed:65/255.0 green:205/255.0 blue:62/255.0 alpha:1];
   
}

- (void)gotoHomeAction
{
    self.selectedIndex = 0;
    

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{

    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
   
    

}



- (void)_initTabBar
{


    
    
    
    self.tabBar.translucent = YES;//默认是透明的，设为不透明
//    self.tabBar.tintColor = [UIColor blackColor];
    
    self.tabBar.backgroundImage=[UIImage imageNamed:@"12345123.png"];
//    self.tabBar.tintColor = [UIColor whiteColor];
//     self.tabBar.tintColor= Color_nav;
    
    //设置tabbar背景颜色
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
//    backView.backgroundColor = Color_nav;
//    [self.tabBar insertSubview:backView atIndex:0];
//    self.tabBarController.tabBar.opaque = YES;

    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];
    
    
   
   
    BulletinBoardVC *vc = [[BulletinBoardVC alloc] init];
//    SmartFurnitureVC *SFurnitureVC = [[SmartFurnitureVC alloc]init];
    BaseNavigationController *nav_main = [[BaseNavigationController alloc]initWithRootViewController:vc];
    
    UIImage *musicImage = [UIImage imageNamed:@"底部－通告牌－黑"];
    UIImage *musicImageSel = [UIImage imageNamed:@"底部－通告牌－白"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel = [musicImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"通告牌" image:musicImage selectedImage:musicImageSel];
    vc.tabBarItem = tabBarItem1;
    
    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:12],NSFontAttributeName,nil] forState:UIControlStateNormal];
    nav_main.delegate = self;
    
    
    FoundViewController *foundVC = [[FoundViewController alloc]init];
    BaseNavigationController *nav_foundVC = [[BaseNavigationController alloc]initWithRootViewController:foundVC];
    UIImage *musicImage1 = [UIImage imageNamed:@"底部－发现－黑"];
    UIImage *musicImageSel1 = [UIImage imageNamed:@"底部－发现－白"];
    musicImage1 = [musicImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel1 = [musicImageSel1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"发现" image:musicImage1 selectedImage:musicImageSel1];
    foundVC.tabBarItem = tabBarItem2;
    
    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:12],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
   
    nav_foundVC.delegate = self;
    
    MeViewController *meVC = [[MeViewController alloc]init];
    BaseNavigationController *nav_hisVC = [[BaseNavigationController alloc]initWithRootViewController:meVC];
    UIImage *musicImage2 = [UIImage imageNamed:@"底部－我－黑"];
    UIImage *musicImageSel2 = [UIImage imageNamed:@"底部－我－白"];
    musicImage2 = [musicImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicImageSel2 = [musicImageSel2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"我" image:musicImage2 selectedImage:musicImageSel2];
    meVC.tabBarItem = tabBarItem3;
    nav_hisVC.delegate = self;
    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:12],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.viewControllers = @[nav_main,nav_foundVC,nav_hisVC];

}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 实现显示导航按钮
    if (navigationController.viewControllers.count == 1) {
        
        // 显示标签栏
//        MainTabBarController *mainTBC = (MainTabBarController *)navigationController.tabBarController;
        self.tabBar.hidden = NO;
    } else {
        // 隐藏标签栏
//        MainTabBarController *mainTBC = (MainTabBarController *)navigationController.tabBarController;
        self.tabBar.hidden = YES;
    }
}



//单例方法
+ (instancetype)shareMainTabBarController;
{
    return mainTVC;
    
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




@end
