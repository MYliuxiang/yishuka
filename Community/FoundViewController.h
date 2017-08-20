//
//  FoundViewController.h
//  Community
//
//  Created by 李江 on 16/3/21.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchheaderView.h"
#import "SearchModel.h"
#import "JiGouModel.h"
#import "MapSearchView.h"

@interface FoundViewController : BaseViewController<BMKLocationServiceDelegate>
{
    
    BMKLocationService *_locService;
    int _pageIndex;
    BOOL _isdownLoad;
    MapSearchView *_searchView;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;

}
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,copy) NSString *searchstr1;
@property(nonatomic,copy) NSString *searchstr2;
@property(nonatomic,copy) NSString *searchstr3;

@property (nonatomic,copy) NSString *lon;
@property (nonatomic,copy) NSString *lat;


@property (nonatomic,retain) NSMutableArray *searchList;
@property (nonatomic,retain) NSMutableArray *searChList1;
@property (nonatomic,retain) NSMutableArray *searChList2;

@property (nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,assign) BOOL isFisrt;
@end

















