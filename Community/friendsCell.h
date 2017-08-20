//
//  friendsCell.h
//  Community
//
//  Created by 李江 on 16/4/12.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface friendsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Userimg;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UIButton *message;
@property (weak, nonatomic) IBOutlet UILabel *type;

@end
