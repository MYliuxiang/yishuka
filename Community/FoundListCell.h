//
//  FoundListCell.h
//  Community
//
//  Created by 刘翔 on 16/3/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiGouModel.h"
@interface FoundListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImgview;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *juli;
@property (weak, nonatomic) IBOutlet UIImageView *stausimg;
@property (weak, nonatomic) IBOutlet UILabel *statuslabel;
@property (nonatomic,retain) JiGouModel *model;
@end
