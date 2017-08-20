//
//  GuanZhuListVC.m
//  Community
//
//  Created by lijiang on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "GuanZhuListVC.h"
#import "FansTableViewCell.h"
#import "OthersHomeVC.h"
@interface GuanZhuListVC ()

@end

@implementation GuanZhuListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"关注";
    [self _initView];
    
}
//初始化视图
-(void)_initView
{
   
    //创建表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth  , kScreenHeight - 64) style:UITableViewStyleGrouped];
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
        [cell initTouxiangImageView:@"001" NameLabel:@"李立立" CategoryLabel:@"老师" BiaozhuLabel:@"器乐 钢琴" FollowButton:@"取消关注"];

    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OthersHomeVC *othershomeVC = [[OthersHomeVC alloc]init];
    [self.navigationController pushViewController:othershomeVC animated:YES];

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
