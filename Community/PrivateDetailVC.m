//
//  PrivateDetailVC.m
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "PrivateDetailVC.h"
#import "PtivateReplyVC.h"

@interface PrivateDetailVC ()<UITextViewDelegate>

@end

@implementation PrivateDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"私信详情";
    self.ISFANHUI = YES;
    self.detelted.layer.borderWidth = .5;
    self.detelted.layer.borderColor = [UIColor grayColor].CGColor;
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 45 - 15, 20 + (self.nav.height - 20 - 50 / 2.0) / 2.0 , 45, 60 / 2.0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"删除" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(rightAC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    if ([self.model.is_class integerValue] == 1) {
        self.headImagView.image = [UIImage imageNamed:@"班级头像"];
    } else {
        [self.headImagView sd_setImageWithURL:[NSURL URLWithString:self.model.headimgurl]];
    }

    
    self.contentLabel.text = self.model.content;
    self.timeLabel.text = self.model.addtime;
    self.namelabel.text = self.model.nickname;
    self.textView.delegate = self;

}

-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length == 0) {
        self.plaLabel.text = @"请输入";
    }else{
        self.plaLabel.text = @"";
    }
    
}


//删除
- (void)rightAC
{
    
    [WXDataService requestAFWithURL:URL_myNoteDel params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":self.model.nid} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                [MBProgressHUD showError:@"成功删除" toView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
    }];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)hufuAction:(id)sender {
    NSLog(@"回复");

    
    if (self.textView.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入回复消息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
     
    
    [WXDataService requestAFWithURL:URL_noteSub params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"re_member_id":self.model.member_id,@"description":self.textView.text} httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
                    
            if ([[result objectForKey:@"status"] integerValue] == 0) {
               
                [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:1];            }
        
        
                if ([[result objectForKey:@"status"] integerValue] == 1) {
                    
                    [MBProgressHUD showError:result[@"msg"] toView:self.view];
                    
                }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];
        
    
}

@end











