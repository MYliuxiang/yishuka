//
//  WorksCell.h
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorksCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumb;

@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *zhuti;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *note;
@property (weak, nonatomic) IBOutlet UILabel *chakan;
@property (weak, nonatomic) IBOutlet UILabel *pinglun;

@end
