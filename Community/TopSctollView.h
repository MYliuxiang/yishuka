//
//  TopSctollView.h
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopSctollView : UIScrollView<UIScrollViewDelegate>{
    
    NSArray *titleArray;
    NSInteger userSelectedButtonTag;
    NSInteger scrollViewSelectedID;
    UIImageView *shadowImage;
    
}

@property (nonatomic, retain) NSArray *titleArray;

@property (nonatomic, retain) NSMutableArray *buttonWithArray;

@property (nonatomic, retain) NSMutableArray *buttonOrignXArray;

@property (assign) NSInteger scrollViewSelectedID;

@property (assign) NSInteger userSelectedButtonTag;

@property (nonatomic,copy) void (^clickBlock)(int i);


+ (TopSctollView *)getInstance;
//加载顶部标题
- (void)initWithTitleButtons;

- (void)setButttonUnSelect;

- (void)setButtonSelect;

- (void)setScrollViewContentOffset;

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray*)titlearray;



@end
