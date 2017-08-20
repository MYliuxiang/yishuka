//
//  ChangepassViewController.m
//  PaiMai
//
//  Created by 李立 on 16/2/29.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "ChangepassViewController.h"
@interface ChangepassViewController ()
{
    
    
    UITextField *_phone;
    UITextField *_yanzhengma;
    UITextField *_Newword;
    UITextField *_oldword;
    UILabel *_labauthcode;
    
    
}

@end

@implementation ChangepassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.9373 green:0.9373 blue:0.9373 alpha:1];
    
    self.text = @"找回密码";
    self.navbarHiden = NO;
    [self _initViews];

}

//初始化视图
-(void)_initViews
{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 500 / 2.0 * ratioWidth - 64)];
    //    headerImageView.image = [UIImage imageNamed:@"bg"];
    headerImageView.backgroundColor = Color_nav;
    [_scrollView addSubview:headerImageView];
    
    _backButtton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButtton1.frame = CGRectMake(20, 26, 17, 17);
    [_backButtton1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_backButtton1 setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:_backButtton1];
    
    UIImageView *logoimageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 180) / 2.0, 4, 180, 160)];
    logoimageView.image = [UIImage imageNamed:@"logo"];
    logoimageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:logoimageView];
    
    
    
    
    //电话号码图标
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, headerImageView.bottom+30, 42/2.0, 42/2.0)];
        phoneImageView.image = [UIImage imageNamed:@"登录注册－手机"];
//    phoneImageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:phoneImageView];
    
    
    //电话号码输入框
    _phone = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView.right+10, phoneImageView.top, kScreenWidth-80, 20)];
    _phone.placeholder = @"手机号";
    _phone.delegate = self;
    _phone.keyboardType = UIKeyboardTypePhonePad;
    _phone.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:_phone];
    
    //下面的线条
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView.bottom+4, kScreenWidth-60, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView];
    
    
    //新密码
    //电话号码图标
    UIImageView *phoneImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, lineView.bottom+20, 42/2.0, 42/2.0)];
    phoneImageView1.image = [UIImage imageNamed:@"登录注册－手机"];
    //    phoneImageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:phoneImageView1];
    
    _Newword = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView1.right+10, phoneImageView1.top, kScreenWidth-80, 20)];
    _Newword.placeholder = @"新密码";
    _Newword.delegate = self;
    _Newword.keyboardType = UIKeyboardTypePhonePad;
    _Newword.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:_Newword];
    
    //下面的线条
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView1.bottom+4, kScreenWidth-60, 0.5)];
    lineView2.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView2];
    
    
    
    
    //旧密码
    //新密码
    //电话号码图标
    UIImageView *phoneImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(30, lineView2.bottom+20, 42/2.0, 42/2.0)];
    phoneImageView2.image = [UIImage imageNamed:@"登录注册－手机"];
    //    phoneImageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:phoneImageView2];
    
    //电话号码输入框
    _oldword = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView2.right+10, phoneImageView2.top, kScreenWidth-80, 20)];
    _oldword.placeholder = @"确认密码";
    _oldword.delegate = self;
    _oldword.keyboardType = UIKeyboardTypePhonePad;
    _oldword.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:_oldword];
    
    //下面的线条
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView2.bottom+4, kScreenWidth-60, 0.5)];
    lineView3.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView3];
    
   
    
    
    
    //手机号码
    UIImageView *phoneImageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(30,lineView3.bottom+20, 42/2.0, 42/2.0)];
