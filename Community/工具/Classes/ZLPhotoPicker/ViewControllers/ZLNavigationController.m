//
//  ZLNavigationController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 15/11/25.
//  Copyright © 2015年 com.zixue101.www. All rights reserved.
//

#import "ZLNavigationController.h"

@interface ZLNavigationController ()

@end

@implementation ZLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置系统返回按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //取消导航栏的透明效果
    self.navigationBar.translucent = NO;

    
    self.navigationBar.barTintColor =Color(234, 28,44);
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
