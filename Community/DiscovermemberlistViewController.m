//
//  DiscovermemberlistViewController.m
//  Community
//
//  Created by 李立 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "DiscovermemberlistViewController.h"
#import "FansTableViewCell.h"
@interface DiscovermemberlistViewController ()
{
    UIImageView *_celllineView;
}
@end

@implementation DiscovermemberlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"成员";
    self.ISFANHUI = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    [self _initView];
}


//初始化视图
-(void)_initView
{
    UIView *bjView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 50)];
    bjView.backgroundColor = [UIColor colorWithRed:0.9647 green:0.7529 blue:0.1725 alpha:1];
    [self.view addSubview:bjView];
    
     NSArray *array = @[@"老师",@"学生",@"班级"];
   
    for (int i = 0; i < array.count ; i ++) {
       
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * kScreenWidth / 3.0,0, kScreenWidth / 3.0, bjView.height)];
        label.text = array[i];
        label.tag = 200 + i;
        label.userInteractionEnabled = YES;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = Color_text;
        [bjView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
    }
    _celllineView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth / 3.0 / 2.0 - 5,bjView.height - 10, 10, 10)];
    _celllineView.backgroundColor = [UIColor blackColor];
    [bjView addSubview:_celllineView];
   
    //创建表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,bjView.bottom, kScreenWidth  , kScreenHeight ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _myTableView.bounces = NO;
        
    //尾视图
    _tableView.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        footerbjView;
        
    });
    
    [self.view addSubview:_tableView];

}

#pragma mark ---------- 课程切换 ------------------
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    //
//    if (tap.view.tag == 200) {
//        [UIView animateWithDuration:.35 animations:^{
//            _celllineView.left = kScreenWidth / 3.0 / 2.0 - _celllineView.width / 2.0;
//        } completion:nil];
//        
//    }
//    //
//    if (tap.view.tag == 201) {
//        [UIView animateWithDuration:.35 animations:^{
//            _celllineView.left = kScreenWidth / 3.0 + kScreenWidth / 3.0 / 2.0 - _celllineView.width / 2.0;
//        } completion:nil];
//    }
//    if (tap.view.tag == 202) {
//        [UIView animateWithDuration:.35 animations:^{
//            _celllineView.left =  kScreenWidth / 3.0 * 2.0 + kScreenWidth / 3.0 / 2.0 - _celllineView.width / 2.0;
//        } completion:nil];
//    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    FansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FansTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        //线条
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 90 - .5, kScreenWidth, .5)];
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        [cell.contentView addSubview:lineview];
        
        
    }
    //    [cell initTouxiangImageView:@"001" NameLabel:@"李立立" CategoryLabel:@"老师" BiaozhuLabel:@"器乐 钢琴" FollowButton:@"取消关注"];
    
    [cell initTouxiangImageView:@"001" NameLabel:@"苗秀秀" CategoryLabel:@"老师" BiaozhuLabel:@"器乐 钢琴" Isko:NO];
    
    
    
    return cell;
}
@end
