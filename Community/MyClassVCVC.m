//
//  MyClassVCVC.m
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "MyClassVCVC.h"

@interface MyClassVCVC ()

@end

@implementation MyClassVCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"班级列表";
    self.ISFANHUI = YES;

    self.dataList = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self _loadData];
}

- (void)_loadData
{
    
    
    [WXDataService requestAFWithURL:URL_myClassList params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]]} httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                NSArray *timeList = result[@"result"][@"list"];
                NSMutableArray *marray = [NSMutableArray array];
                for (NSDictionary *subdic in timeList) {
                    ClassModel *model = [[ClassModel alloc] initWithDataDic:subdic];
                    model.cid = subdic[@"id"];
                    [marray addObject:model];
                }

                self.dataList = marray;
                [_tableView reloadData];
            
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];
    

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
    
    
    static NSString *identifire = @"CellID";
    CClassCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CClassCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataList[indexPath.row];
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MemberListVCViewController *vc = [[MemberListVCViewController alloc] init];
    
    ClassModel *model = self.dataList[indexPath.row];
    vc.titlestr = model.title;
    vc.ID = model.cid;
    
    [self.navigationController pushViewController:vc animated:YES];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end















