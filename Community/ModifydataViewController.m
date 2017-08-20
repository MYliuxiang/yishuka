//
//  ModifydataViewController.m
//  Community
//
//  Created by 李立 on 16/5/8.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ModifydataViewController.h"

@implementation ModifydataViewController{

    NSString * _headimgurl;
    UIImage *_headerimg;
    NSDate *_date;

}



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.text = @"修改资料";
    self.ISFANHUI = YES;

    [self _initView];

}

//初始化视图
-(void)_initView
{
    _headimgurl = @"";
    
    if([[UserDefaults objectForKey:Group] integerValue] == 1)
    {
     _tiletes = @[@"更改头像",@"姓名",@"手机号",@"生日",@"身份证号",@"住址"];
    } else {
     _tiletes = @[@"更改头像",@"姓名",@"手机号",@"生日",@"身份证号",@"住址",@"简介"];
    
    }
    
    //创建表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth  , kScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    
    //头视图
    _tableView.tableHeaderView = ({
        UIView *bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        
        bjview;
        
    });
    
    //尾视图
    _tableView.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
        UIButton *tijiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tijiaoButton.backgroundColor = Color_nav;
        [tijiaoButton setTitle:@"提交修改" forState:UIControlStateNormal];
        tijiaoButton.frame = CGRectMake((kScreenWidth-150)/2.0, 60, 150, 40);
        tijiaoButton.titleLabel.textColor = [UIColor whiteColor];
        [footerbjView addSubview:tijiaoButton];
        [tijiaoButton addTarget:self action:@selector(tijiaoAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        footerbjView;
        
        
    });
    
    [self.view addSubview:_tableView];
}




//上传头像
//- (void)uploadUserPhotot{
//
//    
//
//
//}


- (void)tijiaoAction:(UIButton *)button{
    
    if (![InputCheck isPhone:_phoneTextFiel.text]) {
        [MBProgressHUD showError:@"请输入正确手机号" toView:self.view];
        return;
    }

    
    if (_nameTextField.text.length == 0) {
        [MBProgressHUD showError:@"昵称不能为空" toView:self.view];
        return;
    }
    
    
    if ([_birthdayTextFiel.titleLabel.text isEqualToString:@"请选择生日"] ) {
        [MBProgressHUD showError:@"出生年月不能为空" toView:self.view];
        return;
    }
    
    if (_IDTextFiel.text.length == 0) {
        [MBProgressHUD showError:@"身份证号不能为空" toView:self.view];
        return;
    }
    
    if (_addressTextFiel.text.length == 0) {
        [MBProgressHUD showError:@"地址不能为空" toView:self.view];
        return;
    }
    
    if (_IDTextFiel.text.length != 18) {
        [MBProgressHUD showError:@"请输入正确的身份证号" toView:self.view];
        return;
    }
    
   
    
    [self xiugaiziliao];
  

}


-(void)xiugaiziliao{

    NSDictionary *params;
    
    
    
    if([[UserDefaults objectForKey:Group] integerValue] == 1)
    {
        params = @{@"member_id":[UserDefaults objectForKey:Userid],
                   @"mobile":_phoneTextFiel.text,
                   @"name":_nameTextField.text,
                   @"idcard":_IDTextFiel.text,
                   @"birthday":_birthdayTextFiel.titleLabel.text,
                   @"address":_addressTextFiel.text,
                   @"headimgurl":_headimgurl,
                   @"description":@"",
                   };
    } else {
        
        params = @{@"member_id":[UserDefaults objectForKey:Userid],
                   @"mobile":_phoneTextFiel.text,
                   @"name":_nameTextField.text,
                   @"idcard":_IDTextFiel.text,
                   @"birthday":_birthdayTextFiel.titleLabel.text,
                   @"address":_addressTextFiel.text,
                   @"headimgurl":_headimgurl,
                   @"description":self.jiaajieTextFiel.text,
                   };
    }
    [WXDataService requestAFWithURL:URL_updateMemberInfo params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        if ([result[@"status"]integerValue]==0) {
            NSDictionary *dic = result[@"result"][@"info"];
            [UserDefaults setObject:dic[@"name"] forKey:Username];
            [UserDefaults setObject:dic[@"idcard"] forKey:idcard];
            [UserDefaults setObject:dic[@"mobile"] forKey:Mobile];
            [UserDefaults setObject:dic[@"birthday"] forKey:birthday];
            [UserDefaults setObject:dic[@"address"] forKey:Address];
            [UserDefaults setObject:dic[@"headimgurl"] forKey:Headimgurl];
            [UserDefaults setObject:dic[@"name"] forKey:Name_sure];
            [UserDefaults setObject:self.jiaajieTextFiel.text forKey:Description];
          
            [MBProgressHUD showSuccess:result[@"msg"] toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
        }
        
        [_tableView reloadData];
        
    } errorBlock:^(NSError *error) {
        
    }];


}



