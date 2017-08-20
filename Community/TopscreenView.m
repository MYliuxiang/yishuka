//
//  TopscreenView.m
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "TopscreenView.h"
#import "TopSctollView.h"

@implementation TopscreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorRGB(254, 255, 255, 1);
        self.seltedIndex = 0;

        [self _initViews];
    }
    return self;
}

- (void)_initViews
{

    TopSctollView *view = [[TopSctollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.titleArray = @[@"音乐",@"舞蹈",@"rfqerq"];
    [view initWithTitleButtons];
    view.clickBlock = ^(int index){
    
        NSLog(@"%d",index);
    
    };
    [self addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29, kScreenWidth, 1)];
    imageView.backgroundColor = [UIColor grayColor];
    [self addSubview:imageView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth / 4.0, 180) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];

    [self addSubview:_tableView];
    
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(kScreenWidth/ 4.0,180 / 5.0);
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //self.layout.headerReferenceSize = CGSizeMake(kScreenWidth , 50);
    _layout.minimumLineSpacing = 0;
   _layout.minimumInteritemSpacing = 0;
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenWidth / 4.0 , 30, kScreenWidth / 4.0 * 3, 180) collectionViewLayout:_layout];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    _collection.bounces = NO;
    _collection.backgroundColor = [UIColor clearColor];
    [self addSubview:_collection];
    
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4.0, 60)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 99;
        [cell.contentView addSubview:label];
        
        cell.backgroundColor = ColorRGB(230, 231, 232, 1);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4.0, 60)];
        view.backgroundColor = ColorRGB(247, 248, 249, 1);
        cell.selectedBackgroundView = view;
        
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:99];
    label.text = @"声乐";
    if (indexPath.row == self.seltedIndex) {
        
        cell.selected = YES;
        
    }else{
    
        cell.selected = NO;
    }
    
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
    return 60;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}



#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 28;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,8, kScreenWidth / 4.0 - 20,24)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 3;
    label.layer.masksToBounds = YES;
    label.layer.borderColor = ColorRGB(230, 231, 232, 1).CGColor;
    label.layer.borderWidth = 1;
    label.text = @"古筝";
    [cell.contentView addSubview:label];
    [cell setNeedsLayout];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}




@end
