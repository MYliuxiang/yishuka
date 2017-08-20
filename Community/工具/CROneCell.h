//
//  CROneCell.h
//  Community
//
//  Created by 刘翔 on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface CROneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (nonatomic,retain)CommentModel *model;
@end
