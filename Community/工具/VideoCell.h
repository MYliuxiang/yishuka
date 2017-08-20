//
//  VideoCell.h
//  Community
//
//  Created by Viatom on 16/7/4.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDModel.h"
@interface VideoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (nonatomic,retain)CourseDModel *model;
@property (nonatomic,copy) NSString *imageName;

@end
