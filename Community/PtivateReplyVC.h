//
//  PtivateReplyVC.h
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface PtivateReplyVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *sendLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
- (IBAction)sendAC:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)cancelAC:(id)sender;

@end
