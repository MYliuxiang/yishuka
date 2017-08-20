//
//  ScrollView.h
//  LunBoTuDemo
//
//  Created by 邱云翔 on 15/12/27.
//  Copyright © 2015年 old Driver. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewDelegate <NSObject>

- (void)tapImageView:(NSInteger)index;

@end

@interface ScrollView : UIView
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIPageControl *pageVC;
@property (nonatomic,strong) UIView *view;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSArray *imageDataArr;
@property (nonatomic,assign) id <ScrollViewDelegate> delegate;

//传入替换数据源
- (void)replaceCurrentDataArrayWithArray:(NSArray *)array;

//子类重写此方法
- (void)setUpValueForImageViewWith:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;


@end