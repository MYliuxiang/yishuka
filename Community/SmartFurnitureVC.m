//
//  SmartFurnitureVC.m
//  Community
//
//  Created by 李江 on 16/3/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SmartFurnitureVC.h"
#import "LognViewController.h"
#import "SignVC.h"
#import "BulletinBoardVC.h"
#import "CollectionVC.h"
#import "StarVC.h"
#import "ClassroomVC.h"


@interface SmartFurnitureVC ()
{
    NSInteger btuTag;
}
@end

@implementation SmartFurnitureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navbarHiden = YES;
    btuTag = -1;
    [self _initView];
}

//初始化试图
- (void)_initView
{
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 480 / 2.0 * ratioHeight)];
    headerImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:headerImageView];
    
    UIImageView *logoimageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 180 * ratioHeight) / 2.0, 30 * ratioHeight, 180 * ratioHeight, 160 * ratioHeight)];
    logoimageView.image = [UIImage imageNamed:@"logo"];
    logoimageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoimageView];
    
    //首页－背景二
    UIImageView *bttomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, headerImageView.bottom, kScreenWidth, kScreenHeight - headerImageView.bottom)];
    bttomImageView.image = [UIImage imageNamed:@"首页－背景二"];
    [self.view addSubview:bttomImageView];
    
    UIButton *Btn_header = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 274 / 2.0 * ratioHeight) / 2.0, headerImageView.bottom - 274 / 4.0 * ratioHeight, 274 / 2.0 * ratioHeight, 274 / 2.0 * ratioHeight)];
    Btn_header.layer.cornerRadius = 274 / 4.0 * ratioHeight;
    Btn_header.layer.masksToBounds = YES;
    [Btn_header addTarget:self action:@selector(btnheader) forControlEvents:UIControlEventTouchUpInside];
    Btn_header.backgroundColor = Color_bg;
    [self.view addSubview:Btn_header];
    NSArray *imageArray = @[@"首页－课堂记",@"首页－星秀场",@"首页－通告牌"];
    NSArray *array = @[@"通告牌",@"星秀场",@"课堂记"];
    for (int i = 0; i < array.count; i ++) {
        UIButton *btu = [[UIButton alloc]initWithFrame:CGRectMake(0, headerImageView.bottom + 40 * ratioHeight, 100 * ratioHeight, 100 * ratioHeight)];
        btu.tag = 200 + i;
        btu.layer.cornerRadius = 100 / 2.0 * ratioHeight;
        btu.layer.masksToBounds = YES;
        [btu addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btu setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
//         btu.backgroundColor = [UIColor redColor];
        [self.view addSubview:btu];
        
        if (i == 0) {
            btu.left = 10 * ratioHeight;
        }
        if (i == 1) {
            btu.left = kScreenWidth - 10 * ratioHeight - 100 * ratioHeight;
        }
        if (i == 2) {
            btu.left = (kScreenWidth  - 100 * ratioHeight) / 2.0;
            btu.top = headerImageView.bottom + 374 / 4.0 * ratioHeight;
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btu.left, btu.bottom + 5, btu.width, 20)];
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = Color_nav;
        label.font = [UIFont boldSystemFontOfSize:16.0 * ratioHeight];
        [self.view addSubview:label];
    }

}

- (void)btnAction:(UIButton *)btn
{
//    if (btuTag == -1) {
////        btn.backgroundColor = [UIColor greenColor];
//         btuTag = btn.tag;
//    } else {
////        btn.backgroundColor = [UIColor greenColor];
//        UIButton *lastbtn = (UIButton *)[self.view viewWithTag:btuTag];
////        lastbtn.backgroundColor = [UIColor redColor];
//        btuTag = btn.tag;
//    }
  
    //通告牌
    if (btn.tag == 200) {
         BulletinBoardVC *vc = [[BulletinBoardVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    //星秀场
    if (btn.tag == 201) {
        StarVC * starvc = [[StarVC alloc]init];
        [self.navigationController pushViewController:starvc animated:YES];
      
    }
    //课堂记
    if (btn.tag == 202) {
        ClassroomVC *classroomVC = [[ClassroomVC alloc]init];
        [self.navigationController pushViewController:classroomVC animated:YES];
    
    }
  
}

//点击广告
- (void)btnheader
{
    NSLog(@"广告");
    LognViewController *lognVC = [[LognViewController alloc]init];
    [self presentViewController:lognVC animated:YES completion:nil];
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
