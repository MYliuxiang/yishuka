//
//  BaoMingVC.m
//  Community
//
//  Created by 刘翔 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaoMingVC.h"

@interface BaoMingVC ()

@end

@implementation BaoMingVC{

    UITextField *zhiwei;
    UITextField *textfield;
    UITextField *textfield1;
    UITextView *text;
    UILabel *label1; //应聘职位
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_isbaoming == YES) {
        self.text = @"报名";
    }
    if (_isbaoming == NO) {
        self.text = @"我要应聘";
    }
    
    [self _initFooter];
}

- (void)_initFooter
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 200) / 2.0, 40, 200, 35 * ratioHeight)];
    button1.layer.cornerRadius = 3;
    button1.layer.masksToBounds = YES;
    button1.backgroundColor = Color_nav;
    [button1 setTitle:@"提 交" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(tijiao:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
    _tableView.tableFooterView = view;
    
    
}

- (void)tijiao:(UIButton *)sender
{
    
//    member_id用户ID
//    agency_id机构ID
//    title应聘职位
//    name姓名
//    mobile手机
//    description备注
    
    if (textfield.text.length==0) {
        [MBProgressHUD showError:@"姓名不能为空" toView:self.view];
        return;
    }
    
    if (![InputCheck isPhone:textfield1.text]) {
        [MBProgressHUD showError:@"请输入正确手机号" toView:self.view];
        return;
    }
    
    if (textfield.text.length==0) {
        [MBProgressHUD showError:@"职位不能为空" toView:self.view];
        return;
    }
    
    if (textfield.text.length==0) {
        [MBProgressHUD showError:@"职位不能为空" toView:self.view];
        return;
    }
    
    if (text.text.length ==0) {
        [MBProgressHUD showError:@"备注不能为空" toView:self.view];
        return;
    }
    
    NSDictionary *params;
    NSString *urlSting;
    if (_isbaoming == YES) {
        urlSting =  URL_ClassSignSub;
        params = @{@"member_id":[UserDefaults objectForKey:Userid],
                   @"class_id":self.BMid,
                   @"title":textfield.text,
                   @"name":textfield.text,
                   @"mobile":textfield1.text,
                   @"description":text.text};
        
    } else {
    
        urlSting =  URL_agencyApplySub;
        params = @{@"member_id":[UserDefaults objectForKey:Userid],
                                 @"agency_id":self.BMid,
                                 @"title":textfield.text,
                                 @"name":textfield.text,
                                 @"mobile":textfield1.text,
                                 @"description":text.text};
    }

    
    
    [WXDataService requestAFWithURL:urlSting params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
         if ([result[@"status"] integerValue]==0) {
             [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
             [self.navigationController popViewControllerAnimated:YES];
         }else{
             [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
         }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    

}



#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        
        
        for (int i = 0; i < 3; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 60 + 59, kScreenWidth, .5)];
            imageView.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:imageView];
        }
        
        NSArray *titles;
        if (_isbaoming == YES) {
            titles = @[@"班级名称",@"姓       名",@"手       机",@"备       注"];
        }
        if (_isbaoming == NO) {
        
             titles = @[@"应聘职位",@"姓       名",@"手       机",@"备       注"];
        }
        
       
        for (int i = 0; i < 4; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, i*60, 60, 60)];
            label.text = titles[i];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
        }
        
        
        zhiwei = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth - 90, 60)];
        if (_isbaoming == YES) {
            zhiwei.text = _titleString;
        }
        if (_isbaoming == NO) {
            
            zhiwei.placeholder = @"音乐 器乐 钢琴";
        }
        
        zhiwei.textColor = [UIColor blackColor];
        zhiwei.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:zhiwei];
        
        
        textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 60 ,  kScreenWidth - 100, 60)];
        textfield.clearButtonMode = UITextFieldViewModeNever;
        textfield.keyboardType = UIKeyboardTypeDefault;
        textfield.tag = indexPath.row + 100;
        textfield.text = [UserDefaults objectForKey:Name_sure];
        textfield.font = [UIFont systemFontOfSize:14];
        textfield.returnKeyType = UIReturnKeyDone;
        
        [cell.contentView addSubview:textfield];
        
        
        
        textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 120 ,  kScreenWidth - 100, 60)];
        textfield1.clearButtonMode = UITextFieldViewModeNever;
        textfield1.keyboardType = UIKeyboardTypeNumberPad;
        textfield1.tag = indexPath.row + 200;
        textfield1.returnKeyType = UIReturnKeyDone;
        textfield1.font = [UIFont systemFontOfSize:14];
        textfield1.text = [UserDefaults objectForKey:Mobile];
//        [textfield1 addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventTouchDown];
        [cell.contentView addSubview:textfield1];
        
        
        text = [[UITextView alloc] initWithFrame:CGRectMake(100, 193, kScreenWidth - 100, 80)];
        text.tag = 400 + indexPath.row;
        text.font = [UIFont systemFontOfSize:14];
        text.delegate = self;
        text.returnKeyType = UIReturnKeyDone;
        [cell.contentView addSubview:text];
        
        UILabel *_label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:18];
        _label.frame =CGRectMake(5 , 0, text.width - 25, 35);
        _label.text = @"请填写备注";
        _label.font = [UIFont systemFontOfSize:14];
        _label.tag = 99;
        _label.textColor = [UIColor colorWithRed:199 / 255.0 green:196 / 255.0 blue:196 / 255.0 alpha:1];
        _label.enabled = NO;         //lable必须设置为不可用
        [text addSubview:_label];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 340, kScreenWidth, 10)];
        view.backgroundColor = Color(241, 241, 241);
        [cell.contentView addSubview:view];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    UILabel *label = (UILabel *)[textView viewWithTag:99];
    if (textView.text.length == 0) {
        label.text = @"非必要填项";
    }else{
        label.text = @"";
    }
    
}

@end
