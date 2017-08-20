//
//  ProfessionalchoiceViewController.m
//  Community
//
//  Created by 李立 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ProfessionalchoiceViewController.h"
//#import "RoleViewController.h"
@interface ProfessionalchoiceViewController ()
{
    BOOL isok;
    UILabel *lingyuxieLabel;
    UILabel *zhixixieLabel;
    UIView *_view1;
    UILabel *kemuLabelxieLabel;
    int _a;
    int _b;
    int _c;
    int _d;
}
@end

@implementation ProfessionalchoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.text = @"专业选择";
    [self initView];
    _a = 0;
    _b = 0;
    _c = 0;
    _d = 0;
}

//初始化视图
-(void)initView
{
    
    //领域
    UILabel *lingyuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 84, 40, 20)];
    lingyuLabel.textColor = [UIColor blackColor];
    lingyuLabel.text = @"领域";
    lingyuLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:lingyuLabel];
    
    
    //选择领域
    lingyuxieLabel = [[UILabel alloc]initWithFrame:CGRectMake(lingyuLabel.right+20, 84, 100, 20)];
    lingyuxieLabel.textColor = [UIColor grayColor];
    lingyuxieLabel.font = [UIFont systemFontOfSize:14];
    lingyuxieLabel.text = @"请选择领域";
    [self.view addSubview:lingyuxieLabel];
    
    //线条
    UIView *linew = [[UIView alloc]initWithFrame:CGRectMake(0, lingyuLabel.bottom+15, kScreenWidth, 1)];
    linew.backgroundColor = [UIColor colorWithRed:0.7373 green:0.7373 blue:0.7373 alpha:1];
    [self.view addSubview:linew];
    
    //下拉按钮
    UIButton *xialaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xialaButton.frame = CGRectMake(kScreenWidth-50, linew.top-30, 15, 15);
    xialaButton.backgroundColor = Color_nav;
    [xialaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xialaButton addTarget:self action:@selector(xialaButton:) forControlEvents:UIControlEventTouchUpInside];
    xialaButton.tag = 100;
    [self.view addSubview:xialaButton];
    
    
    //直系
    UILabel *zhixiLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, linew.bottom+20, 40, 20)];
    zhixiLabel.textColor = [UIColor blackColor];
    zhixiLabel.text = @"直系";
    zhixiLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:zhixiLabel];
    
    
    //选择领域
    zhixixieLabel = [[UILabel alloc]initWithFrame:CGRectMake(zhixiLabel.right+20, linew.bottom+20, 100, 20)];
    zhixixieLabel.textColor = [UIColor grayColor];
    zhixixieLabel.font = [UIFont systemFontOfSize:14];
    zhixixieLabel.text = @"请选择直系";
    [self.view addSubview:zhixixieLabel];
    
    //线条
    UIView *linew1 = [[UIView alloc]initWithFrame:CGRectMake(0, zhixiLabel.bottom+15, kScreenWidth, 1)];
    linew1.backgroundColor = [UIColor colorWithRed:0.7373 green:0.7373 blue:0.7373 alpha:1];
    [self.view addSubview:linew1];
    
    //下拉按钮
    UIButton *xialaButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    xialaButton1.frame = CGRectMake(kScreenWidth-50, linew1.top-30, 15, 15);
    xialaButton1.backgroundColor = Color_nav;
    xialaButton1.tag = 101;
    [xialaButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xialaButton1 addTarget:self action:@selector(xialaButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xialaButton1];
    
    
    //科目
    UILabel *kemuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, linew1.bottom+20, 40, 20)];
    kemuLabel.textColor = [UIColor blackColor];
    kemuLabel.text = @"科目";
    kemuLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:kemuLabel];
    
    
    //选择领域
    kemuLabelxieLabel = [[UILabel alloc]initWithFrame:CGRectMake(kemuLabel.right+20, linew1.bottom+20, 100, 20)];
    kemuLabelxieLabel.textColor = [UIColor grayColor];
    kemuLabelxieLabel.font = [UIFont systemFontOfSize:14];
    kemuLabelxieLabel.text = @"钢琴";
    [self.view addSubview:kemuLabelxieLabel];
    
    //线条
    UIView *linew2 = [[UIView alloc]initWithFrame:CGRectMake(0, kemuLabelxieLabel.bottom+15, kScreenWidth, 1)];
    linew2.backgroundColor = [UIColor colorWithRed:0.7373 green:0.7373 blue:0.7373 alpha:1];
    [self.view addSubview:linew2];
    
    
    //下拉按钮
    UIButton *xialaButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    xialaButton2.frame = CGRectMake(kScreenWidth-50, linew2.top-30, 15, 15);
    xialaButton2.backgroundColor = Color_nav;
    [xialaButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xialaButton2 addTarget:self action:@selector(xialaButton:) forControlEvents:UIControlEventTouchUpInside];
    xialaButton2.tag = 102;
    [self.view addSubview:xialaButton2];
    
    
    //提交按钮
    UIButton *tijiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaoButton.frame = CGRectMake(30, linew2.bottom+30, kScreenWidth-60, 45);
    tijiaoButton.backgroundColor = Color_nav;
    [tijiaoButton setTitle:@"提交" forState:UIControlStateNormal];
    [tijiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tijiaoButton addTarget:self action:@selector(tijiaoButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiaoButton];
    
    
    //上一步按钮
    UIButton *registbtn = [[UIButton alloc] initWithFrame:CGRectMake(tijiaoButton.left, tijiaoButton.bottom + 20 * ratioWidth, tijiaoButton.width, 90/2.0)];
    [registbtn setTitle:@"上一步" forState:UIControlStateNormal];
    
    registbtn.layer.borderWidth = 0.5;
    registbtn.layer.borderColor  = Color(95, 95, 95).CGColor; //要设置的颜色
    registbtn.layer.cornerRadius = 3;
    registbtn.layer.masksToBounds = YES;
    registbtn.titleLabel.font = [UIFont systemFontOfSize:15  ];
    [registbtn setTitleColor:Color(95, 95, 95) forState:UIControlStateNormal];
    [registbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registbtn];
    
    
    //图片
    UIImageView *tupianImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2.0-50, registbtn.bottom+30, 100, 100)];
    tupianImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tupianImageView];
    
    //文字介绍
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(registbtn.left, tupianImageView.bottom+10, kScreenWidth-60, 40)];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = @"我们的肯德基看风景方的咖啡机快速的减肥的打开房间电视看风景的看法觉得舒服但是看风景看大煞风景的方电商开放加快速度的空间发呆看到附近的看法看到九分裤地方快点放假快点放假 看到附近";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreenWidth-40, 9999);
    CGSize expectSize = [titleLabel sizeThatFits:maximumLabelSize];
    titleLabel.frame = CGRectMake(registbtn.left, tupianImageView.bottom+10, expectSize.width, expectSize.height);

    [self.view addSubview:titleLabel];
    
    
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200)];
    _view1.backgroundColor = [UIColor grayColor];
    
    //选择框
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 162)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
//    [self.pickerView selectRow:0 inComponent:0 animated:NO];

    [_view1 addSubview:self.pickerView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-60, 40, 50, 20);
