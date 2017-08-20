//
//  SendletterVC.m
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SendletterVC.h"

@interface SendletterVC ()

@end

@implementation SendletterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"发私信";
    self.ISFANHUI = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.headimgurl]];
    self.titleLabel.text = self.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length == 0) {
        self.label.text = @"填写公告内容";
    }else{
        self.label.text = @"";
    }
    
}



- (IBAction)buttonAC:(id)sender {
    
    
    if (self.textView.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入回复消息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSDictionary *dic = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"re_member_id":self.sid,@"description":self.textView.text};
    
    [WXDataService requestAFWithURL:URL_noteSub params:dic httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:1];
//            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];

}






@end
