//
//  SignAginCell.m
//  Community
//
//  Created by 刘翔 on 16/5/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SignAginCell.h"

@implementation SignAginCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
    self.headerBtn.layer.masksToBounds = YES;
    self.headerBtn.layer.cornerRadius = 25;
//  self.btn1.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,self.btn1.titleLabel.bounds.size.width);
//  self.btn1.titleEdgeInsets = UIEdgeInsetsMake(71, -self.btn1.titleLabel.bounds.size.width-50, 0, 0);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}


- (void)setModel:(SignModel *)model
{
    _model = model;
    [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:_model.headimgurl] forState:UIControlStateNormal];
    self.nameLabel.text = _model.name;
    self.phoneLabel.text = _model.mobilePhone;
    
    
    if ([_model.status intValue] == 0) {
        //未签
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
        
        
    }else if ([_model.status intValue] == 1){
    //已到
        self.btn1.selected = YES;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
        
    }else if([_model.status intValue] == 2){
    //请假
        self.btn1.selected = NO;
        self.btn2.selected = YES;
        self.btn3.selected = NO;
    
    }else{
    //缺席
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = YES;
    
    }

}


- (IBAction)btnAC1:(UIButton *)sender {
    
    if ([self.status intValue] == 1 ) {
        //已结束
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该通告已经结束。不能签到" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if ([self.status intValue] == 2){
    //未上课
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该通告还没上课。不能签到" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    
    }else if(sender.selected == YES){
        
        return;
    }else{
        
        
        [WXDataService requestAFWithURL:URL_infoClassSign params:@{@"id":self.model.sid,@"status":@"1"} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                sender.selected = !sender.selected;
                self.btn2.selected = NO;
                self.btn3.selected = NO;
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
            }
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
            
            [MBProgressHUD showError:@"网络连接失败！" toView:[UIApplication sharedApplication].keyWindow];
            
            
        }];

        
        
    
  
        
    }

}

- (IBAction)btnAC2:(UIButton *)sender {
    
    
    if ([self.status intValue] == 1 ) {
        //已结束
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该通告已经结束。不能签到" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if ([self.status intValue] == 2){
        //未上课
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该通告还没上课。不能签到" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if(sender.selected == YES){
    
        return;
    }else{

        
        [WXDataService requestAFWithURL:URL_infoClassSign params:@{@"id":self.model.sid,@"status":@"2"} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
            
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                sender.selected = !sender.selected;
                self.btn1.selected = NO;
                self.btn3.selected = NO;
                
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
            }
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
            
            [MBProgressHUD showError:@"网络连接失败！" toView:[UIApplication sharedApplication].keyWindow];
            
            
        }];

 
    }

}

- (IBAction)btnAC3:(UIButton *)sender {
    
    if ([self.status intValue] == 1 ) {
        //已结束
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该通告已经结束。不能签到" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if ([self.status intValue] == 2){
        //未上课
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该通告还没上课。不能签到" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if(sender.selected == YES){
        
        return;
    }else{

        [WXDataService requestAFWithURL:URL_infoClassSign params:@{@"id":self.model.sid,@"status":@"3"} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                sender.selected = !sender.selected;
                self.btn2.selected = NO;
                self.btn1.selected = NO;
                
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
            }
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
            
            [MBProgressHUD showError:@"网络连接失败！" toView:[UIApplication sharedApplication].keyWindow];
            
            
        }];
  
    }
    
}

- (IBAction)callPhone:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打电话" message:self.model.mobilePhone delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    
}

#pragma mark UIAlertView Delegate---------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        NSString *str = [NSString stringWithFormat:@"tel:%@",self.model.mobilePhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}

@end
