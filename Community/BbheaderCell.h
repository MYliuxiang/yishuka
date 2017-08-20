//
//  BbheaderCell.h
//  Community
//
//  Created by 刘翔 on 16/3/24.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAnnouncementVC.h"
#import "TimeModel.h"
@interface BbheaderCell : UICollectionViewCell
{
  
   
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tishiLB;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic,assign) BOOL IsToday;


@property (nonatomic,retain)   NSArray *classhours;
@property (nonnull,retain)   NSDate *date;
@property (nonatomic,assign)BOOL IsTeacher;
@property (nonatomic,assign) BOOL ISWeekEnd;
@property (nonatomic,retain) TimeModel *model;
@end
