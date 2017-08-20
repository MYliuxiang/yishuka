//
//  ContactViewController.m
//  PaiMai
//
//  Created by 李立 on 16/5/7.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "ContactViewController.h"
#import "ClasslistViewController.h"
@implementation ContactViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.text = @"意见反馈";
    self.ISFANHUI = YES;

    [self _initView];

}

//初始化视图
-(void)_initView
{
    
    UIView *bjView = [[UIView alloc]initWithFrame:CGRectMake(5, 64, kScreenWidth-10, 250)];
    bjView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bjView];
    //输入框
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 20, bjView.width, bjView.height - 20)];
    _textView.font = [UIFont systemFontOfSize:13 * ratioHeight];
    _textView.delegate = self;
    _textView.scrollEnabled = YES;//是否可以拖动
    _textView.showsHorizontalScrollIndicator = NO;
    _textView.shouldGroupAccessibilityChildren = NO;
    _textView.returnKeyType = UIReturnKeyDone;
     [bjView addSubview:_textView];
    
    //默认输入Label
    _lael1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
    _lael1.text = @"填写您的建议";
    _lael1.textColor = [UIColor grayColor];
    _lael1.font = [UIFont systemFontOfSize:13 * ratioHeight];
    [_textView addSubview:_lael1];
    
    //线条
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, bjView.bottom, kScreenWidth, 1)];
    lineView.backgroundColor = Color_bg;
    [self.view addSubview:lineView];
    
    //提交按钮
    UIButton *lingquButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lingquButton.frame =CGRectMake((kScreenWidth-200)/2.0,bjView.bottom+40, 200, 40);
    [lingquButton setTitle:@"提交" forState:UIControlStateNormal];
    lingquButton.titleLabel.font = [UIFont boldSystemFontOfSize:13 * ratioWidth];
    lingquButton.backgroundColor = Color_nav;
    lingquButton.tag = 11;
    [lingquButton addTarget:self action:@selector(lingquButton:) forControlEvents:UIControlEventTouchUpInside];
    lingquButton.layer.cornerRadius = 5;
    // 按钮边框宽度
    lingquButton.layer.masksToBounds = YES;
    [self.view addSubview:lingquButton];
    
    
    
    


}

//提交按钮点击事件
-(void)lingquButton:(UIButton *)button
{
    
//    ClasslistViewController *classlistVC = [[ClasslistViewController alloc]init];
//    [self.navigationController pushViewController:classlistVC animated:YES];
    
    if (_textView.text.length == 0) {
        [MBProgressHUD showError:@"填写您的建议" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (_textView.text.length >=  200) {
        [MBProgressHUD showError:@"字数过多" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    NSLog(@"提交----%@",_textView.text);
    
        
    [WXDataService requestAFWithURL:Url_feedbackSub params:@{@"member_id":[UserDefaults objectForKey:Userid],@"description":_textView.text} httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {

        
        [self hiddnkeyAction];
        //请求成功
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

//隐藏键盘
- (void)hiddnkeyAction
{
    [self keyfile];
    
}

- (void)keyfile
{
    if (![_textView isExclusiveTouch]) {
        [_textView resignFirstResponder];
    }
    
    
}

//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    _lael1.hidden = YES;
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"]) {
        [self hiddnkeyAction];
        return NO;
    }
    return YES;
}

@end
