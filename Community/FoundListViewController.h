//
//  ViewController.h
//  Community
//
//  Created by 刘翔 on 16/3/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchModel.h"
#import "MapJG.h"
#import "LXAnnotation.h"
#import "FounddetailsVC.h"
#import "MapSearchView.h"

@interface FoundListViewController : BaseViewController<BMKLocationServiceDelegate,BMKMapViewDelegate>
{
    
    BMKLocationService *_locService;
    BMKMapView *_mapView;
    MapSearchView *_searchView;
    CLLocationCoordinate2D pt;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;
    
}

@property(nonatomic,copy) NSString *searchstr1;
@property(nonatomic,copy) NSString *searchstr2;
@property(nonatomic,copy) NSString *searchstr3;

@property (nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,copy) NSString *lon;
@property (nonatomic,copy) NSString *lat;
@property (nonatomic,assign) BOOL isFisrt;

@property (nonatomic,retain) NSMutableArray *searChList;
@property (nonatomic,retain) NSMutableArray *searChList1;
@property (nonatomic,retain) NSMutableArray *searChList2;




@end
