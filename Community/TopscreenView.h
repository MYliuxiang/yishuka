//
//  TopscreenView.h
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopscreenView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UICollectionView *_collection;
    UICollectionViewFlowLayout *_layout;

}
@property (nonatomic,assign)int seltedIndex;
@end
