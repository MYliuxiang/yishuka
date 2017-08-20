//
//  OthersHomeVC.m
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "OthersHomeVC.h"
#import "WorksCell.h"
#import "FansViewController.h"
#import "GuanZhuListVC.h"
#import "ClassroomDetailsVC.h"
#import "ClassroomVC.h"
#import "PrivateDetailVC.h"
@interface OthersHomeVC ()

@end

@implementation OthersHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataList = @[@"1",@"2",@"3"];
    self.navbarHiden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self _initViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)_initViews
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
//    [self.view bringSubviewToFront:self.nav];

    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 260)];
    

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint firstPoint = CGPointMake(0, imageView.height);
    CGPoint secondPoint = CGPointMake(kScreenWidth, imageView.height);
    
    [path moveToPoint:firstPoint];
    
    [path addQuadCurveToPoint:secondPoint controlPoint:CGPointMake(kScreenWidth / 2.0, imageView.height - 30 * 2)];
    
    CAShapeLayer *_trackLayer = [CAShapeLayer layer];//创建一个track shape layer
    _trackLayer.frame = imageView.bounds;
    _trackLayer.fillColor = [[UIColor whiteColor] CGColor];
    _trackLayer.strokeColor = [UIColor whiteColor].CGColor;//指定path的渲染颜色
    _trackLayer.opacity = 1; //背景透明度小一点
    _trackLayer.lineCap = kCALineCapButt;//指定线的边缘是圆的
    _trackLayer.lineWidth = 1.0;//线的宽度
    _trackLayer.path =[path CGPath];
    [imageView.layer addSublayer:_trackLayer];
    
    
    
    avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 60) / 2.0, imageView.height - 60, 60, 60)];
