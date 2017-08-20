//
//  AddViewController.m
//  Community
//
//  Created by 李江 on 16/7/6.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "AddViewController.h"
#import "Add1Cell.h"
#import "Add2Cell.h"
#import "JiGouModel.h"
#import "xialaTableview.h"
#import "ClassLIstModel.h"

@interface AddViewController ()<xialadelegate>
@property(nonatomic,strong)NSMutableArray *dataAry;
@property(nonatomic,strong)NSMutableArray *JGlistAry;
@property(nonatomic,strong)NSMutableArray *JGClasslistAry;
@property(nonatomic,copy)NSString *JGid;
@property(nonatomic,copy)NSString *JGClassid;
@property(nonatomic,copy)NSString *Courseid;
@property(nonatomic,strong)UIDatePicker *datePicker;//时间选择器
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign)NSInteger type;


@end

@implementation AddViewController{

    xialaTableview *xiala;
    UIButton *_content;
    UITextField *_contentfiled;
    UITextView *textview;
    NSDate *_date;
    NSArray *room_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataAry = [NSMutableArray new];
    [_dataAry addObjectsFromArray:@[@"2016年4月13日 星期五",@"选择机构",@"选择班级",@"课程类别",@"开始时间",@"结束时间",@"上课地址",@"备        注"]];
    [self jigouData];
    [self _InitVIew];
    self.text = @"增加通告";
    
    if (_index==2) {
        [self xiugai_loaddata];
        [self addrightBtntitleString:@"删除" imageString:nil];
        self.rightText.textAlignment = NSTextAlignmentRight;
        [self.rightText setTextColor:[UIColor whiteColor]];
         self.text = @"修改通告";
    }

}


- (void)rightAction{

    NSDictionary *params =@{@"member_id":[UserDefaults objectForKey:Userid],@"id":self.bid};
    
    [WXDataService requestAFWithURL:URL_infoDel params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        if ([result[@"status"] intValue] == 0){
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            [self.navigationController popViewControllerAnimated:YES];
              [[NSNotificationCenter defaultCenter]postNotificationName:@"delete111" object:nil userInfo:@{@"riqi":self.dateStr}];
        }
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



//修改
- (void)xiugai_loaddata{
    NSDictionary *params = @{@"member_id":[UserDefaults objectForKey:Userid],@"id":self.bid};
    
    UIButton *button1 = [_ScrollView viewWithTag:120]; //机构列表
    UIButton *button2 = [_ScrollView viewWithTag:121]; //班级列表
    UIButton *button3 = [_ScrollView viewWithTag:125]; //开始时间
    UIButton *button4 = [_ScrollView viewWithTag:126]; //结束时间
    UIButton *button5 = [_ScrollView viewWithTag:123]; //课程类别
    
//    UITextField *textfiled = [_ScrollView viewWithTag:134]; //课程名称
    UIButton *room = [_ScrollView viewWithTag:127]; //地址
    [room setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UITextField *textfiled2 = [_ScrollView viewWithTag:138]; //备注
    
    [WXDataService requestAFWithURL:URL_infoUpdatePage params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        if ([result[@"status"] intValue] == 0){
            NSDictionary *dataDic = result[@"result"];
            NSDictionary *info = dataDic[@"info"];
            [button3 setTitle:info[@"starttime"] forState:UIControlStateNormal];
            [button4 setTitle:info[@"endtime"] forState:UIControlStateNormal];
            [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            room.titleLabel.text = info[@"address"];
            textfiled2.text = info[@"description"];
//            textfiled.text = info[@"title"];
            
            NSArray *agency_list = dataDic[@"agency_list"];
            [agency_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"selected"]integerValue]==1) {
                    [button1 setTitle:obj[@"title"] forState:UIControlStateNormal];
                    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    self.JGid = obj[@"id"];
                }
                
            }];
            
            NSArray *class_list = dataDic[@"class_list"];
            [class_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"selected"]integerValue]==1) {
                    [button2 setTitle:obj[@"title"] forState:UIControlStateNormal];
                    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    self.JGClassid = obj[@"id"];
                    
                    [button5 setTitle:obj[@"course_title"] forState:UIControlStateNormal];
                    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    self.Courseid = obj[@"course_id"];
                }
            }];
            
            [self class_loadJGid:self.JGid];
        }else{
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    


}



