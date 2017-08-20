//
//  SignAginVC.m
//  Community
//
//  Created by 刘翔 on 16/5/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SignAginVC.h"
#import "SignAginCell.h"

@interface SignAginVC ()

@end

@implementation SignAginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"签到";
    self.dataList = [NSMutableArray array];
    [self _loadData];
    
    
    
}

- (void)_loadData
{
    
    [WXDataService requestAFWithURL:URL_infoClassSignPage params:@{@"id":self.model.bid,@"class_id":self.model.class_id} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        
 
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                NSArray *list = result[@"result"][@"list"];
                NSMutableArray *marray = [NSMutableArray array];
                for (NSDictionary *subdic in list) {
                    SignModel *model = [[SignModel alloc] initWithDataDic:subdic];
                    model.mobilePhone = subdic[@"mobile"];
                    model.sid = subdic[@"id"];
                    [marray addObject:model];
                }
                
                self.dataList = marray;
                [self.tableView reloadData];
                
             }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
  
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    SignAginCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SignAginCell" owner:nil options:nil]lastObject];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataList[indexPath.row];
    cell.status = self.model.status;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 30)];
    label.text = [NSString stringWithFormat:@"%@(%lu人)",self.model.class_name,(unsigned long)_dataList.count];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    view.backgroundColor = Color(240, 240, 240);
    [view addSubview:label];
    return view;

}

@end





















