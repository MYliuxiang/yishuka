//
//  MemberListVCViewController.m
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "MemberListVCViewController.h"
#import "SendletterVC.h"

@interface MemberListVCViewController ()

@end

@implementation MemberListVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = self.titlestr;
    self.ISFANHUI = YES;
    self.dataList = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self _loadData];
}

- (void)_loadData
{
    
    
    [WXDataService requestAFWithURL:URL_classMemberList params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"class_id":self.ID} httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                NSArray *timeList = result[@"result"][@"list"];
                NSMutableArray *marray = [NSMutableArray array];
                for (NSDictionary *subdic in timeList) {
            SModel *model = [[SModel alloc] initWithDataDic:subdic];
                    model.sid = subdic[@"id"];
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
    SClasscell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SClasscell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataList[indexPath.row];
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
    
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
    SModel *model = self.dataList[indexPath.row];
    SendletterVC *vc = [[SendletterVC alloc] init];
//    vc.model =self.dataList[indexPath.row];
    vc.headimgurl = model.headimgurl;
    vc.name = model.name;
    vc.sid = model.sid;
    [self.navigationController pushViewController:vc animated:YES];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
