//
//  NJBannerView.h
//  BannerViewDemo
//
//  Created by JLee Chen on 16/6/27.
//  Copyright © 2016年 JLee Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJBannerView : UIView

- (id) initWithFrame:(CGRect)frame placeholderImg:(UIImage *) placeholderImg;

/**
 *  datas:字典数组，key:img,value:本地图片名或网络图片地址
 */
@property (copy , nonatomic) NSMutableArray *datas;
/**
 *  点击图片回调事件
 */
@property (copy , nonatomic) void(^linkAction)(NSString *link);

@property (copy , nonatomic) UIColor *pageIndicatorTintColor;
@property (copy , nonatomic) UIColor *currentPageIndicatorTintColor;
@property (copy , nonatomic) UIImage *placeholderImg;
//图片滚动间隔
@property (assign , nonatomic) CGFloat intervalTime;
@property (weak , nonatomic) NSTimer *timer;
- (void)stopAnimation;
@end
