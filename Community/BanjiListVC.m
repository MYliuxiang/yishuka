//
//  BanjiListVC.m
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BanjiListVC.h"
#import "BanjiListCell.h"
#import "FabuGongGaoVC.h"
@interface BanjiListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation BanjiListVC{

    int _pageIndex;
    BOOL _isdownLoad;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"班级列表";
    self.ISFANHUI = YES;

    [self _initView];
}



- (void)pinglundataservice
{
    
//    NSDictionary *params;
//    
//    params = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":@"1",@"id":self.ID};
//    
//    
//    [WXDataService requestAFWithURL:URL_agencyInfoCommentList params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
//        
//        _pageIndex ++;
//        
//        if(result){
//            NSDictionary *dic = result[@"result"];
//            
//            if ([[result objectForKey:@"status"] integerValue] == 0) {
//                
//                NSMutableArray *marray = [NSMutableArray array];
//                NSArray *array = dic[@"list"];
//                
//                for (NSDictionary *subDic in array) {
//                    PLModel *model = [[PLModel alloc] initWithDataDic:subDic];
//                    //                    model.hid = subDic[@"id"];
//                    [marray addObject:model];
//                }
//                
//                if (_isdownLoad) {
//                    self.dataList = marray;
//                    
//                    [_tableView.header endRefreshing];
//                    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
//                } else {
//                    [self.dataList addObjectsFromArray:marray];
//                    [_tableView.footer endRefreshing];
//                }
//                
//                if ([dic[@"page"] intValue] == 0) {
//                    //没有更多了
//                    if (_isdownLoad) {
//                        
//                        [_tableView.header endRefreshing];
//                        [_tableView.footer endRefreshingWithNoMoreData];
//                    } else {
//                        
//                        [_tableView.footer endRefreshing];
//                        [_tableView.footer endRefreshingWithNoMoreData];
//                    }
//                    
//                    
//                }else{
//                    //还有更多
//                    if (_isdownLoad) {
//                        
//                        [_tableView.header endRefreshing];
//                        [_tableView.footer resetNoMoreData];
//                    } else {
//                        
//                        [_tableView.footer endRefreshing];
//                        [_tableView.footer resetNoMoreData];
//                    }
//                    
//                }
//                
//                [_tableView reloadData];
//                
//            }
//            
//            //没有数据了
//            if ([[result objectForKey:@"status"] integerValue] == 1) {
//                if (_isdownLoad) {
//                    [_tableView.header endRefreshing];
//                } else {
//                    [_tableView.footer endRefreshing];
//                }
//                
//                [MBProgressHUD showError:result[@"msg"] toView:self.view];
//                
//            }
//        }
//    } errorBlock:^(NSError *error) {
//        NSLog(@"%@",error);
//        
//        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
//        
//        if (_isdownLoad) {
//            [_tableView.header endRefreshing];
//        } else {
//            [_tableView.footer endRefreshing];
//        }
//        
//    }];
    
}



////下啦刷新
- (void)downLoad
{
    _isdownLoad = YES;
    _pageIndex = 1;
    [self pinglundataservice];
    
}

//上啦加载
- (void)upLoad
{
    _isdownLoad = NO;
    [self pinglundataservice];
    
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
    _tableView.rowHeight = 90;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"BanjiListCellID";
    BanjiListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BanjiListCell" owner:nil options:nil]lastObject];;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 90-1, kScreenWidth, 1)];
        lineView.backgroundColor = Color_bg;
        [cell.contentView addSubview:lineView];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    FabuGongGaoVC *fabuVC = [[FabuGongGaoVC alloc]init];
    [self.navigationController pushViewController:fabuVC animated:YES];
    
    
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
