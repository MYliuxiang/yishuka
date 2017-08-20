//
//  ViewController.m
//  Community
//
//  Created by 刘翔 on 16/3/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FoundListViewController.h"
#import "FoundListCell.h"
#import "FounddetailsVC.h"
@interface FoundListViewController ()<UITableViewDataSource,UITableViewDelegate,BMKMapViewDelegate>

@end

@implementation FoundListViewController{

    NSString *_identify;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"发现";
    
    self.lat = [NSString string];
    self.lon = [NSString string];    
    self.searchstr1 = [NSString string];
    self.searchstr2 = [NSString string];
    self.searchstr3 = [NSString string];
    self.isFisrt = YES;

    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    self.dataList = [NSMutableArray array];
    self.searChList = [NSMutableArray array];
    self.searChList2 = [NSMutableArray array];
    self.searChList1 = [NSMutableArray array];


    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64 + 40, kScreenWidth , kScreenHeight - 64 - 40)];
    _mapView.zoomLevel = 5;
    [self.view addSubview:_mapView];

    [_mapView setShowsUserLocation:YES];//显示定位的蓝点儿
    
    [self.view addSubview:_mapView];
    
}

- (void)_initView
{
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
        
        NSLog(@"%d",tag);
        //        SearchModel *model = self.searchList[self.setecd];
        if (tag == 1) {
            [UIView animateWithDuration:.35 animations:^{
                if(_tableView1.height > 0){
                    _tableView1.height = 0;
                    
                }else{
                    
                    _tableView1.height = 40 * (self.searChList.count + 1) > 200 ? 200:40 *(self.searChList.count + 1);
                    
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
                    
                    _tableView3.height = 40 * (self.searChList2.count + 1) > 200 ? 200:40 * (self.searChList2.count + 1);
                    
                }
            } completion:^(BOOL finished) {
                
            }];
        
        }
        
    };


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableView1) {
        
        return self.searChList.count + 1;
        
    }
    if (tableView == _tableView2){
        
        return self.searChList1.count + 1;
    }
    
    return self.searChList2.count + 1;
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
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
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
        
        label.text = self.searChList[indexPath.section - 1];
        
    }else if(tableView == _tableView2){
        
        SearchModel *model = self.searChList1[indexPath.section - 1];
        label.text = model.title;
        
    }else{
    
        SearchModel *model = self.searChList2[indexPath.section - 1];
        label.text = model.title;    }
    
    }
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
        return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        if (tableView == _tableView1) {
            
            [UIView animateWithDuration:.35 animations:^{
                _tableView1.height = 0;
                _tableView2.height = 0;
                _tableView3.height = 0;

                
            } completion:^(BOOL finished) {
                
            }];
            
            if(indexPath.section == 0){
            
                self.searchstr1 = @"";

                _searchView.text1 = @"定位";

                [self _loadData];
            }else{
            
            self.searchstr1 = self.searChList[indexPath.section - 1];
                _searchView.text1 = self.searChList[indexPath.section - 1];
              
            [self _loadData];
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

                [self _loadData];
            }else{

            SearchModel *model = self.searChList1[indexPath.section - 1];
                if(indexPath.section == 1){
                    
                    self.searchstr2 = @"1";
                    
                }else{
                    
                    self.searchstr2 = @"0";
                    
                }
              
                _searchView.text2 = model.title;

            [self _loadData];
            }
            
        }else{
        
            [UIView animateWithDuration:.35 animations:^{
                _tableView1.height = 0;
                _tableView2.height = 0;
                _tableView3.height = 0;
                
            } completion:^(BOOL finished) {
                
            }];

            if(indexPath.section == 0){
                
              
                self.searchstr3 = @"";
                _searchView.text3 = @"类别不限";

                [self _loadData];
            }else{

            SearchModel *model = self.searChList2[indexPath.section - 1];
                _searchView.text3 = model.title;
               
            self.searchstr3 = model.sid;
            [self _loadData];
            }

        }


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
    
    [self _loadData];
    
    
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self _loadData];
    
}



