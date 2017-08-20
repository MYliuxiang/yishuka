//
//  AppDelegate.m
//  Community
//
//  Created by 李江 on 16/3/18.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "IQKeyboardManager.h"
#import "BaseNavigationController.h"

static NSString *appKey = @"6c9377cccc575ecd442134d8";
static NSString *channel = @"App Store";
static BOOL isProduction = 1;


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)GetAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"htzbGiv4kpLj8i9f4euwhhgVh7it74fQ"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    _networkManager = [NetWorkManager sharedManager];
    _networkManager.delegate = self;
    [_networkManager startNetWorkeWatch];
    
    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
   LognViewController  *loginVC = [[LognViewController alloc] init];
   BaseNavigationController *baseNAV = [[BaseNavigationController alloc] initWithRootViewController:loginVC];

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kviewNSNotificationAction:) name:KVIEWVCCHANGE object:nil];
    
    MainTabBarController *mainVC = [[MainTabBarController alloc]init];
    
    
    if (![UserDefaults boolForKey:ISLogin]) {
        
    self.window.rootViewController = baseNAV;

    }else{
    
    self.window.rootViewController =mainVC;
        
    }
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    //极光推送
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    
    
    return YES;
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

//通知方法
- (void)kviewNSNotificationAction:(NSNotificationCenter *)notification
{
//    if([self.window.rootViewController isKindOfClass:[UITabBarController class]]){
//    
//        return;
//    }
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    self.window.rootViewController =mainVC;

}

#pragma mark - NetWorkManagerDelegate
- (void) netWorkStatusWillChange:(NetworkStatus)status
{
    
    
}

- (void) netWorkStatusWillDisconnection
{
    // @"网络断开";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:@"您当前没有网络状态！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

- (void)onGetNetworkState:(int)iError
{

    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }

}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }

    
}


//- (void)applicationWillResignActive:(UIApplication *)application {
//    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
//}
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
//}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:YOUPAINOTICE object:userInfo];
    
}



- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