- (void)xiugai
{
    NSLog(@"修改头像");
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"相机",@"相册",nil];
    [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}



#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:  //打开本地相册
            [self CreameAction:1];
            break;
        case 1:
            [self CreameAction:2];
            break;
    }
}


////拍照的点击事
- (void)CreameAction:(NSInteger )index{
    
    UIView *vvv = [[UIApplication sharedApplication].keyWindow viewWithTag:7000];
    [UIView animateWithDuration:.35 animations:^{
        [vvv setTop:kScreenHeight];
    }];;
    
    static NSUInteger sourceType;
    
    if (index ==1) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(index ==2){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _touxiangImageView.image = image;
        
        
        _headerimg = _touxiangImageView.image;
        
        NSData *imageData = UIImageJPEGRepresentation(_headerimg, .3);
        [WXDataService postImage:URL_shangchuan params:nil fileData:imageData finishBlock:^(id result) {
            
            //成功
            if ([[result objectForKey:@"status"] integerValue] == 0){
                NSDictionary *dic = result[@"result"];
                _headimgurl = dic[@"headimgurl"];
                
            }else{
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            }
            
            
        } errorBlock:^(NSError *error) {
            
        }];
    }];
    
    
    
}





//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    if (indexPath.row == 6) {
        return 100;
    }
    return 60;
    
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
            return _tiletes.count;
    
}

//尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setAccessoryType:UITableViewCellAccessoryNone];
      
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 60-0.5, kScreenWidth, .5)];
        lineview.tag = 200;
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        [cell.contentView addSubview:lineview];
    }
    
    
    UIView *liView = [cell.contentView viewWithTag:200];
    if (indexPath.row == 0) {
        liView.frame = CGRectMake(0, 80-0.5, kScreenWidth, .5);
    }
    if (indexPath.row == 6) {
        liView.frame = CGRectMake(0, 100-0.5, kScreenWidth, .5);
    }
  
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = _tiletes[indexPath.row];
    
    if (indexPath.row == 0) {
        _touxiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-70, 10, 60, 60)];
        _touxiangImageView.backgroundColor = [UIColor clearColor];
        _touxiangImageView.layer.masksToBounds = YES;
        //描边
        _touxiangImageView.layer.cornerRadius = 60/2; //圆角（圆形）
        [cell.contentView addSubview:_touxiangImageView];
        _touxiangImageView.clipsToBounds = YES;
        _touxiangImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiugai)];
        [_touxiangImageView addGestureRecognizer:tap];
        _touxiangImageView.contentMode = UIViewContentModeScaleAspectFill;
        NSString *gg =[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Headimgurl]] ;
        [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:gg] placeholderImage:nil];
        
        
           }
    if (indexPath.row ==1) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 260, 20, 250, 20)];
        _nameTextField.delegate = self;
        _nameTextField.placeholder = @"昵称";
        _nameTextField.textAlignment = NSTextAlignmentRight;
        _nameTextField.textColor = [UIColor grayColor];
        _nameTextField.font = [UIFont systemFontOfSize:12];
        _nameTextField.text = [UserDefaults objectForKey:Name_sure];
        [cell.contentView addSubview:_nameTextField];
    }
    if (indexPath.row ==2) {
        _phoneTextFiel = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 260, 20, 250, 20)];
        _phoneTextFiel.placeholder = @"请输入手机号";
        _phoneTextFiel.textColor = [UIColor grayColor];
        _phoneTextFiel.textAlignment = NSTextAlignmentRight;
        _phoneTextFiel.delegate = self;
        _phoneTextFiel.font = [UIFont systemFontOfSize:12];
        _phoneTextFiel.text = [UserDefaults objectForKey:Mobile];
        [cell.contentView addSubview:_phoneTextFiel];
    }
    if (indexPath.row == 3) {
        _birthdayTextFiel = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 170, 20, 160, 20)];