//    phoneImageView4.backgroundColor = [UIColor redColor];
        phoneImageView4.image = [UIImage imageNamed:@"登录注册－验证码"];
    [_scrollView addSubview:phoneImageView4];

    //验证码
    _yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView4.right+10, phoneImageView4.top, kScreenWidth-190, 20)];
    _yanzhengma.placeholder = @"验证码";
    _yanzhengma.delegate = self;
    _yanzhengma.keyboardType = UIKeyboardTypePhonePad;
    _yanzhengma.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:_yanzhengma];
    
    //下面的线条
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView4.bottom+4, kScreenWidth-60, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView4];
    
    
    
    
    
    
    
    
    
    //验证码按钮
    _labauthcode = [[UILabel alloc]initWithFrame:CGRectMake(_yanzhengma.right, _yanzhengma.top-9.5,110,25)];
    //    _labauthcode.backgroundColor = Color(172, 172, 172);
    _labauthcode.backgroundColor = [UIColor colorWithRed:0.8471 green:0.8314 blue:0.8314 alpha:1];
    _labauthcode.text = @"获取验证码";
    _labauthcode.textColor = [UIColor whiteColor];
    _labauthcode.font = [UIFont boldSystemFontOfSize:13];
    _labauthcode.textAlignment = NSTextAlignmentCenter;
    _labauthcode.adjustsFontSizeToFitWidth = YES;
    _labauthcode.userInteractionEnabled = YES;
    _labauthcode.layer.cornerRadius = 12.5;
    _labauthcode.layer.masksToBounds = YES;
    [_scrollView addSubview:_labauthcode];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(YanzhengAction)];
    [_labauthcode addGestureRecognizer:tap];
    
    
    
    //    登陆按钮
    UIButton *enter = [[UIButton alloc]initWithFrame:CGRectMake(lineView4.left, lineView4.bottom + 30, lineView4.width, 45)];
    enter.backgroundColor = [UIColor colorWithRed:0.9922 green:0.6941 blue:0.1804 alpha:1];
    [enter setTitle:@"提交" forState:UIControlStateNormal];
    enter.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [enter addTarget:self action:@selector(ReEnterAction1) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:enter];
    
    _scrollView.contentSize = CGSizeMake(0, enter.bottom + 50);
    _scrollView.bounces = NO;
    
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [_scrollView addGestureRecognizer:tap1];




}
//- (void)tap
//{
//    [self.view endEditing:YES];
//    [UIView animateWithDuration:.35 animations:^{
//        
//        _scrollView.contentOffset = pointindex;
//        
//        CGPoint Y = CGPointMake(0, 0);
//        _scrollView.contentOffset = Y;
//    }];
//    
//}
//
- (void)repeat:(NSTimer*)timer
{
    
    static int i = 1;
    int max = 60;
    if ((i%max)<max&&(i%max)!=0) {
        
        _labauthcode.text = [NSString stringWithFormat:@"%.2d秒后再次获取",(max-i%max)];
        i++;
    }
    else
    {
        [timer invalidate];
        i++;
        _labauthcode.userInteractionEnabled = YES;
        
        
        _labauthcode.text = @"获取验证码";
    }
    
    //    [authfield becomeFirstResponder];
}


//隐藏键盘
-(void)ReEnterAction1{
     [self hideKeyboard];

      if (![InputCheck isPhone:_phone.text]) {
    [MBProgressHUD showError:@"请输入正确手机号" toView:self.view];
    return;
     }

    if (_yanzhengma.text.length == 0) {
     [MBProgressHUD showError:@"请输入验证码" toView:self.view];
        return;
     }
}

//隐藏键盘
-(void)hideKeyboard{
    if (![_phone isExclusiveTouch]) {
        [_phone resignFirstResponder];
    }
    if (![_yanzhengma isExclusiveTouch]) {
        [_yanzhengma resignFirstResponder];
    }
    
}


//验证的点击事件
- (void)YanzhengAction{
    
    //        | 参数名称 | 必选 | 类型 | 参数含义 |
    //        | -----   | --- |--- |----- |
    //        | mobile  | true | string | 手机号 |
    
    if (_phone.text.length ==0) {
        [MBProgressHUD showError:@"手机号码不能为空" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    
    if (_Newword.text.length ==0) {
        [MBProgressHUD showError:@"密码不能为空" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    
    if (![_Newword.text isEqualToString:_oldword.text]) {
        [MBProgressHUD showError:@"两次密码不一致" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    
    _labauthcode.userInteractionEnabled = NO;
    _labauthcode.text = @"60秒后重新发送";
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeat:) userInfo:nil repeats:YES];
  
//    mobile手机号
//    code验证码
//    password密码

    
    NSDictionary *params = @{@"mobile":_phone.text,
                             @"code":_yanzhengma.text,
                             @"password":_Newword.text,
                             };

    [WXDataService requestAFWithURL:URL_login params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        if ([result[@"status"]integerValue]==0) {
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }else{
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    pointindex = _scrollView.contentOffset;
//
//    if (textField ==_phone ) {
//        [UIView animateWithDuration:.35 animations:^{
//            CGPoint Y = CGPointMake(0, 160);
//            _scrollView.contentOffset = Y;
//        }];
//    }
//    
//    if (textField == _yanzhengma) {
//        [UIView animateWithDuration:.35 animations:^{
//            CGPoint Y = CGPointMake(0, 180);
//            _scrollView.contentOffset = Y;
//        }];
//    }
//
//    
//    return YES;
//    
//}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [UIView animateWithDuration:.35 animations:^{
//        [self.view setTop:0];
//    }];
//    [self.view endEditing:YES];
//    
//}

//返回按钮
- (void)back
{
   [self dismissViewControllerAnimated:YES completion:nil];

}



@end
