//
//  SendletterVC.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "SModel.h"
@interface SendletterVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)buttonAC:(id)sender;
@property (nonatomic,retain)SModel *model;
@property (nonatomic,copy)NSString *headimgurl;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *sid;

@end
