//
//  FoundViewController.m
//  Community
//
//  Created by 李江 on 16/3/21.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FoundViewController.h"
#import "FoundListViewController.h"
#import "ProfessionalchoiceViewController.h"
#import "FoundListCell.h"
#import "FounddetailsVC.h"

@interface FoundViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation FoundViewController
{
    NSString *_identify;


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _locService.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    _locService.delegate = nil; // 不用时，置nil
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    


    self.text = @"发现";
//    [self addrightImage:@"发现－列表"];
//    [self _InitView];
    self.searchList = [NSMutableArray array];
    self.searChList1 = [NSMutableArray array];
    self.searChList2 = [NSMutableArray array];
    
    
    self.searchstr3 = [NSString string];
    self.searchstr1 = [NSString string];
    self.searchstr2 = [NSString string];
    self.lat = [NSString string];
    self.lon = [NSString string];
    self.isFisrt = YES;
    
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 60 - 15, 20 + (self.nav.height - 20 - 50 / 2.0) / 2.0 , 60, 60 / 2.0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"查看地图" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(rightAC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,104, kScreenWidth, kScreenHeight-64 - 49 - 40) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource =self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];

    
    _identify = @"FoundListCell";
    [_tableview registerNib:[UINib nibWithNibName:@"FoundListCell" bundle:nil] forCellReuseIdentifier:_identify];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];

}

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.lon = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    self.lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    [_locService stopUserLocationService];
    
    [self.tableview.mj_header beginRefreshing];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [self.tableview addGestureRecognizer:tap];
    

}
//- (void)tap
//{
//
//    [UIView animateWithDuration:.35 animations:^{
//        _tableView1.height = 0;
//        _tableView2.height = 0;
//        _tableView3.height = 0;
//        
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//
//
//}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    
//    [UIView animateWithDuration:.35 animations:^{
//        _tableView1.height = 0;
//        _tableView2.height = 0;
//        _tableView3.height = 0;
//        
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//
//    
//
//
//}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self.tableview.mj_header beginRefreshing];

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
    
   
    params = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"join":self.searchstr2,@"course_type":self.searchstr1,@"lon":self.lon,@"lat":self.lat,@"search_city_list":self.searchstr3};
        
    
    [WXDataService requestAFWithURL:URL_agencyList params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        _pageIndex ++;
        
        if(result){
            NSDictionary *dic = result[@"result"];
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                if (_isFisrt){
                    
                    NSArray *array = dic[@"search_course_type"];
                    NSMutableArray *marray = [NSMutableArray array];
                    for (NSDictionary *subdic in array) {
                        SearchModel *model = [[SearchModel alloc] initWithDataDic:subdic];
                        model.sid = subdic[@"id"];
                        [marray addObject:model];
                    }
                    self.searchList = marray;
                    
                    
                    NSArray *array1 = dic[@"search_join"];
                    NSMutableArray *marray1 = [NSMutableArray array];
                    for (NSDictionary *subdic in array1) {
                        SearchModel *model = [[SearchModel alloc] initWithDataDic:subdic];
                        model.sid = subdic[@"id"];
                        [marray1 addObject:model];
                    }
                    self.searChList1 = marray1;
                    
                    NSArray *array2 = dic[@"search_city_list"];
                    NSMutableArray *marray2 = [NSMutableArray array];
                    for (NSDictionary *subdic in array2) {
                        NSString *city = subdic[@"city"];
                        [marray2 addObject:city];
                    }
                    self.searChList2 = marray2;
                    
                    self.isFisrt = NO;
                    [_tableView1 reloadData];
                    [_tableView2 reloadData];
                    [_tableView3 reloadData];
                    [self _InitView];
                }

                
                NSMutableArray *marray = [NSMutableArray array];
                NSArray *array = dic[@"list"];
                for (NSDictionary *subDic in array) {
                    JiGouModel *model = [[JiGouModel alloc] initWithDataDic:subDic];
                    model.jid = subDic[@"id"];
                    [marray addObject:model];
                }
                
                if (_isdownLoad) {
                    self.dataList = marray;
                    
                    [self.tableview.mj_header endRefreshing];
                    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
                } else {
                    [self.dataList addObjectsFromArray:marray];
                    [self.tableview.mj_footer endRefreshing];
                }
                
                if ([dic[@"page"] intValue] == 0) {
                    //没有更多了
                    if (_isdownLoad) {
                        
                        [self.tableview.mj_header endRefreshing];
                        [self.tableview.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        
                        [self.tableview.mj_footer endRefreshing];
                        [self.tableview.mj_footer endRefreshingWithNoMoreData];
                    }
                    
                    
                }else{
                    //还有更多
                    if (_isdownLoad) {
                        
                        [self.tableview.mj_header endRefreshing];
                        [self.tableview.mj_footer resetNoMoreData];
                        
                    } else {
                        
                        [self.tableview.mj_footer endRefreshing];
                        [self.tableview.mj_footer resetNoMoreData];
                    }
                    
                }
                
                [self.tableview reloadData];
                
            }
            
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                if (_isdownLoad) {
                    [self.tableview.mj_header endRefreshing];
                    [self.dataList removeAllObjects];
                    [self.tableview reloadData];
                } else {
                    [self.tableview.mj_footer endRefreshing];
                }
                
            
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];

        if (_isdownLoad) {
            [self.tableview.mj_header endRefreshing];
        } else {
            [self.tableview.mj_footer endRefreshing];
        }
        
    }];

}