- (void)_loadData
{
    
    NSDictionary *params;
    params = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"join":self.searchstr2,@"course_type":self.searchstr3,@"lon":self.lon,@"lat":self.lat,@"search_city_list":self.searchstr1};
    

    [WXDataService requestAFWithURL:Url_agencyListMap params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        
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
                    self.searChList2 = marray;
                    
                    
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
                    self.searChList = marray2;
                    
                    self.isFisrt = NO;
                    [_tableView1 reloadData];
                    [_tableView2 reloadData];
                    [_tableView3 reloadData];
                    
//                    [_tableView1 reloadData];
//                    [_tableView2 reloadData];
                    [self _initView];
                }
                
                
                NSMutableArray *marray = [NSMutableArray array];
                
                NSArray *array = dic[@"list"];
                
                for (NSDictionary *subDic in array) {
                    MapJG *model = [[MapJG alloc] initWithDataDic:subDic];
                    model.jid = subDic[@"id"];
                    [marray addObject:model];
                }
                
                self.dataList = marray;
                [self addAnimation];
                
            }
            
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
               
                [self.dataList removeAllObjects];
                [self addAnimation];
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
     
        
    }];




}

#pragma mark -------添加标注------------
- (void)addAnimation
{
    NSArray *arrayAnmation=[[NSArray alloc] initWithArray:_mapView.annotations];
    [_mapView removeAnnotations:arrayAnmation];
    for (int i = 0; i < self.dataList.count; i++) {
        
        MapJG *model = self.dataList[i];
        pt=(CLLocationCoordinate2D){0,0};
        pt=(CLLocationCoordinate2D){[model.lat floatValue],[model.lon floatValue]};
        
        LXAnnotation *annotation = [[LXAnnotation alloc]init];
        annotation.coordinate = pt;
        annotation.title = model.title;
        annotation.model = model;
        [_mapView  addAnnotation:annotation];
        

        if (i == 0) {
            
            BMKCoordinateRegion region;
            region.center.latitude  = [model.lat floatValue];
            region.center.longitude = [model.lon floatValue];
            region.span.latitudeDelta  = 0.3;
            region.span.longitudeDelta = 0.3;
            _mapView.region = region;
            [_mapView selectAnnotation:annotation animated:YES];

        }

    }

//    [_mapView showAnnotations:_mapView.annotations animated:YES];


}

//-(void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//    
//        
//        BMKPinAnnotationView *piview = (BMKPinAnnotationView *)[views objectAtIndex:views.count - 1];
//        [_mapView selectAnnotation:piview.annotation animated:YES];
//
//    
//    
//}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isMemberOfClass:[LXAnnotation class]]) {
        
        LXAnnotation *an = annotation;

        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.annotation=annotation;

//        UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
//        
//        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
//        
//        [imageview setImage:[UIImage imageNamed:@"首页－星秀场"]];
//        
//        
//        [viewForImage addSubview:imageview];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
//        NSMutableString *str = [NSMutableString stringWithFormat:@"%@",an.model.title];
//        [str insertString:@"\n" atIndex:(str.length / 2.0)];
//        label.text = str;
//        label.textColor = [UIColor redColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.numberOfLines = 2;
//        label.font = [UIFont systemFontOfSize:12];
//        [imageview addSubview:label];
//        
        
//        newAnnotationView.image = [self getImageFromView:viewForImage];
        
        
        
//        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:[UIView new]];
//        pView.frame = CGRectMake(0, 0, 0, 0);
//        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = nil;
//        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = pView;
        return newAnnotationView;
        
        
    }else{
    
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.annotation=annotation;
        return newAnnotationView;
        
    }
    
}

-(UIImage *)getImageFromView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
  
}
/**
 *  选中气泡调用方法
 *  @param mapView 地图
 *  @param view    annotation
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    LXAnnotation *an = view.annotation;
    FounddetailsVC *founddetailVC = [[FounddetailsVC alloc]init];
    founddetailVC.ID = an.model.jid;
    founddetailVC.textstr = an.model.title;

    [self.navigationController pushViewController:founddetailVC animated:YES];
    

}

- (void)back
{
    CATransition *animation1=[CATransition animation];
    //然后设置切换的时间，即动画的时间
    animation1.duration=.35;
    animation1.type=@"cube";
    animation1.subtype = @"fromRight";
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [self.navigationController.view.layer addAnimation:animation1 forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];

}


@end
