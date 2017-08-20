//
//  ClassroomVC.h
//  Community
//
//  Created by 刘翔 on 16/3/27.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "ClassromeCell.h"
#import "KetangModel.h"

@interface ClassroomVC : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    int _pageIndex;
    BOOL _isdownLoad;


}
@property (weak, nonatomic) IBOutlet UIImageView *noDataImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,retain)NSMutableArray *dataList;

@end
