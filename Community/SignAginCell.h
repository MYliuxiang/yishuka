//
//  SignAginCell.h
//  Community
//
//  Created by 刘翔 on 16/5/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignModel.h"
@interface SignAginCell : UITableViewCell<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (nonatomic,retain) SignModel *model;
@property (nonatomic,copy) NSString *status;
- (IBAction)btnAC1:(UIButton *)sender;
- (IBAction)btnAC2:(UIButton *)sender;
- (IBAction)btnAC3:(UIButton *)sender;

- (IBAction)callPhone:(UIButton *)sender;
@end
