//
//  JiaoshiTeamVC.m
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "JiaoshiTeamVC.h"
#import "JiaoshiCell.h"
@interface JiaoshiTeamVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation JiaoshiTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"师资团队";
    self.ISFANHUI = YES;

    self.dataList = [NSMutableArray array];
    [self _initView];
    [self _loadData];

}

- (void)_loadData
{
    
    
    NSDictionary *params;
    
    params = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":self.ID};
    
    
    [WXDataService requestAFWithURL:URL_agencyTeacherList params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                
                NSMutableArray *marray = [NSMutableArray array];
                
                NSArray *array = result[@"result"];
                
                for (NSDictionary *subDic in array) {
                    TeacherModel *model = [[TeacherModel alloc] initWithDataDic:subDic];
                    model.tid = subDic[@"id"];
                    model.cdescription = subDic[@"description"];

                    [marray addObject:model];
                }
                self.dataList = marray;
                [_tableView reloadData];
            }else{
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];
    
    
}


- (void)_initView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"JiaoshiCellID";
    JiaoshiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JiaoshiCell" owner:nil options:nil]lastObject];;
//        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 144-1, kScreenWidth, 1)];
//        lineView.backgroundColor = Color_bg;
//        [cell.contentView addSubview:lineView];
    }
    TeacherModel *model = self.dataList[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JiaoshiCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//JiaoshiCellID

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
