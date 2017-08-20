//
//  StendsEndCell.h
//  Community
//
//  Created by 刘翔 on 16/6/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BulletiModel.h"

@interface StendsEndCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *palceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UIButton *huikeBtn;

- (IBAction)HuiKe:(UIButton *)sender;

@property (nonatomic,retain) BulletiModel *model;

@end