//获取当前老师所属机构
- (void)jigouData{
    
    NSDictionary *params = @{@"member_id":[UserDefaults objectForKey:Userid]};
    [WXDataService requestAFWithURL:URL_getTeacherAgency params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        _JGlistAry = [NSMutableArray new];
        if ([result[@"status"] intValue] == 0) {
            NSDictionary *resultdic = result[@"result"];
            NSArray *listAry = resultdic[@"list"];
            [listAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JigouModel *model = [[JigouModel alloc]initWithDataDic:obj];
                model.JGid = obj[@"id"];
                [self.JGlistAry addObject:model];
            }];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

//获取当前机构所属班级
- (void)class_data:(NSString *)classid{

    

}


- (void)_InitVIew{
    
    
    _ScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-64+200);
    _ScrollView.backgroundColor = [UIColor clearColor];
    _ScrollView.showsHorizontalScrollIndicator = YES;
    _ScrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_ScrollView];
    UILabel *line;
    for (int i=0; i<_dataAry.count; i++) {
        {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 56*i, 90, 55)];
        title.font = [UIFont systemFontOfSize:14];
        title.text= _dataAry[i];
        [_ScrollView addSubview:title];
            
            if (i==0) {
                // 格式化日期格式
                title.text = self.dateStr1;
            }
            
        line = [[UILabel alloc]initWithFrame:CGRectMake(0, title.bottom,kScreenWidth, 0.5)];
        line.backgroundColor = Color(188, 188, 194);
        [_ScrollView addSubview:line];
            
            if (i==0) {
                [title setWidth:200];
            }
            
            
            if (i ==1 || i==3 || i ==2 || i==4 ||i==5 || i ==6) {
                _content = [[UIButton alloc]initWithFrame:CGRectMake(title.right, title.top, kScreenWidth-title.right-25, title.height)];
                _content.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
                _content.titleLabel.font = [UIFont systemFontOfSize:14];
                [_content setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_ScrollView addSubview:_content];
                if (i==1) {
                    
                    [_content setTitle:_JGlistAry[0] forState:UIControlStateNormal];
                    _content.tag = 120;
                    [_content setTitle:@"请选择机构" forState:UIControlStateNormal];
                    [_content setTitleColor:Color(188, 188, 194) forState:UIControlStateNormal];
                    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-25,title.top+(55-10)/2.0,10, 10)];
                    imgview.image = [UIImage imageNamed:@"v"];
                    [_ScrollView addSubview:imgview];
                    [_content addTarget:self action:@selector(contenAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                if (i==3) {
                    _content.tag = 123;
                    [_content setTitle:@"" forState:UIControlStateNormal];
                   
                }

                if (i==2) {
                    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-25,title.top+(55-10)/2.0,10, 10)];
                    imgview.image = [UIImage imageNamed:@"v"];
                    [_ScrollView addSubview:imgview];
                    [_content setTitle:@"请选择班级" forState:UIControlStateNormal];
                    _content.tag = 121;
                    [_content setTitleColor:Color(188, 188, 194) forState:UIControlStateNormal];
                    [_content addTarget:self action:@selector(contenAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                if (i==4) {
                    [_content setTitle:@"请选择开始时间" forState:UIControlStateNormal];
                    [_content setTitleColor:Color(188, 188, 194) forState:UIControlStateNormal];
                    [_content addTarget:self action:@selector(time:) forControlEvents:UIControlEventTouchUpInside];
                    _content.tag = 125;
        
                }
                if (i==5) {
                    [_content addTarget:self action:@selector(time:) forControlEvents:UIControlEventTouchUpInside];
                    [_content setTitle:@"请选择结束时间" forState:UIControlStateNormal];
                    [_content setTitleColor:Color(188, 188, 194) forState:UIControlStateNormal];
                    _content.tag = 126;
                }
                
                
                if (i==6) {
                    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-25,title.top+(55-10)/2.0,10, 10)];
                    imgview.image = [UIImage imageNamed:@"v"];
                    [_ScrollView addSubview:imgview];
                    [_content setTitle:@"请选择地址" forState:UIControlStateNormal];
                    _content.tag = 127;
                    [_content setTitleColor:Color(188, 188, 194) forState:UIControlStateNormal];
                    [_content addTarget:self action:@selector(contenAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                
            }else if( i==7 ){
                 _contentfiled = [[UITextField alloc]initWithFrame:CGRectMake(title.right, title.top, kScreenWidth-title.right-25, title.height)];
                _contentfiled.font =[UIFont systemFontOfSize:14];
                [_ScrollView addSubview:_contentfiled];
    
                
                if (i==7) {
                    _contentfiled.tag = 138;
                    _contentfiled.placeholder = @"非必填项。";
                }
                
//                if (i==6) {
//                    _contentfiled.tag = 127;
//                    _contentfiled.placeholder  = @"请填写地址";
//                }
            }
//            else{
//            
//                textview = [[UITextView alloc]initWithFrame:CGRectMake(title.right, title.top, kScreenWidth-title.right-25, title.height)];
//                [_ScrollView addSubview:textview];
//            
//            }
            
    };
        
        
    }
    
    
    UIButton *tijiao = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-200)/2.0,_contentfiled.bottom+40,200, 45)];
    tijiao.layer.cornerRadius = 5;
    tijiao.layer.masksToBounds = YES;
    tijiao.backgroundColor = Color_nav;
    [tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tijiao setTitle:@"提交" forState:UIControlStateNormal];
