//
//  LJArewardView.m
//  Community
//
//  Created by 李立 on 16/4/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LJArewardView.h"

@implementation LJArewardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addArewardView];
    }
    return self;
}

- (void)addArewardView
{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = .9;
    [self addSubview:bgView];

    UIView *witerView = [[UIView alloc]initWithFrame:CGRectMake(15, (kScreenHeight - 142 / 2.0) / 2.0, kScreenWidth - 30, 142 / 2.0)];
    witerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:witerView];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(15,(witerView.height - 40) / 2.0 , witerView.width - 130, 40)];
    _textField.placeholder = @"请输入数值";
    _textField.layer.borderWidth = .5;
    _textField.layer.borderColor = Color_bg.CGColor;
    [witerView addSubview:_textField];
   
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(_textField.width - 50,0, 50, _textField.height)];
    lable.text = @"咖币";
    lable.font = [UIFont systemFontOfSize:16];
    [_textField addSubview:lable];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(_textField.right + 5, _textField.top, witerView.width - _textField.right - 5 - 15, _textField.height)];
    button.backgroundColor = Color_nav;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dasangAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    [witerView addSubview:button];

}

- (void)dasangAction
{
    
    if (_textField.text.length == 0) {
        
    }
    [self.delegate giveKabiStr:_textField.text];
    [self removeFromSuperview];

}
@end
