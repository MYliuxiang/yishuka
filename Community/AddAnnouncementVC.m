//
//  AddAnnouncementVC.m
//  Community
//
//  Created by 刘翔 on 16/3/31.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "AddAnnouncementVC.h"
//#import "IQKeyboardManager.h"

@interface AddAnnouncementVC ()

@end

@implementation AddAnnouncementVC


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
//    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"通告牌";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titles = @[@"课    程",@"群    组",@"开始时间",@"结束时间",@"备  注"];
    self.mpoint = CGPointMake(0, 0);
    [self _initFooter];
    [self _initTime];
    
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = NO;
    

}

- (void)_initTime
{
    timeView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200)];
    timeView.backgroundColor = [UIColor whiteColor];
    //    [UIView animateWithDuration:.35 animations:^{
    //        _view1.frame = CGRectMake(0, kScreenHeight-162, kScreenWidth, 162);
    //
    //    }];
    
    datepick  = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth , 162)];
    datepick.backgroundColor = [UIColor whiteColor];
    datepick.datePickerMode = UIDatePickerModeTime;
    [datepick addTarget:self action:@selector(dateValue:) forControlEvents:UIControlEventValueChanged];

    [timeView addSubview:datepick];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 60, 20, 50, 20);
    //    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [timeView addSubview:button];
    [self.view addSubview:timeView];

}

- (void)dateValue:(UIDatePicker *)picker
{
    NSLog(@"%@",picker.date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:picker.date];
    self.seleText.text = strDate;

}

- (void)buttonAction
{
    
    [_tableView setContentOffset:self.mpoint animated:YES];
    [UIView animateWithDuration:.35 animations:^{
        timeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        
    }];
    


}

- (void)_initFooter
{
    
    self.dataList = [NSMutableArray array];
    [self.dataList addObject:@"1"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth - 30, 30)];
    button.backgroundColor = Color_nav;
    [button setTitle:@"+添加更多时段" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addtime:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, kScreenWidth, 1)];
    imageView.backgroundColor = [UIColor grayColor];
    [view addSubview:imageView];
    
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(15, 90, kScreenWidth - 30, 35)];
    button1.backgroundColor = Color_nav;
    [button1 setTitle:@"提 交" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(tijiao:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
    _tableView.tableFooterView = view;


}

- (void)addtime:(UIButton *)sender
{
    
    int a = self.dataList.count;
    NSIndexPath *path = [NSIndexPath indexPathForItem:a inSection:0];
    [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
    [self.dataList addObject:@"1"];
    [_tableView endUpdates];


}

- (void)tijiao:(UIButton *)sender
{
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        
        
        for (int i = 0; i < 4; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 60 + 59, kScreenWidth, .5)];
            imageView.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:imageView];
        }
        
        for (int i = 0; i < 5; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, i*60, 60, 60)];
            label.text = self.titles[i];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
        }
        
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, kScreenWidth - 90, 60)];
        label1.text = @"音乐 器乐 钢琴 张丽";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label1];
        

        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(80, 60 ,  kScreenWidth - 100, 60)];
        textfield.clearButtonMode = UITextFieldViewModeNever;
        textfield.keyboardType = UIKeyboardTypeDefault;
        textfield.tag = indexPath.row + 100;
        textfield.placeholder = @"请选择群组";
        textfield.delegate = self;
        textfield.font = [UIFont systemFontOfSize:14];
        textfield.returnKeyType = UIReturnKeyDone;
        [textfield addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventTouchDown];

        [cell.contentView addSubview:textfield];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 85, 10, 10)];
        imageView.image = [UIImage imageNamed:@"v"];
        [cell.contentView addSubview:imageView];
        
        
        UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(80, 120 ,  kScreenWidth - 100, 60)];
        textfield1.clearButtonMode = UITextFieldViewModeNever;
        textfield1.keyboardType = UIKeyboardTypeDefault;
        textfield1.tag = indexPath.row + 200;
        textfield1.placeholder = @"请输入开始时间";
        textfield1.delegate = self;
        textfield1.returnKeyType = UIReturnKeyDone;
        textfield1.font = [UIFont systemFontOfSize:14];
        [textfield1 addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventTouchDown];
        [cell.contentView addSubview:textfield1];
        
        
        UITextField *textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(80, 180 ,  kScreenWidth - 100, 60)];
        textfield2.clearButtonMode = UITextFieldViewModeNever;
        textfield2.keyboardType = UIKeyboardTypeDefault;
        textfield2.tag = indexPath.row + 300;
        textfield2.placeholder = @"请结束时间";
        textfield2.delegate = self;
        textfield2.returnKeyType = UIReturnKeyDone;
        textfield2.font = [UIFont systemFontOfSize:14];
        [textfield2 addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventTouchDown];

        [cell.contentView addSubview:textfield2];
        
        
        UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(80, 250, kScreenWidth - 100, 80)];
        text.tag = 400 + indexPath.row;
        text.delegate = self;
        text.font = [UIFont systemFontOfSize:14];
        text.backgroundColor = Color_cell;
        text.returnKeyType = UIReturnKeyDone;
        [cell.contentView addSubview:text];
        text.backgroundColor = [UIColor clearColor];
        
       UILabel *_label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:18];
        _label.frame =CGRectMake(0 , 0, text.width - 20, 35);
        _label.text = @"非必填项";
        _label.font = [UIFont systemFontOfSize:14];
        _label.tag = 99;
        _label.textColor = [UIColor colorWithRed:199 / 255.0 green:196 / 255.0 blue:196 / 255.0 alpha:1];
        _label.enabled = NO;         //lable必须设置为不可用
        _label.backgroundColor = [UIColor clearColor];
        [text addSubview:_label];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 340, kScreenWidth, 10)];
        view.backgroundColor = Color(241, 241, 241);
        [cell.contentView addSubview:view];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = Color_cell;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   


}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    


}

- (void)textClick:(UITextField *)textField
{
    
    [self.view endEditing:NO];
    self.mpoint = _tableView.contentOffset;
    if ((int)textField.tag / 100 == 1) {
        NSLog(@"选择好友");
    }
    
    if((int)textField.tag / 100 == 2){
        self.seleText = textField;

        CGFloat bom;
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForItem:textField.tag - 200 inSection:0]];
        CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
        bom = rect.origin.y + 180;
        
        if (kScreenHeight - bom < 200) {
            
            
            [_tableView setContentOffset:CGPointMake(0.0, _tableView.contentOffset.y + 200 - (kScreenHeight - bom)) animated:YES];
            
        }

        
        if(timeView.top == kScreenHeight)
            [UIView animateWithDuration:.35 animations:^{
                timeView.frame = CGRectMake(0, kScreenHeight- 200, kScreenWidth, 200);
                
            }];
        
    }
    if ((int)textField.tag / 100 == 3) {
        
        self.seleText = textField;
        CGFloat bom;
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForItem:textField.tag - 300 inSection:0]];
        CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
        bom = rect.origin.y + 240;

        if (kScreenHeight - bom < 200) {
            
        
            [_tableView setContentOffset:CGPointMake(0.0, _tableView.contentOffset.y + 200 - (kScreenHeight - bom)) animated:YES];
        }

        NSLog(@"结束时间");
        if(timeView.top == kScreenHeight)
            [UIView animateWithDuration:.35 animations:^{
                timeView.frame = CGRectMake(0, kScreenHeight- 200, kScreenWidth, 200);
                
            }];
    }

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return NO;

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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(timeView.top == kScreenHeight - 200){
        [UIView animateWithDuration:.35 animations:^{
            timeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
            
        }];
    }
    
    return YES;
    

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}




@end
