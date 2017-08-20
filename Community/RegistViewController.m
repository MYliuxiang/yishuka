//
//  RegistViewController.m
//  PaiMai
//
//  Created by 李善 on 16/2/23.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "RegistViewController.h"
@interface RegistViewController ()<UITextFieldDelegate>
@property(nonatomic,copy)NSString *Yanzhengma;
@property(nonatomic,strong)UIButton *backButtton1;
@end

@implementation RegistViewController{

    UITextField *_phone;
    UITextField *_yanzhengma;
    UITextField *_passWord;
    UITextField *_Newword;
    UILabel *_labauthcode;
    UIButton *_backButtton1;
    UILabel *titleLabel;
    UIImageView *_touchimage;
    UIImageView *_jinghaoimage;
    UILabel *_lable1;
    UILabel *_xieyilabel;
    BOOL _isxieyi;
    UITextField *_haoma;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _InitViews];
    self.automaticallyAdjustsScrollViewInsets = NO;
 self.nav.backgroundColor = [UIColor colorWithRed:0.9922 green:0.6941 blue:0.1804 alpha:1];
    self.text = @"注册";
    self.navbarHiden = NO;

    
}


- (void)_InitViews{

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];

//    _scrollView.contentOffset = CGPointMake(0, kScreenHeight);
//    _scrollView.backgroundColor = [UIColor colorWithRed:0.9922 green:0.6941 blue:0.1804 alpha:1];
//    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 196 * ratioWidth)];
    //    headerImageView.image = [UIImage imageNamed:@"bg"];
    headerImageView.backgroundColor = [UIColor colorWithRed:0.9922 green:0.6941 blue:0.1804 alpha:1];
    [_scrollView addSubview:headerImageView];
    titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 50, 100)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor=[UIColor whiteColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"注册";
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(kScreenWidth / 2.0, 42);
    [self.view addSubview:titleLabel];
    
    _backButtton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButtton1.frame = CGRectMake(15, 26, 18, 34);
    [_backButtton1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_backButtton1 setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:_backButtton1];
    
    UIImageView *logoimageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 180) / 2.0 , 4, 180, 160)];
    logoimageView.image = [UIImage imageNamed:@"logo"];
    logoimageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:logoimageView];
    

    
    
    
    //用户名
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, headerImageView.bottom+20, 42/2.0, 42/2.0)];
//    phoneImageView.backgroundColor = [UIColor redColor];
    phoneImageView.image = [UIImage imageNamed:@"登录注册－姓名"];
    [_scrollView addSubview:phoneImageView];
    
    _phone = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView.right+5, phoneImageView.top, kScreenWidth-80 , 20)];
    _phone.placeholder = @"真实姓名    家长注册请填写宝宝姓名";
    _phone.delegate = self;
    _phone.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:_phone];
   
    //下面的线条
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView.bottom+4, kScreenWidth-60, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView];
   
    
    //设置密码
    UIImageView *phoneImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, lineView.bottom+20, 42/2.0, 42/2.0)];
//    phoneImageView1.backgroundColor = [UIColor redColor];
    phoneImageView1.image = [UIImage imageNamed:@"登录注册－密码"];
    [_scrollView addSubview:phoneImageView1];
    
    _yanzhengma = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView.right+10, phoneImageView1.top, kScreenWidth-80, 20)];
    _yanzhengma.placeholder = @"设置密码";
    _yanzhengma.delegate = self;
    [_yanzhengma setSecureTextEntry:YES];

//    _yanzhengma.keyboardType = UIKeyboardTypePhonePad;
    [_yanzhengma setSecureTextEntry:YES];
    _yanzhengma.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:_yanzhengma];
    
    
    //下面的线条
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView1.bottom+4, kScreenWidth-60, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView1];

    
    //手机号
    UIImageView *phoneImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(30, lineView1.bottom+20, 42/2.0, 42/2.0)];
//    phoneImageView2.backgroundColor = [UIColor redColor];
    phoneImageView2.image = [UIImage imageNamed:@"登录注册－手机"];
    [_scrollView addSubview:phoneImageView2];
    
    //手机号
    _passWord = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView2.right+10,phoneImageView2.top , kScreenWidth-80, 20)];
    _passWord.placeholder = @"手机号";
    _passWord.delegate = self;
    _passWord.font = [UIFont systemFontOfSize:12];
    _passWord.keyboardType = UIKeyboardTypeNumberPad;
