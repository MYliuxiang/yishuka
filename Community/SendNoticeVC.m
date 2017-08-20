//
//  SendNoticeVC.m
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SendNoticeVC.h"

@interface SendNoticeVC ()

@end

@implementation SendNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"发公告";
    self.ISFANHUI = YES;
    self.titleLabel.text = self.model.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)awakeFromNib
{
    self.btn.layer.cornerRadius = 2;
    self.btn.layer.masksToBounds = YES;

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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写公告" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    [WXDataService requestAFWithURL:URL_noticeSub params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"class_id":self.model.cid,@"description":self.textView.text} httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
                
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













