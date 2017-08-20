//
//  PrivateDetailVC.h
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"
#import "NoteModel.h"

@interface PrivateDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (IBAction)hufuAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *detelted;
- (IBAction)deteltedAC:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *plaLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImagView;
@property (nonatomic,retain)NoteModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