- (void)rightAC
{
    
    CATransition *animation1=[CATransition animation];
    //然后设置切换的时间，即动画的时间
    animation1.duration=.35;
     animation1.type=@"cube";
    animation1.subtype = @"fromLeft";
     [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:animation1 forKey:nil];
    FoundListViewController *foundlistVC = [[FoundListViewController alloc]init];
    foundlistVC.ISFANHUI = YES;
    [self.navigationController pushViewController:foundlistVC animated:YES];

}


-(void)back
{
    ProfessionalchoiceViewController *professionVC = [[ProfessionalchoiceViewController alloc]init];
    [self.navigationController pushViewController:professionVC animated:YES];

}

- (void)_InitView{
    
    
    _searchView = [MapSearchView viewFromNIB];
    _searchView.height = 40;
    _searchView.top = 64;
    _searchView.width = kScreenWidth;
    [self.view addSubview:_searchView];
    
    _searchView.text1 = @"定位";
    _searchView.text2 = @"全部";
    _searchView.text3 = @"类别不限";
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, kScreenWidth/ 3.0, 0) style:UITableViewStyleGrouped];
    //    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.showsHorizontalScrollIndicator = NO;
    _tableView1.showsVerticalScrollIndicator = NO;
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView1];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(_tableView1.right, _searchView.bottom, kScreenWidth / 3.0, 0) style:UITableViewStyleGrouped];
    //    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.showsHorizontalScrollIndicator = NO;
    _tableView2.showsVerticalScrollIndicator = NO;
    _tableView2.dataSource = self;
    _tableView2.delegate = self;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView2];
    
    _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(_tableView2.right, _searchView.bottom, kScreenWidth/ 3.0, 0) style:UITableViewStyleGrouped];
    //    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView3.showsHorizontalScrollIndicator = NO;
    _tableView3.showsVerticalScrollIndicator = NO;
    _tableView3.dataSource = self;
    _tableView3.delegate = self;
    _tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView3];
    
    _searchView.clik = ^(int tag){
        
        //        SearchModel *model = self.searchList[self.setecd];
        if (tag == 1) {
            [UIView animateWithDuration:.35 animations:^{
                if(_tableView1.height > 0){
                    _tableView1.height = 0;
                    
                }else{
                    
                    _tableView1.height = 40 * (self.searChList2.count + 1) > 200 ? 200:40 *(self.searChList2.count + 1);
                    
                }
                _tableView2.height = 0;
                _tableView3.height = 0;
            } completion:^(BOOL finished) {
                
            }];
            
        }else if(tag == 2){
            
            [UIView animateWithDuration:.35 animations:^{
                _tableView1.height = 0;
                _tableView3.height = 0;
                
                if(_tableView2.height > 0){
                    _tableView2.height = 0;
                    
                }else{
                    
                    _tableView2.height = 40 * (self.searChList1.count + 1) > 200 ? 200:40 *(self.searChList1.count + 1);
                    
                }
            } completion:^(BOOL finished) {
                
            }];
        }else{
            
            [UIView animateWithDuration:.35 animations:^{
                _tableView1.height = 0;
                _tableView2.height = 0;
                
                if(_tableView3.height > 0){
                    _tableView3.height = 0;
                    
                }else{
                    
                    _tableView3.height = 40 * (self.searchList.count + 1) > 200 ? 200:40 *(self.searchList.count + 1);
                    
                }
            } completion:^(BOOL finished) {
                
            }];
            
        }
        
    };
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableView1) {
        
        return self.searChList2.count + 1;
        
    }
    if (tableView == _tableView2){
       
        return  self.searChList1.count + 1;
    }
    if(tableView == _tableView3){
    
        return self.searchList.count + 1;
    }

    return self.dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView ==_tableview) {
        return 10;

    }else{
    
        return .1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableview) {
        
        FoundListCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.model = self.dataList[indexPath.section];
        
        return cell;

    }
    
    
    static NSString *identifire1 = @"cellID1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 3.0, 40)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.tag = 100;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
  
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    if(indexPath.section == 0){
    
        label.text = @"全部";

        
    }else{
    if (tableView == _tableView1){
        
        label.text = self.searChList2[indexPath.section - 1];

        
    }else if(tableView == _tableView2){
    
        SearchModel *model = self.searChList1[indexPath.section - 1];
        label.text = model.title;

    }else{
    
        SearchModel *model = self.searchList[indexPath.section - 1];
        label.text = model.title;

    }
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableview) {
        
        return 105;
        
    }else{
        
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
       if (tableView == _tableview) {
           
           JiGouModel *model = self.dataList[indexPath.section];
           FounddetailsVC *founddetailVC = [[FounddetailsVC alloc]init];
           founddetailVC.ID = model.jid;
           founddetailVC.textstr = model.title;
           [self.navigationController pushViewController:founddetailVC animated:YES];
           
    }else{
        
        if (tableView == _tableView1) {
            
            [UIView animateWithDuration:.35 animations:^{
                    _tableView1.height = 0;
                    _tableView2.height = 0;
                    _tableView3.height = 0;

               
            } completion:^(BOOL finished) {
                
            }];
            
            
            if(indexPath.section == 0){
                
                _searchView.text1 = @"定位";
                self.searchstr3 = @"";
                [self.tableview.mj_header beginRefreshing];
                
            }else{
                
                
                self.searchstr3 = self.searChList2[indexPath.section - 1];
                _searchView.text1 = self.searChList2[indexPath.section - 1];
                               [self.tableview.mj_header beginRefreshing];
                
            }
            
            
        }else if(tableView == _tableView2){
            
            
            [UIView animateWithDuration:.35 animations:^{
                _tableView1.height = 0;
                _tableView2.height = 0;
                _tableView3.height = 0;


            } completion:^(BOOL finished) {
                
            }];
            
            
            
            
            if(indexPath.section == 0){
            
                self.searchstr2 = @"";
                _searchView.text2 = @"全部";

                [self.tableview.mj_header beginRefreshing];
            
            }else{
            
                SearchModel *model = self.searChList1[indexPath.section - 1];
                if(indexPath.section == 1){
                
                    self.searchstr2 = @"1";

                }else{
                
                    self.searchstr2 = @"0";

                }
                              _searchView.text2 = model.title;

                [self.tableview.mj_header beginRefreshing];
            
            }
        


            
        }else{
        
            [UIView animateWithDuration:.35 animations:^{
                _tableView1.height = 0;
                _tableView2.height = 0;
                _tableView3.height = 0;
                
                
            } completion:^(BOOL finished) {
                
            }];
            
            if(indexPath.section == 0){
                
              
                self.searchstr1 = @"";
                _searchView.text3 = @"类别不限";
                [self.tableview.mj_header beginRefreshing];
                
            }else{
                
                SearchModel *model = self.searchList[indexPath.section - 1];
                self.searchstr1 = model.sid;
                _searchView.text3 = model.title;
              

                [self.tableview.mj_header beginRefreshing];
                
            }
            
        }
        
    }
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
