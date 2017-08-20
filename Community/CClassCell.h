//
//  CClassCell.h
//  Community
//
//  Created by 刘翔 on 16/6/28.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"

@interface CClassCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classLabel;

@property (weak, nonatomic) IBOutlet UIView *classImageView;

@property (weak, nonatomic) IBOutlet UILabel *peopleLable;
@property (weak, nonatomic) IBOutlet UILabel *techerLabel;
@property (weak, nonatomic) IBOutlet UIButton *gonggaoBtn;

@property (nonatomic,retain)ClassModel *model;

- (IBAction)buttonAC:(id)sender;
@end
