//
//  ClasslistViewController.m
//  Community
//
//  Created by 李立 on 16/5/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ClasslistViewController.h"
#import "ClasslistCell.h"
@implementation ClasslistViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.text = @"班级列表";
    [self _initView];

}


//初始化视图
-(void)_initView
{

    
    //创建表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth  , kScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    
    //头视图
    _tableView.tableHeaderView = ({
        UIView *bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        
        bjview;
        
    });
    
    //尾视图
    _tableView.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
              footerbjView;
        
        
    });
    
    [self.view addSubview:_tableView];
    



}



//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return 80;
    
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
    
}

//尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    ClasslistCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ClasslistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 80-0.5, kScreenWidth, .5)];
                lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        [cell.contentView addSubview:lineview];
    }
       return cell;
    
}

//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    
    
}


@end