//    [_passWord setSecureTextEntry:YES];
    [_scrollView addSubview:_passWord];

    //下面的线条
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView2.bottom+4, kScreenWidth-60, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView2];
    
    
    //身份证
    UIImageView *phoneImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,lineView2.bottom+20, 42/2.0, 42/2.0)];
//    phoneImageView3.backgroundColor = [UIColor redColor];
    phoneImageView3.image = [UIImage imageNamed:@"登录注册－身份证"];
    [_scrollView addSubview:phoneImageView3];
    
    //身份证号码
    _Newword = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView3.right+5, phoneImageView3.top, kScreenWidth-80, 20)];
    _Newword.placeholder = @"身份证  家长注册请填写宝宝身份证";
    _Newword.delegate = self;
    _Newword.font = [UIFont systemFontOfSize:12];
//    [_Newword setSecureTextEntry:YES];
    [_scrollView addSubview:_Newword];
    
    //下面的线条
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView3.bottom+4, kScreenWidth-60, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView3];

    
//    _touchimage = [[UIImageView alloc]initWithFrame:CGRectMake(pohenbjview.left, pohenbjview3.bottom + 15, 15, 15)];
//    _touchimage.backgroundColor = [UIColor redColor];
//    _touchimage.userInteractionEnabled = YES;
//    [self.view addSubview:_touchimage];
//    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAction)];
//    [_touchimage addGestureRecognizer:tap1];
//    
//    _jinghaoimage = [[UIImageView alloc]initWithFrame:CGRectMake(_touchimage.right + 3, _touchimage.top, 15, 15)];
//    _jinghaoimage.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_jinghaoimage];
//    
//    _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(_jinghaoimage.right + 3, _jinghaoimage.top, 75, 15)];
//    _lable1.textColor = Color_text;
//    _lable1.text = @"已阅读并同意";
//    _lable1.textAlignment = NSTextAlignmentLeft;
//    _lable1.font = [UIFont systemFontOfSize:12.0];
//    [self.view addSubview:_lable1];
//    
//    
//    _xieyilabel = [[UILabel alloc]initWithFrame:CGRectMake(_lable1.right, _lable1.top, 150, 15)];
//    _xieyilabel.textColor = Color_red;
//    _xieyilabel.text = @"《未来社区软件服务协议》";
//    _xieyilabel.textAlignment = NSTextAlignmentLeft;
//    _xieyilabel.font = [UIFont systemFontOfSize:12.0];
//    _xieyilabel.userInteractionEnabled = YES;
//    [self.view addSubview:_xieyilabel];
//    
//    UITapGestureRecognizer *tapxieyi = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xieyiAction)];
//    [_xieyilabel addGestureRecognizer:tapxieyi];
    //身份证
    UIImageView *phoneImageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(30,lineView3.bottom+20, 42/2.0, 42/2.0)];
//    phoneImageView4.backgroundColor = [UIColor redColor];
        phoneImageView4.image = [UIImage imageNamed:@"登录注册－验证码"];
    [_scrollView addSubview:phoneImageView4];
    
    //验证码
    _haoma = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageView4.right+5, phoneImageView4.top, kScreenWidth-190, 20)];
    _haoma.placeholder = @"输入验证码";
    _haoma.delegate = self;
    _haoma.keyboardType = UIKeyboardTypePhonePad;
    _haoma.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:_haoma];
    
    //下面的线条
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(30, phoneImageView4.bottom+4, kScreenWidth-60, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView4];

    
    //验证码按钮
    _labauthcode = [[UILabel alloc]initWithFrame:CGRectMake(_haoma.right, _haoma.top-9.5,110,25)];
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
    [enter addTarget:self action:@selector(ReEnterAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:enter];
    
    
    UIButton *registbtn = [[UIButton alloc] initWithFrame:CGRectMake(enter.left, enter.bottom + 20 * ratioWidth, enter.width, 90/2.0)];
    [registbtn setTitle:@"上一步" forState:UIControlStateNormal];
    
    registbtn.layer.borderWidth = 0.5;
    registbtn.layer.borderColor  = Color(95, 95, 95).CGColor; //要设置的颜色
    registbtn.layer.cornerRadius = 3;
    registbtn.layer.masksToBounds = YES;
    registbtn.titleLabel.font = [UIFont systemFontOfSize:15  ];
    [registbtn setTitleColor:Color(95, 95, 95) forState:UIControlStateNormal];
    [registbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:registbtn];
    
    _scrollView.contentSize = CGSizeMake(0, registbtn.bottom + 50);
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
//    }];
//
//}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];

}



