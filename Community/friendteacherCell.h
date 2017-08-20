//
//  friendteacherCell.h
//  Community
//
//  Created by 李江 on 16/4/12.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface friendteacherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teacherImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UIButton *message;
@property (weak, nonatomic) IBOutlet UILabel *connect;
@end
