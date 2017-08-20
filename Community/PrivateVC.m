//
//  PrivateVC.m
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "PrivateVC.h"
#import "PrivateDetailVC.h"

@interface PrivateVC ()

@end

@implementation PrivateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"私信";
    self.ISFANHUI = YES;
    self.dataList = [NSMutableArray array];
//    for (int i = 0; i < 7; i++) {
//        [self.dataList addObject:@"1"];
//    }
//    [self _initViews];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];

}

////下啦刷新
- (void)downLoad
{
    _isdownLoad = YES;
    _pageIndex = 1;
    [self _loadData];
    
}

//上啦加载
- (void)upLoad
{
    _isdownLoad = NO;
    [self _loadData];
    
}

- (void)_loadData
{
    
    NSDictionary *params;
        params = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]]};
    
    [WXDataService requestAFWithURL:URL_myNoteList params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        _pageIndex ++;
        
        if(result){
            
            
            NSDictionary *dic = result[@"result"];
            
            //还有数据
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
               
                NSMutableArray *marray = [NSMutableArray array];
                NSArray *array = dic[@"list"];
                for (NSDictionary *subDic in array) {
                    NoteModel *model = [[NoteModel alloc] initWithDataDic:subDic];
                    model.nid = subDic[@"id"];
                    model.content = subDic[@"description"];
                    [marray addObject:model];
                }
                
                if (_isdownLoad) {
                    self.dataList = marray;

                } else {
                    [self.dataList addObjectsFromArray:marray];
                }
                
                  if ([dic[@"page"] intValue] == 0) {
                      //没有更多了
                      if (_isdownLoad) {
                        
                          [self.tableView.mj_header endRefreshing];
                          [self.tableView.mj_footer endRefreshingWithNoMoreData];
                          
                      } else {
                         
                          [self.tableView.mj_footer endRefreshing];
                          [self.tableView.mj_footer endRefreshingWithNoMoreData];
                      }

                      
                  }else{
                  //还有更多
                      if (_isdownLoad) {
                          
                          [self.tableView.mj_header endRefreshing];
                          [self.tableView.mj_footer resetNoMoreData];
                      } else {
                          
                          [self.tableView.mj_footer endRefreshing];
                          [self.tableView.mj_footer resetNoMoreData];
                      }

                      
                  }
                
                [self.tableView reloadData];
                
            }
                
           //请求失败
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                
                if (_isdownLoad) {
                    [self.tableView.mj_header endRefreshing];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];

        if (_isdownLoad) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];
    
}




- (void)_initViews
{
    self.tableView.tableFooterView = self.headerView;
    self.fankuiBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.fankuiBtn.layer.borderWidth = .5;


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
    PrivateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"PrivateCell" owner:nil options:nil]lastObject];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataList[indexPath.row];
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PrivateCell whc_CellHeightForIndexPath:indexPath tableView:tableView];

}

#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // 添加一个删除按钮
    UITableViewRowAction *deleterowaction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NoteModel *model = _dataList[indexPath.row];

        
        [WXDataService requestAFWithURL:URL_myNoteDel params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":model.nid} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
            
            if(result){
                
                if ([[result objectForKey:@"status"] integerValue] == 0) {
                    
                    [self.dataList removeObjectAtIndex:indexPath.row];
                    [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
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
        
      
        
    }];
    
    deleterowaction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    
    return @[deleterowaction];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivateDetailVC *vc = [[PrivateDetailVC alloc] init];
    vc.model = self.dataList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)fankuiAction:(id)sender {
    NSLog(@"反馈问题");
}

- (IBAction)yiduAction:(id)sender {
    
    NSLog(@"删除已读");
}
@end













