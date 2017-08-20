//
//  ModifyPssWordVC.h
//  Community
//
//  Created by Viatom on 16/8/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyPssWordVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (weak, nonatomic) IBOutlet UITextField *text3;
@property (weak, nonatomic) IBOutlet UIButton *donBtn;
- (IBAction)doneAC:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *text1;
@end
