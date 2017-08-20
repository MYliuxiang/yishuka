//
//  VideoCell.m
//  Community
//
//  Created by Viatom on 16/7/4.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CourseDModel *)model
{
    _model = model;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.videoImageView.contentMode = UIViewContentModeScaleToFill;


}
- (void)setImageName:(NSString *)imageName
{
    self.videoImageView.contentMode = UIViewContentModeCenter;
    _imageName = imageName;
    self.videoImageView.image = [UIImage imageNamed:imageName];

}

@end
