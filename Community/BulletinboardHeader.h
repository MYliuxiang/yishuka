//
//  BulletinboardHeader.h
//  Community
//
//  Created by 刘翔 on 16/3/24.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeModel.h"

@interface BulletinboardHeader : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UILabel *dateLabel;
    UIButton *leftButton;
    UIButton *rightButton;

}
@property (nonatomic,retain) NSArray *dataList;
@property (retain, nonatomic)  UICollectionView *collection;
@property (retain, nonatomic)  UICollectionViewFlowLayout *layout;
@property (nonatomic,retain) NSDate *firstDate;
@property (nonatomic,retain) NSDate *lastDate;
@property (nonatomic,retain) NSMutableArray *dateArray;

@property (nonatomic,copy) NSString *lastWeek;
@property (nonatomic,copy) NSString *nextWeek;
@property (nonatomic,copy) NSString *dateStr;

@property (nonatomic,retain) TimeModel *seletedModel;
@property (nonatomic,copy) void (^clickBlock)(TimeModel *timeModel);

@end
