//
//  TeXukechengVC.m
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "TeXukechengVC.h"
#import "texukechengDetailVC.h"
#import "KClassVC.h"
@interface TeXukechengVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation TeXukechengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataList = [NSMutableArray array];
    self.ISFANHUI = YES;

    if (self.isSpecial) {
        self.text = @"特需课程";
    }else{
    
        self.text = @"标准课程";

    }
    [self _initView];
    [self _loadData];
}

- (void)_loadData
{

    NSDictionary *params;
    
    params = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":self.ID};
    
    
    NSString *url;
    
    if (self.isSpecial) {
        url =URL_agencySpecialCourseType;
    
    }else{
    
        
        url = URL_agencyStandCourseType;
        
    }
    
    
    [WXDataService requestAFWithURL:url params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                                
                NSMutableArray *marray = [NSMutableArray array];
                
                NSArray *array = result[@"result"];
                
                for (NSDictionary *subDic in array) {
                    SpecialModel *model = [[SpecialModel alloc] initWithDataDic:subDic];
                    model.sid = subDic[@"id"];
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50-1, kScreenWidth, 1)];
        lineView.backgroundColor = Color_bg;
        [cell.contentView addSubview:lineView];
    }

    SpecialModel *model = self.dataList[indexPath.row];
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = model.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KClassVC *texuVC = [[KClassVC alloc]init];
    SpecialModel *model = self.dataList[indexPath.row];
    texuVC.model = model;
    texuVC.istc = NO;
    [self.navigationController pushViewController:texuVC animated:YES];

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
