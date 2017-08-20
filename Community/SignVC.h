//
//  SignVC.h
//  Community
//
//  Created by 刘翔 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "SignCell.h"
#import "FooterReusableView.h"
@interface SignVC : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,retain)NSMutableArray *dataList;

@end
