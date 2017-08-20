//
//  FounddetailCell.h
//  Community
//
//  Created by lijiang on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FounddetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image_user;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;

@property (weak, nonatomic) IBOutlet UILabel *lab_content;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@end
