//
//  JiaoshiCell.h
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherModel.h"
#import "MLLabel.h"
#import "MLLinkLabel.h"
#import "KClassVC.h"

@interface JiaoshiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet MLLinkLabel *connentLabel;



@property(nonatomic,retain) TeacherModel *model;
@end
