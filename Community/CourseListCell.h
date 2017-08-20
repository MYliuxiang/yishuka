//
//  CourseListCell.h
//  Community
//
//  Created by 刘翔 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
- (IBAction)buttonAC:(id)sender;

@end
