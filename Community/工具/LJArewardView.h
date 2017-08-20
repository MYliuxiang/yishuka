//
//  LJArewardView.h
//  Community
//
//  Created by 李立 on 16/4/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LJArewardViewDelegate <NSObject>

- (void)giveKabiStr:(NSString *)kabistr;

@end

@interface LJArewardView : UIView
{
    UIView *bgView;
    UITextField *_textField;

}

@property(nonatomic,weak)id<LJArewardViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addArewardView;

@end
