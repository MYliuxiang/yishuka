//
//  PrivateCell.h
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"
@interface PrivateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lineimageView;
@property (nonatomic,retain) NoteModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *redimg;

@end
