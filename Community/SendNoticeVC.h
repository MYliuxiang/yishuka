//
//  SendNoticeVC.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "ClassModel.h"

@interface SendNoticeVC : BaseViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)buttonAC:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,retain)ClassModel *model;

@end