//    tijiao.titleLabel.font = [UIFont systemFontOfSize:13];
    [tijiao addTarget:self action:@selector(tiaojiaoAction:) forControlEvents:UIControlEventTouchUpInside];
    [_ScrollView addSubview:tijiao];
    
    _ScrollView.contentSize = CGSizeMake(kScreenWidth, tijiao.bottom+50);
    
    
}


- (void)tiaojiaoAction:(UIButton *)button{

//    member_id用户ID
//    agency_id机构ID
//    class_id班级ID
//    course_id课程类别ID
//    title课程名称
//    address上课地点
//    starttime开始时间(格式2016-06-22 10:30)
//    endtime结束时间(格式2016-06-22 10:30)
//    description备注
    
    UIButton *button1 = [_ScrollView viewWithTag:120];
    UIButton *button2 = [_ScrollView viewWithTag:121];
    UIButton *button3 = [_ScrollView viewWithTag:125];
    UIButton *button4 = [_ScrollView viewWithTag:126];
    
    UITextField *textfiled = [_ScrollView viewWithTag:134]; //课程类别
    UIButton *room = [_ScrollView viewWithTag:127];
    UITextField *textfiled2 = [_ScrollView viewWithTag:138];
    
    if (self.JGid.length==0) {
        [MBProgressHUD showError:@"机构名称不能为空" toView:self.view];
        return;
    }
    
    if (self.JGClassid.length==0) {
        [MBProgressHUD showError:@"班级不能为空" toView:self.view];
        return;
    }
    
    if ([button3.titleLabel.text isEqualToString:@"请选择开始时间"]) {
        [MBProgressHUD showError:@"开始时间不能为空" toView:self.view];
        return;
    }
    
    if ([button4.titleLabel.text isEqualToString:@"请选择结束时间"]) {
        [MBProgressHUD showError:@"结束时间不能为空" toView:self.view];
        return;
    }
    
    if (room.titleLabel.text.length ==0) {
        [MBProgressHUD showError:@"上课地址不能为空" toView:self.view];
        return;
    }
    
    
//    if (textfiled1.text.length ==0) {
//        [MBProgressHUD showError:@"上课地址不能为空" toView:self.view];
//        return;
//    }
    
    NSString *starttime = [NSString stringWithFormat:@"%@ %@",_dateStr,button3.titleLabel.text];
    NSString *endtime = [NSString stringWithFormat:@"%@ %@",_dateStr,button4.titleLabel.text];
    
    
    NSDictionary *params;
    if (_index==2) {
        params = @{@"member_id":[UserDefaults objectForKey:Userid],
                                 @"agency_id":_JGid,
                                 @"class_id":_JGClassid,
                                 @"course_id":_Courseid,
                                 @"address":room.titleLabel.text,
                                 @"starttime":starttime,
                                 @"endtime":endtime,
                                 @"description":textfiled2.text,
                                 @"id":self.bid
                                 };
    }else{
    
       
        params = @{@"member_id":[UserDefaults objectForKey:Userid],
                                 @"agency_id":_JGid,
                                 @"class_id":_JGClassid,
                                 @"course_id":_Courseid,
                                 //                             @"title":textfiled.text,
                                 @"address":room.titleLabel.text,
                                 @"starttime":starttime,
                                 @"endtime":endtime,
                                 @"description":textfiled2.text,
                                };
    
    }
    

    
    if (_index==2) {
        
        [WXDataService requestAFWithURL:URL_infoUpdateSub params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
            if ([result[@"status"] intValue] == 0) {
                
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"delete111" object:nil userInfo:@{@"riqi":self.dateStr}];
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            }else{
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else{
        [WXDataService requestAFWithURL:URL_infoAddSub params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
            if ([result[@"status"] intValue] == 0) {
                
                [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"delete111" object:nil userInfo:@{@"riqi":self.dateStr}];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}


- (void)contenAction:(UIButton *)button{

    if (button.tag == 120) {
        button.selected =! button.selected;
        
        if (button.selected) {
            xiala = [[xialaTableview alloc]initWithFrame:CGRectMake(kScreenWidth-160, 95,150, 200)];
            xiala.delegate =self;
            [_ScrollView addSubview:xiala];
            [xiala dataAry:self.JGlistAry type:1];
            
        }else{
            [xiala removeFromSuperview];
        }
    }

    
    if (button.tag == 121) {
        if (_JGClasslistAry.count==0) {
            [MBProgressHUD showError:@"请先选择机构" toView:self.view];
            return;
            
        }
        
        button.selected =! button.selected;
        
        if (button.selected) {
            xiala = [[xialaTableview alloc]initWithFrame:CGRectMake(kScreenWidth-160, 150,150, 200)];
            xiala.delegate =self;
            [_ScrollView addSubview:xiala];
            [xiala dataAry:self.JGClasslistAry type:2];
        }else{
            [xiala removeFromSuperview];
        }
    }
    
    
    if (button.tag == 127) {
        if (_JGClasslistAry.count==0) {
            [MBProgressHUD showError:@"请先选择机构" toView:self.view];
            return;
            
        }
        
        button.selected =! button.selected;
        
        if (button.selected) {
            xiala = [[xialaTableview alloc]initWithFrame:CGRectMake(kScreenWidth-160, 375,150, 200)];
            xiala.delegate =self;
            [_ScrollView addSubview:xiala];
            [xiala dataAry:room_arr type:3];
        }else{
            [xiala removeFromSuperview];
        }
    }
    
    
}


- (void)JGmodel:(JigouModel *)model type:(NSInteger)type room:(NSString *)string{
   
    if (type==1) {
        UIButton *button = [_ScrollView viewWithTag:120];
        [button setTitle:model.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.JGid = model.JGid;
        [xiala removeFromSuperview];
        [self class_loadJGid:self.JGid];

        
    }else if (type==2){
        [xiala removeFromSuperview];
        UIButton *button = [_ScrollView viewWithTag:121];
        [button setTitle:model.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _JGClassid = model.classid;
        
        //课程类别
        UIButton *kec = [_ScrollView viewWithTag:123];
        [kec setTitle:model.course_title forState:UIControlStateNormal];
        [kec setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _Courseid = model.course_id;
        
//        //地址
//        UITextField *adress = [_ScrollView viewWithTag:127];
//        adress.text = model.address;
    
    }else{
       
         UIButton *button = [_ScrollView viewWithTag:127];
        [button setTitle:string forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [xiala removeFromSuperview];
    
    }
    
    
    
}


- (void)class_loadJGid:(NSString *)JGid{

    NSDictionary *params = @{@"member_id":[UserDefaults objectForKey:Userid],
                             @"agency_id":JGid};
    self.JGClasslistAry = [NSMutableArray new];
    [WXDataService requestAFWithURL:URL_getTeacherAgencyClass params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        if ([result[@"status"] intValue] == 0) {
            NSDictionary *resultdic = result[@"result"];
            NSArray *classlist = resultdic[@"list"];
            
            NSString *room_string = resultdic[@"room_arr"];
            room_arr = [room_string componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
            NSLog(@"array:%@",room_arr); //结果是adfsfsfs和dfsdf
            
            
            [classlist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JigouModel *model = [[JigouModel alloc]initWithDataDic:obj];
                model.classid = obj[@"id"];
                [self.JGClasslistAry addObject:model];
            }];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}




//监听下拉的点击时间
- (void)time:(UIButton *)button{
    
    if (button.tag==125) {
        _type=1;
    }else{
        _type=2;
    }
    
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
    self.datePicker. datePickerMode = UIDatePickerModeTime ;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
//    NSDate *maxdate = [dateFormatter dateFromString:self.search_timeDic[@"end_time"]];
//    NSDate *mindate = [dateFormatter dateFromString:self.search_timeDic[@"begin_time"]];
//    self.datePicker.maximumDate = maxdate;
//    self.datePicker.minimumDate = mindate;
    
    
    
    
    // 显示中文
     self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
//    self.datePicker. locale = [ NSLocale localeWithLocaleIdentifier : @"zh" ];
    
    
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
    formatter. dateFormat = @"HH:mm" ;
    
    
    if (_type==1) {
        UIButton *endtime = [_ScrollView viewWithTag:125];
         [endtime setTitle:[formatter stringFromDate:_date] forState:UIControlStateNormal];
        [endtime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        UIButton *starttime = [_ScrollView viewWithTag:126];
         [starttime setTitle:[formatter stringFromDate:_date] forState:UIControlStateNormal];
        [starttime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
   

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
