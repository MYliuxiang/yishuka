//
//  CodeViewController.m
//  Community
//
//  Created by 李江 on 16/3/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "CodeViewController.h"
#import "RegistViewController.h"
@interface CodeViewController ()<UITextFieldDelegate>
{
    UITextField *_phone;
    UIImageView *_touchimage;
    UIImageView *_jinghaoimage;
    UILabel *_lable1;
    UILabel *_xieyilabel;
    BOOL _isxieyi;
}
@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"注册";
    self.navbarHiden = NO;
    _isxieyi = NO;
    
    [self _initView];
    
}

- (void)_initView
{
    
    UILabel *phonelable = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 30, 25)];
    phonelable.text = @"+86";
    phonelable.textColor = [UIColor blackColor];
    phonelable.font = [UIFont systemFontOfSize:14];
    phonelable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phonelable];
    
    _phone = [[UITextField alloc]initWithFrame:CGRectMake(phonelable.right+5, phonelable.top    , kScreenWidth-phonelable.right - 5 - 20, 25)];
    _phone.placeholder = @"请输入您的手机号";
    _phone.delegate = self;
    _phone.keyboardType = UIKeyboardTypePhonePad;
    _phone.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_phone];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(phonelable.left, phonelable.bottom + + 5, kScreenWidth - 40, .5)];
    lineView.backgroundColor = Color_text;
    [self.view addSubview:lineView];
    
    
    
    _touchimage = [[UIImageView alloc]initWithFrame:CGRectMake(phonelable.left, lineView.bottom + 15, 15, 15)];
    _touchimage.backgroundColor = [UIColor redColor];
    _touchimage.userInteractionEnabled = YES;
    [self.view addSubview:_touchimage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAction)];
    [_touchimage addGestureRecognizer:tap];
    
    _jinghaoimage = [[UIImageView alloc]initWithFrame:CGRectMake(_touchimage.right + 3, _touchimage.top, 15, 15)];
    _jinghaoimage.backgroundColor = [UIColor redColor];
    [self.view addSubview:_jinghaoimage];
    
    _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(_jinghaoimage.right + 3, _jinghaoimage.top, 75, 15)];
    _lable1.textColor = Color_text;
    _lable1.text = @"已阅读并同意";
    _lable1.textAlignment = NSTextAlignmentLeft;
    _lable1.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_lable1];
    
    
    _xieyilabel = [[UILabel alloc]initWithFrame:CGRectMake(_lable1.right, _lable1.top, 150, 15)];
    _xieyilabel.textColor = Color_red;
    _xieyilabel.text = @"《未来社区软件服务协议》";
    _xieyilabel.textAlignment = NSTextAlignmentLeft;
    _xieyilabel.font = [UIFont systemFontOfSize:12.0];
    _xieyilabel.userInteractionEnabled = YES;
    [self.view addSubview:_xieyilabel];
    
    UITapGestureRecognizer *tapxieyi = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xieyiAction)];
    [_xieyilabel addGestureRecognizer:tapxieyi];
    
    //登陆按钮
    UIButton *enter = [[UIButton alloc]initWithFrame:CGRectMake(20, _touchimage.bottom + 30, kScreenWidth - 40, 40)];
    enter.backgroundColor = Color_red;
    enter.layer.cornerRadius = 3;
    enter.layer.masksToBounds = YES;
    [enter setTitle:@"获取验证码" forState:UIControlStateNormal];
    enter.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [enter addTarget:self action:@selector(EnterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enter];


}

//获取验证码
- (void)EnterAction
{
    
   
    
//    [WXDataService requestAFWithURL:Url_GetCode params:@{@"username":_phone.text} httpMethod:@"GET" isHUD:NO finishBlock:^(id result) {
//        NSLog(@"result:%@",result);
//        if ([result[@"resultCode"] intValue] == 1) {
//
    RegistViewController *regist = [[RegistViewController alloc]init];
    regist.phoneString = _phone.text;
    [self presentViewController:regist animated:YES completion:nil];
//            RegistViewController *regist = [[RegistViewController alloc]init];
//            [self presentViewController:regist animated:YES completion:nil];
//            
//        } else {
//            
//            [MBProgressHUD showError:result[@"msg"] toView:self.view];
//        }
//        
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
   
}

//协议
- (void)xieyiAction
{


}

//同意协议
- (void)touchAction
{
    if (_isxieyi == NO) {
        _jinghaoimage.hidden = YES;
        _lable1.left = _touchimage.right + 3;
        _xieyilabel.left = _lable1.right;
        _isxieyi = YES;
   
    } else {
        
        _jinghaoimage.hidden = NO;
        _jinghaoimage.left = _touchimage.right + 3;
        _lable1.left = _jinghaoimage.right + 3;
        _xieyilabel.left = _lable1.right;
        _isxieyi = NO;

    }
    
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
   
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    return YES;
    
}

#pragma mark 隐藏键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard];
}

-(void)hideKeyboard{
    if (![_phone isExclusiveTouch]) {
        [_phone resignFirstResponder];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
