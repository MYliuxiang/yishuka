//
//  LJShouCangVC.h
//  Community
//
//  Created by 李江 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "ClassromeCell.h"
#import "KetangModel.h"
@interface LJShouCangVC : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    int _pageIndex;
    BOOL _isdownLoad;
    
    
}
@property (nonatomic,retain)NSMutableArray *dataList;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@end