//    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:button];
    [self.view addSubview:_view1];
}


//提交按钮
-(void)tijiaoButton
{
    NSLog(@"提交");
//    RoleViewController *roleVC = [[RoleViewController alloc]init];
//    [self.navigationController pushViewController:roleVC animated:YES];
//
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//第一个选这按钮
-(void)xialaButton:(UIButton *)button
{
    if (button.tag ==100) {
        NSLog(@"1");
        _a = 1;
        if (_b== 0 ) {
            _nameArray = [NSArray arrayWithObjects:@"北京",@"上海",@"广州",@"深圳",@"重庆",@"武汉",@"天津",nil];
            [self _initPPIC];
            lingyuxieLabel.text = _nameArray[0];

            _b = 1;
        }else{
            
            
            [UIView animateWithDuration:.35 animations:^{
                _view1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 162);
                
            }];
            _b = 0;
        }
       
    
        
    }
    if (button.tag ==101) {
        NSLog(@"2");
        _a = 2;
        if (_c== 0 ) {
//            _a = 2;
            _nameArray = [NSArray arrayWithObjects:@"北京1",@"上海1",@"广州1",@"深圳1",@"重庆1",@"武汉1",@"天津1",nil];
            
            [self _initPPIC];
            zhixixieLabel.text = _nameArray[0];

            _c = 1;
        }else{
            
            
            [UIView animateWithDuration:.35 animations:^{
                _view1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 162);
                
            }];
            _c = 0;
        }

    }
    if (button.tag == 102) {
        NSLog(@"3");
        _a = 3;
        if (_d== 0 ) {
            _nameArray = [NSArray arrayWithObjects:@"北京2",@"上海2",@"广州2",@"深圳2",@"重庆2",@"武汉2",@"天津2",nil];
            
            [self _initPPIC];
            kemuLabelxieLabel.text = _nameArray[0];

            _d = 1;
        }else{
            
            
            [UIView animateWithDuration:.35 animations:^{
                _view1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 162);
                
            }];
            _d = 0;
        }
        

    }
    
}

-(void)_initPPIC
{
    [self.pickerView reloadAllComponents];

    [UIView animateWithDuration:.35 animations:^{
        _view1.frame = CGRectMake(0, kScreenHeight-162, kScreenWidth, 162);
        
    }];
    
}

#pragma mark-PICK代理
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_nameArray count];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 100;
}
//每个item显示的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return _nameArray[row];
    
}


//监听选择单元格
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (_a == 1) {

     lingyuxieLabel.text = _nameArray[row];
    }
    if (_a == 2) {

        zhixixieLabel.text = _nameArray[row];
        
    }if (_a == 3) {

        kemuLabelxieLabel.text = _nameArray[row];
        
    }
    
    
   }

//完成按钮点击事件
-(void)buttonAction
{
    NSLog(@"完成");
    [UIView animateWithDuration:.35 animations:^{
        _view1.frame = CGRectMake(0, kScreenHeight+100, kScreenWidth, 0);
        
    }];
    
    
}


@end
