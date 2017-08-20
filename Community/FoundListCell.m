//
//  FoundListCell.m
//  Community
//
//  Created by 刘翔 on 16/3/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FoundListCell.h"

@implementation FoundListCell

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JiGouModel *)model
{
    _model = model;
    [self.photoImgview sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.title.text = _model.title;
    self.adress.text = _model.address;
    if (_model.distance.length == 0) {
        
        self.juli.text = _model.distance;
        self.locationImage.hidden = YES;

    }else{
    
        self.juli.text = _model.distance;
        self.locationImage.hidden = NO;

    }
    if ([_model.is_join integerValue] == 0) {
        //未加入
        [self.stausimg setImage:[UIImage imageNamed:@""]
         ];
    }else{
    //加入
        
        [self.stausimg setImage:[UIImage imageNamed:@"发现－已加入"]
         ];
    
    }

}

@end
