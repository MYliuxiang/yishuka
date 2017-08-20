//
//  SClasscell.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SModel.h"

@interface SClasscell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)buttonAC:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (nonatomic,retain)SModel *model;
@end
