//
//  ClassroomVC.m
//  Community
//
//  Created by 刘翔 on 16/3/27.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ClassroomVC.h"
#import "ClassHeader.h"
#import "ClassroomDetailsVC.h"

@interface ClassroomVC ()

@end

@implementation ClassroomVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_collection.header beginRefreshing];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.noDataImage.hidden = YES;
    self.text = @"回课记";
    self.view.backgroundColor = Color_bg;
    self.layout.itemSize = CGSizeMake((kScreenWidth - 10) / 2.0,250);
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    self.layout.headerReferenceSize = CGSizeMake(kScreenWidth , 50);
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    self.dataList = [NSMutableArray array];
    
    _collection.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.collection.allowsMultipleSelection = YES;//默认为NO,是否可以多选
    self.collection.backgroundColor = Color_bg;
    
    
    [_collection registerNib:[UINib nibWithNibName:@"ClassromeCell" bundle:nil] forCellWithReuseIdentifier:@"ClassromeCellID"];
//    [_collection registerNib:[UINib nibWithNibName:@"ClassHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerID"];
    
    
    _collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    [_collection.mj_header beginRefreshing];
   _collection.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
    

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
    
    params = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[UserDefaults objectForKey:Userid]};
    
    
    [WXDataService requestAFWithURL:URL_courseMp4List params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        _pageIndex ++;
        
        if(result){
            NSDictionary *dic = result[@"result"];
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                
                NSMutableArray *marray = [NSMutableArray array];
                
                NSArray *array = dic[@"list"];
                
                for (NSDictionary *subDic in array) {
                    KetangModel *model = [[KetangModel alloc] initWithDataDic:subDic];
                    model.hid = subDic[@"id"];
                    [marray addObject:model];
                }
                
                if (_isdownLoad) {
                    self.dataList = marray;
                    if (self.dataList.count == 0) {
                        self.noDataImage.hidden = NO;
                    }else{
                    
                        self.noDataImage.hidden = YES;
                    }
                    
//                    [_collection.mj_header endRefreshing];
                   
                } else {
                    [self.dataList addObjectsFromArray:marray];
//                    [_collection.mj_footer endRefreshing];
                }
                
                if ([dic[@"page"] intValue] == 0) {
                    //没有更多了
                    if (_isdownLoad) {
                        
                        [_collection.mj_header endRefreshing];
                        [_collection.mj_footer endRefreshingWithNoMoreData];
                        
                    } else {
                        
                        [_collection.mj_footer endRefreshing];
                        [_collection.mj_footer endRefreshingWithNoMoreData];
                    }
                    
                    
                
                }else{
                    
                    //还有更多
                    if (_isdownLoad) {
                        
                        [_collection.mj_header endRefreshing];
                        [_collection.mj_footer resetNoMoreData];
                    } else {
                        
                        [_collection.mj_footer endRefreshing];
                        [_collection.mj_footer resetNoMoreData];
                    }
                    
                }
                
                [_collection reloadData];
                
            }
            
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                if (_isdownLoad) {
                    [_collection.mj_header endRefreshing];
                } else {
                    [_collection.mj_footer endRefreshing];
                }
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        if (_isdownLoad) {
            [_collection.mj_header endRefreshing];
        } else {
            [_collection.mj_footer endRefreshing];
        }
        
    }];
    
}



#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    ClassromeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassromeCellID" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.row];
    [cell setNeedsLayout];
    return cell;
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader){
//        
//
//        ClassHeader *_heardView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerID" forIndexPath:indexPath];
//        reusableview = _heardView;
//       
//        
//    }
//    
//    return reusableview;
//    
//}
//

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGSize size=CGSizeMake(kScreenWidth, 40);
//    return size;
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KetangModel *model = self.dataList[indexPath.row];
    
    ClassroomDetailsVC *vc = [[ClassroomDetailsVC alloc] init];
    vc.model = self.dataList[indexPath.row];
    vc.textstr = model.title;
    vc.hid = model.hid;
    vc.course_id = model.course_id;
    vc.isketangji = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
