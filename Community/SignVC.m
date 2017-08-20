//
//  SignVC.m
//  Community
//
//  Created by 刘翔 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SignVC.h"

@interface SignVC ()

@end

@implementation SignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text =  @"签到";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    //控制UICollectionView 的样式和布局等
    
    self.layout.itemSize = CGSizeMake(kScreenWidth / 4.0,90);
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    self.layout.headerReferenceSize = CGSizeMake(kScreenWidth , 50);
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;

    
    _collection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collection.allowsMultipleSelection = YES;//默认为NO,是否可以多选

    
    [_collection registerNib:[UINib nibWithNibName:@"SignCell" bundle:nil] forCellWithReuseIdentifier:@"SignCellID"];
    [_collection registerNib:[UINib nibWithNibName:@"FooterReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterID"];
  
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    SignCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SignCellID" forIndexPath:indexPath];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [view addSubview:view1];
    
    //    view1.layer.borderColor = [UIColor redColor].CGColor;
    //    view1.layer.borderWidth = 2;
    view1.center = CGPointMake(kScreenWidth / 4.0 / 2.0, 30);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 45, 15, 15)];
    imageView.image = [UIImage imageNamed:@"选择－黄色"];
    [view1 addSubview:imageView];
    
    cell.selectedBackgroundView = view;
    [cell bringSubviewToFront:cell.selectedBackgroundView];


    [cell setNeedsLayout];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{

    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionFooter){


       FooterReusableView *_footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterID" forIndexPath:indexPath];
        reusableview = _footerView;
        _footerView.clickBlock = ^(int i){
        
            NSLog(@"确定");
            
        };

    }

    return reusableview;

}
//
////返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size=CGSizeMake(kScreenWidth, 100);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
       
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