- (void)ReEnterAction{
    
    //隐藏键盘
    [self hideKeyboard];

    if (![InputCheck isPhone:_passWord.text]) {
        [MBProgressHUD showError:@"请输入正确手机号" toView:self.view];
        return;
    }

    if (_yanzhengma.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        return;
    }
    if (_Newword.text.length == 0) {
        [MBProgressHUD showError:@"请输入身份证" toView:self.view];
        return;
    }
    
    
    if (_haoma.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码" toView:self.view];
        return;
    }
      
    [WXDataService requestAFWithURL:Url_reg params:@{@"name":_phone.text,@"password":_yanzhengma.text,@"mobile":_passWord.text,@"idcard":_Newword.text,@"code":_haoma.text} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        NSLog(@"result:%@",result);
        if ([result[@"resultCode"] intValue] == 0) {
            
            [MBProgressHUD showSuccess:result[@"msg"] toView:self.view];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];

}

//验证的点击事件
- (void)YanzhengAction{
    
    //隐藏键盘
    [self hideKeyboard];
    
    if (![InputCheck isPhone:_passWord.text]) {
        [MBProgressHUD showError:@"请输入正确手机号" toView:self.view];
        return;
    }

    [WXDataService requestAFWithURL:URL_getRegCode params:@{@"mobile":_passWord.text} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        NSLog(@"result:%@",result);
        if ([result[@"resultCode"] intValue] == 0) {
         
            [MBProgressHUD showSuccess:result[@"msg"] toView:self.view];
            
            _labauthcode.userInteractionEnabled = NO;
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeat:) userInfo:nil repeats:YES];

        } else {

            [MBProgressHUD showError:result[@"msg"] toView:self.view];
        }
        
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)repeat:(NSTimer*)timer
{

    static int i = 1;
    int max = 120;
    if ((i%max)<max&&(i%max)!=0) {
        
        _labauthcode.backgroundColor = Color(172, 172, 172);
        _labauthcode.text = [NSString stringWithFormat:@"%.2d秒后再次获取",(max-i%max)];
        i++;
    }
    else
    {
        [timer invalidate];
        i++;
        _labauthcode.userInteractionEnabled = YES;
        
        _labauthcode.backgroundColor = Color_red;
        _labauthcode.text = @"获取验证码";
    }
    
    //    [authfield becomeFirstResponder];
}






#pragma  mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phone) {
        int Max_chars = 11;
        NSMutableString *newtext = [NSMutableString stringWithString:textField.text];
        [newtext replaceCharactersInRange:range withString:string];
        
        return ([newtext length]<=Max_chars);
    }
    
    return YES;
}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    
//    [self.view endEditing:YES];
//    [UIView animateWithDuration:.35 animations:^{
//        CGPoint Y = CGPointMake(0, 0);
//        _scrollView.contentOffset = Y;
//    }];
//
//    
//    return YES;
//    
//}

#pragma mark 隐藏键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard];
   
}

-(void)hideKeyboard{
    if (![_phone isExclusiveTouch]) {
        [_phone resignFirstResponder];
    }
    if (![_yanzhengma isExclusiveTouch]) {
        [_yanzhengma resignFirstResponder];
    }
    if (![_passWord isExclusiveTouch]) {
        [_passWord resignFirstResponder];
    }
    if (![_Newword isExclusiveTouch]) {
        [_Newword resignFirstResponder];
    }
    
}


//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    
//    
//    pointindex = _scrollView.contentOffset;
//    if (textField ==_phone ) {
//        [UIView animateWithDuration:.35 animations:^{
//            CGPoint Y = CGPointMake(0, 120);
//            _scrollView.contentOffset = Y;
//        }];
//    }
//    
//    if (textField == _yanzhengma) {
//        [UIView animateWithDuration:.35 animations:^{
//            CGPoint Y = CGPointMake(0, 140);
//            _scrollView.contentOffset = Y;
//        }];
//    }
//    
//    if (textField == _passWord) {
//        [UIView animateWithDuration:.35 animations:^{
//            CGPoint Y = CGPointMake(0, 160);
//            _scrollView.contentOffset = Y;
//        }];
//    }
//    
//    if (textField == _Newword) {
//        [UIView animateWithDuration:.35 animations:^{
//            CGPoint Y = CGPointMake(0, 260);
//            _scrollView.contentOffset = Y;
//        }];
//    }
//    if (textField == _haoma) {
//        [UIView animateWithDuration:.35 animations:^{
//            CGPoint Y = CGPointMake(0, 280);
//            _scrollView.contentOffset = Y;
//        }];
//    }
//
//    
//    
//    return YES;
//}







@end