//    avatarImageView.backgroundColor = [UIColor redColor];
    avatarImageView.image = [UIImage imageNamed:@"001.png"];
    avatarImageView.layer.cornerRadius = 30;
    avatarImageView.layer.masksToBounds = YES;
    [imageView addSubview:avatarImageView];
    avatarImageView.clipsToBounds = YES;
    avatarImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiugai)];
    [avatarImageView addGestureRecognizer:tap];
    
    isguzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    isguzhuBtn.backgroundColor = Color_nav;
    isguzhuBtn.layer.cornerRadius = 3;
    isguzhuBtn.layer.masksToBounds = YES;
    isguzhuBtn.frame = CGRectMake((kScreenWidth - 100) / 2.0, imageView.bottom + 10, 100, 30);
    [isguzhuBtn setTitle:@"已关注" forState:UIControlStateNormal];
    [isguzhuBtn addTarget:self action:@selector(buttonIsguanzhu) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:isguzhuBtn];
    
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, isguzhuBtn.bottom + 10, kScreenWidth, 1)];
    imageView1.backgroundColor = ColorRGB(221, 214, 203, 1);
    [view addSubview:imageView1];
    
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, isguzhuBtn.bottom + 10 + 49, kScreenWidth, 1)];
    imageView2.backgroundColor = ColorRGB(221, 214, 203, 1);
    [view addSubview:imageView2];
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 160) / 2.0, isguzhuBtn.bottom + 10, 80, 50)];
    [view addSubview:view1];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
    [view1 addGestureRecognizer:tap1];
    
    guanzhu = [[UILabel alloc] initWithFrame:CGRectMake(0,5, 80, 20)];
    guanzhu.text = @"20";
    guanzhu.numberOfLines = 0;
    guanzhu.font = [UIFont systemFontOfSize:14];
    guanzhu.textAlignment = NSTextAlignmentCenter;
    guanzhu.textColor = Color_nav;
    [view1 addSubview:guanzhu];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 80, 20)];
    label1.text = @"关注";
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor blackColor];
    [view1 addSubview:label1];
    
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(view1.right, isguzhuBtn.bottom + 10, 80, 50)];
    [view addSubview:view2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
    [view2 addGestureRecognizer:tap2];
    fensi = [[UILabel alloc] initWithFrame:CGRectMake(0,5, 80, 20)];
    fensi.text = @"100";
    fensi.font = [UIFont systemFontOfSize:14];
    fensi.textColor = Color_nav;
    
    fensi.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:fensi];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 80, 20)];
    label2.text = @"粉丝";
    label2.font = [UIFont systemFontOfSize:14];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor blackColor];
    [view2 addSubview:label2];
    
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(view1.right, isguzhuBtn.bottom + 15, 1, 40)];
    imageView3.backgroundColor = ColorRGB(221, 214, 203, 1);
    [view addSubview:imageView3];
    
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame: CGRectMake(kScreenWidth/ 2.0 - 50, 20, 50, 100)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor=[UIColor whiteColor];
    [titleLable setFont:[UIFont systemFontOfSize:16]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"我是大咖";
    [titleLable sizeToFit];
    titleLable.center = CGPointMake(kScreenWidth / 2.0, 42);
    
    
//    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
//    right.frame = CGRectMake(kScreenWidth - 60, 20, 40, 44);
//    [right setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    right.backgroundColor = [UIColor redColor];
//    [right addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:right];
//    [view addSubview:titleLable];
    
    
    UIButton *backButtton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButtton.frame = CGRectMake(15, 30, 20, 20);
    [backButtton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButtton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [view addSubview:backButtton];
    
    _tableView.tableHeaderView = view;
    
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)rightAction:(UIButton *)sender
//{
//    
//    
//    
//}

- (void)tap1
{
    
    NSLog(@"关注");
    //    OthersHomeVC *VC = [[OthersHomeVC alloc] init];
    //    [self.navigationController pushViewController:VC animated:YES];
    GuanZhuListVC *guanzhuVC = [[GuanZhuListVC alloc]init];
    [self.navigationController pushViewController:guanzhuVC animated:YES];
    
}

- (void)tap2
{
    NSLog(@"粉丝");
    FansViewController *fansVC = [[FansViewController alloc]init];
    [self.navigationController pushViewController:fansVC animated:YES];
}



- (void)buttonIsguanzhu
{
    NSLog(@"点击已关注");
//   [isguzhuBtn setTitle:@"已关注" forState:UIControlStateNormal];
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3 + self.dataList.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 3) {
        
        return 1;
        
    }else{
        
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 2) {
        
        static NSString *identifire = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 8, 24, 24)];
            imageView.tag = 100;
            [cell.contentView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, imageView.top, 100, 24)];
            label.textColor = Color_nav;
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 101;
            [cell.contentView addSubview:label];
            
        }
        
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:100];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        if (indexPath.section == 0) {
            
            imageView.image = [UIImage imageNamed:@"个人－私信"];
            label.text = @"给他发私信";
            cell.detailTextLabel.text = @"";

        }else{
            
            imageView.image = [UIImage imageNamed:@"个人－作品"];
            label.text = @"作品";
            cell.detailTextLabel.text = @"100";
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = Color_cell;
        return cell;
        
    }else if(indexPath.section == 1){
        
        static NSString *identifire = @"cellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 40, 30)];
            label.text = @"简介:";
            label.font = [UIFont boldSystemFontOfSize:14];
            label.textColor = Color_nav;
            [cell.contentView addSubview:label];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, label.bottom, kScreenWidth - 40, 160)];
            label1.textColor = [UIColor blackColor];
            label1.font = [UIFont systemFontOfSize:14];
            label1.tag = 99;
            label1.numberOfLines = 0;
            [cell.contentView addSubview:label1];
        }
        UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:99];
        label1.text = @"uiuhfpiquhefqhuefpqieuhfpihpqfiehfpqiehfq";
        [label1 sizeToFit];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = Color_cell;
        return cell;
        
    }else{
        
        static NSString *identifire = @"cellID2";
        WorksCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WorksCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = Color_cell;
        return cell;
        
        
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 3) {
        return NO;
    }
    
    return YES;
    
}


#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (indexPath.section < 3) {
        return nil;
    }
    // 添加一个删除按钮
    UITableViewRowAction *deleterowaction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }];
    
    deleterowaction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    
    return @[deleterowaction];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 3) {
        return 10;
    }
    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 3) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 30)];
    view1.backgroundColor = Color_cell;
    [view addSubview:view1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 100, 30)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"2015-12-3";
    [view1 addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 2 ) {
        return 40;
    }else{
        
        return 170;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSLog(@"给他发私信");
        PrivateDetailVC *vc = [[PrivateDetailVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
    if(indexPath.section == 2){
        
        NSLog(@"作品");
        
        ClassroomVC *vc = [[ClassroomVC alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if (indexPath.section >= 3) {
        ClassroomDetailsVC *vc = [[ClassroomDetailsVC alloc] init];
        vc.isketangji = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    UIColor *color= Color_nav;
    CGFloat offset=scrollView.contentOffset.y;
    if (offset<0) {
        self.nav.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha=1-((64-offset)/64);
        self.nav.backgroundColor=[color colorWithAlphaComponent:alpha];
    }
}


@end