//        _birthdayTextFiel.placeholder = ;
        _birthdayTextFiel.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        
         NSString *bir = [UserDefaults objectForKey:birthday];
        if (bir.length==0) {
            [_birthdayTextFiel setTitle:@"请选择生日" forState:UIControlStateNormal];
        }else{
            [_birthdayTextFiel setTitle:[UserDefaults objectForKey:birthday] forState:UIControlStateNormal];
        }
        
        
        [_birthdayTextFiel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _birthdayTextFiel.titleLabel.font = [UIFont systemFontOfSize:12];
   
        [cell.contentView addSubview:_birthdayTextFiel];
        [_birthdayTextFiel addTarget:self action:@selector(time:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    if (indexPath.row == 4) {
        _IDTextFiel = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 260, 20, 250, 20)];
        _IDTextFiel.placeholder = @"请填写身份号码";
        _IDTextFiel.textColor = [UIColor grayColor];
        _IDTextFiel.textAlignment = NSTextAlignmentRight;
        _IDTextFiel.font = [UIFont systemFontOfSize:12];
        _IDTextFiel.delegate = self;
        _IDTextFiel.text = [UserDefaults objectForKey:idcard];
        [cell.contentView addSubview:_IDTextFiel];

    }
    if (indexPath.row == 5) {
        _addressTextFiel = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 260, 20, 250, 20)];
        _addressTextFiel.placeholder = @"请填写地址";
        _addressTextFiel.textColor = [UIColor grayColor];
        _addressTextFiel.textAlignment = NSTextAlignmentRight;
        _addressTextFiel.font = [UIFont systemFontOfSize:12];
        _addressTextFiel.delegate = self;
        _addressTextFiel.text = [UserDefaults objectForKey:Address];
        [cell.contentView addSubview:_addressTextFiel];

    }
    
    if (indexPath.row == 6) {
        _jiaajieTextFiel = [[UITextView alloc]initWithFrame:CGRectMake( 100, 20, kScreenWidth - 110, 60)];
        _jiaajieTextFiel.textColor = [UIColor grayColor];
        _jiaajieTextFiel.textAlignment = NSTextAlignmentRight;
        _jiaajieTextFiel.font = [UIFont systemFontOfSize:12];
//        _jiaajieTextFiel.delegate = self;
        _jiaajieTextFiel.text = [UserDefaults objectForKey:Description];
        [cell.contentView addSubview:_jiaajieTextFiel];
        
    }
       return cell;
    
}


//监听下拉的点击时间
- (void)time:(UIButton *)button{
    
//    if (button.tag==125) {
//        _type=1;
//    }else{
//        _type=2;
//    }
    
    //背景颜色
    
    UIImageView *bjview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bjview.userInteractionEnabled = YES;
    [bjview setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    bjview.tag = 6000;
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [bjview addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:bjview];
    
    
    self.datePicker = [[ UIDatePicker alloc ] initWithFrame:CGRectMake(0,kScreenHeight-150*ratioHeight, kScreenWidth, 150*ratioHeight)];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    // 只显示时间
    self.datePicker. datePickerMode = UIDatePickerModeDate ;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    //    NSDate *maxdate = [dateFormatter dateFromString:self.search_timeDic[@"end_time"]];
    //    NSDate *mindate = [dateFormatter dateFromString:self.search_timeDic[@"begin_time"]];
    //    self.datePicker.maximumDate = maxdate;
    //    self.datePicker.minimumDate = mindate;
    
    
    
    
    // 显示中文
    self.datePicker. locale = [ NSLocale localeWithLocaleIdentifier : @"zh" ];
    
    //监听值得改变
    [self.datePicker addTarget : self action : @selector (datePickerValueChanged:) forControlEvents : UIControlEventValueChanged ];
    
    //默认值
    _date = [NSDate date];
    
    [bjview addSubview:self.datePicker];
    
    
    UIImageView *dateimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.datePicker.top-40*ratioHeight, kScreenHeight, 40*ratioHeight)];
    dateimg.backgroundColor = Color(245, 245, 245);
    [bjview addSubview:dateimg];
    dateimg.userInteractionEnabled =YES;
    
    //确定按钮
    UIButton *enter = [[UIButton alloc]initWithFrame:CGRectMake(10*ratioWidth, 0, 40*ratioWidth,dateimg.height )];
    [enter setTitle:@"确定" forState:UIControlStateNormal];
    enter.titleLabel.font = [UIFont systemFontOfSize:14*ratioHeight];
    [enter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateimg addSubview:enter];
    [enter addTarget:self action:@selector(enterAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


- ( void )datePickerValueChanged:( UIDatePicker *)datePicker{
    _date = datePicker.date;
}

//时间选择器的确定按钮
- (void)enterAction:(UIButton *)buton{
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
    // 格式化日期格式
    formatter. dateFormat = @"yyyy-MM-dd" ;

    [_birthdayTextFiel setTitle:[formatter stringFromDate:_date] forState:UIControlStateNormal];


    
    
    UIView *bgview = [[UIApplication sharedApplication].keyWindow viewWithTag:6000];
    bgview.hidden = YES;
    [bgview removeFromSuperview];
    
}

//手势点击
- (void)tapAction:(UIButton *)button{
    UIView *bgview = [[UIApplication sharedApplication].keyWindow viewWithTag:6000];
    bgview.hidden = YES;
    [bgview removeFromSuperview];
    self.datePicker = nil;
    
}






//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    

}


//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
 
    
}







//隐藏键盘
- (void)hiddnkeyActionWith:(UITextField *)textView
{
    [self keyfileActionWith:textView];
//    [UIView animateWithDuration:.35 animations:^{
//        CGPoint Y = CGPointMake(0, 0);
//        _tableView.contentOffset = Y;
//    }];
    
    
    
}

- (void)keyfileActionWith:(UITextField *)textView
{
    if (![textView isExclusiveTouch]) {
        [textView resignFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    [self hiddnkeyActionWith:textField];
    
    return YES;
}


@end
