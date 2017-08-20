//
//  CourseListVC.m
//  Community
//
//  Created by 刘翔 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "CourseListVC.h"
#import "CourseListCell.h"

@interface CourseListVC ()

@end

@implementation CourseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"课程列表";
}



#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    CourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CourseListCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = Color_cell;
    }
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = Color_cell;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    imageView.image = [UIImage imageNamed:@"发现－标准课程"];
    [view addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 5, imageView.top, 100, 20)];
    label.text = @"热门课程";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = Color_nav;
    [view addSubview:label];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 15 - 30, 15, 30, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    [button setTitleColor:Color_nav forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    return view;
    

}

#pragma mark --------更多---------
- (void)moreAction
{
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
