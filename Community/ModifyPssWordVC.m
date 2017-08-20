//
//  ModifyPssWordVC.m
//  Community
//
//  Created by Viatom on 16/8/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "ModifyPssWordVC.h"

@interface ModifyPssWordVC ()

@end

@implementation ModifyPssWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"修改密码";
    self.donBtn.layer.masksToBounds = YES;
    self.donBtn.layer.cornerRadius = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doneAC:(id)sender {
    
    if (self.text1.text.length == 0) {
        
        [MBProgressHUD showError:@"原始密码" toView:self.view];

        return;
    }
    
    if (self.text2.text.length == 0) {
        
        [MBProgressHUD showError:@"请输入新密码" toView:self.view];
        
        return;
    }

    if (self.text3.text.length == 0) {
        
        [MBProgressHUD showError:@"请确定密码" toView:self.view];
        
        return;
    }

    if (![self.text2.text isEqualToString:self.text3.text]) {
        
        [MBProgressHUD showError:@"两次密码不相同" toView:self.view];
        return;
        
    }

    [WXDataService requestAFWithURL:URL_editMemberPassword params:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"password_old":self.text1.text,@"password_new":self.text2.text,@"password_confirm":self.text3.text} httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        NSLog(@"result:%@",result);
        
        if ([result[@"status"] intValue] == 0) {
            
            

    [self.navigationController popViewControllerAnimated:YES];
            
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
        }else{
            
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
        }
        
    } errorBlock:^(NSError *error) {
        
        [MBProgressHUD showError:@"修改失败" toView:self.view];

    }];

    
    
}
@end
