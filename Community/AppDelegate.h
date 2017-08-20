//
//  AppDelegate.h
//  Community
//
//  Created by 李江 on 16/3/18.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LognViewController.h"
#import "NetWorkManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,NetWorkManagerDelegate>
{
    BMKMapManager* _mapManager;


}
+(AppDelegate *)GetAppDelegate;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)NetWorkManager *networkManager;


@end

