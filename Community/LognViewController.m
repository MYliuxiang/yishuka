//
//  LognViewController.m
//  PaiMai
//
//  Created by 李善 on 16/2/22.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "LognViewController.h"
#import "RegistViewController.h"
#import "MainTabBarController.h"
#import "ChangepassViewController.h"
#import "CodeViewController.h"
@interface LognViewController ()<UITextFieldDelegate>
@end

@implementation LognViewController{

    UITextField *_phone;
    UITextField *_passWord;
    UIButton *_backButtton1;
    UILabel *titleLabel;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _InitView];
//    self.view.backgroundColor =
    self.text = @"登录";
    self.nav.backgroundColor = [UIColor colorWithRed:0.9922 green:0.6941 blue:0.1804 alpha:1];
//    self.navbarHiden = YES;
   
  
}




- (void)_InitView{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 500 / 2.0 * ratioWidth - 64)];
//    headerImageView.image = [UIImage imageNamed:@"bg"];
    headerImageView.backgroundColor = [UIColor colorWithRed:0.9922 green:0.6941 blue:0.1804 alpha:1];
    [_scrollView addSubview:headerImageView];
    titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 50, 100)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor=[UIColor whiteColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"登录";
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(kScreenWidth / 2.0, 42);
    [self.view addSubview:titleLabel];
    
//    _backButtton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    _backButtton1.frame = CGRectMake(5, 20, 40, 40);
//    [_backButtton1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [_backButtton1 setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    [self.view addSubview:_backButtton1];
    
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
    
    
    //密码图标
    UIImageView *querenImageView = [[UIImageView alloc]initWithFrame:CGRectMake(phoneImageView.left, lineView.bottom+30, 42/2.0, 42/2.0)];
    querenImageView.image = [UIImage imageNamed:@"登录注册－密码"];
//    querenImageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:querenImageView];
    
    //密码输入框
    _passWord = [[UITextField alloc]initWithFrame:CGRectMake(querenImageView.right+10,querenImageView.top, kScreenWidth-80, 20)];
    _passWord.placeholder = @"密码";
    _passWord.delegate = self;
    _passWord.font = [UIFont systemFontOfSize:16];
    [_passWord setSecureTextEntry:YES];
    [_scrollView  addSubview:_passWord];
    
    //下面的线条
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(30, querenImageView.bottom+4, kScreenWidth-60, 0.5)];
    lineView1.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1];
    [_scrollView addSubview:lineView1];
    
//    //登陆按钮
    UIButton *enter = [[UIButton alloc]initWithFrame:CGRectMake(30, lineView1.bottom+30, lineView1.width, 90 / 2.0)];
    enter.backgroundColor = [UIColor colorWithRed:0.9922 green:0.6941 blue:0.1804 alpha:1];
    [enter setTitle:@"登 录" forState:UIControlStateNormal];
     enter.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [enter addTarget:self action:@selector(EnterAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:enter];
//
//    UIButton *registbtn = [[UIButton alloc] initWithFrame:CGRectMake(enter.left, enter.bottom + 20 * ratioWidth, enter.width, 90/2.0)];
//    [registbtn setTitle:@"还没有账号,立即注册" forState:UIControlStateNormal];
//   
//    registbtn.layer.borderWidth = 0.5;
//    registbtn.layer.borderColor  = Color(95, 95, 95).CGColor; //要设置的颜色
//    registbtn.layer.cornerRadius = 3;
//    registbtn.layer.masksToBounds = YES;
//    registbtn.titleLabel.font = [UIFont systemFontOfSize:16 * ratioWidth ];
//    [registbtn setTitleColor:Color(95, 95, 95) forState:UIControlStateNormal];
//    [registbtn addTarget:self action:@selector(registbtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:registbtn];
    
   
    UIButton *wanji = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth  - 60)/2.0, enter.bottom + 20, 70 , 20 )];
    [wanji setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
//    wanji.layer.borderWidth = 0.5;
//    wanji.layer.borderColor  = Color(95, 95, 95).CGColor; //要设置的颜色
//    wanji.layer.cornerRadius = 3;
//    wanji.layer.masksToBounds = YES;
    wanji.titleLabel.textAlignment = NSTextAlignmentCenter;
    wanji.titleLabel.font = [UIFont systemFontOfSize:14 ];
    [wanji setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [wanji addTarget:self action:@selector(wanjibutton) forControlEvents:UIControlEventTouchUpInside];
//    右边按钮
    [_scrollView addSubview:wanji];
    
    _scrollView.contentSize = CGSizeMake(0, wanji.bottom + 50);
    _scrollView.bounces = NO;
    

//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [_scrollView addGestureRecognizer:tap1];
}

//- (void)tap
//{
//    [self.view endEditing:YES];
//    [UIView animateWithDuration:.35 animations:^{
//        CGPoint Y = CGPointMake(0, 0);
//        _scrollView.contentOffset = Y;
//        
//    }];
//    
//}

//注册
- (void)registbtnAction{

    
    RegistViewController *regist = [[RegistViewController alloc]init];
    [self presentViewController:regist animated:YES completion:nil];
    
}

//忘记密码
- (void)wanjibutton{
    ChangepassViewController *forget = [[ChangepassViewController alloc]init];
//    forget.i = 1;
    [self presentViewController:forget animated:YES completion:nil];

}

//登录
- (void)EnterAction{

    if (![InputCheck isPhone:_phone.text]) {
        [MBProgressHUD showError:@"请输入正确手机号" toView:self.view];
        return;
    }
    if (_passWord.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        return;
    }
    
    
    [WXDataService requestAFWithURL:URL_login params:@{@"mobile":_phone.text,@"password":_passWord.text} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
         NSLog(@"result:%@",result);
        
        if ([result[@"status"] intValue] == 0) {
            NSDictionary *info =result[@"result"][@"info"];
            [UserDefaults setBool:YES forKey:ISLogin];
            [UserDefaults setObject:info[@"id"] forKey:Userid];
            [UserDefaults setObject:info[@"username"] forKey:Username];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"idcard"]]  forKey:idcard];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"mobile"]] forKey:Mobile];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"group"]] forKey:Group];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"headimgurl"]] forKey:Headimgurl];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"name"]] forKey:Name_sure];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"birthday"]]forKey:birthday];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"address"]]  forKey:Address];
            [UserDefaults setObject:[NSString stringWithFormat:@"%@",info[@"description"]] forKey:Description];
            [UserDefaults synchronize];
            
            [JPUSHService setTags:nil alias:info[@"id"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
                NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
            }];

            
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
           
            [[NSNotificationCenter defaultCenter] postNotificationName:KVIEWVCCHANGE object:nil];

            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
        }else{
        
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}

//返回按钮
- (void)back
{
    
   [self dismissViewControllerAnimated:YES completion:nil];
        
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
