//
//  ClassCell.h
//  Community
//
//  Created by lijiang on 16/4/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *teacherImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UILabel *connect;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIImageView *laba;

@end
