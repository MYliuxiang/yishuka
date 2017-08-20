//
//  ClassromeCell.h
//  Community
//
//  Created by 刘翔 on 16/3/27.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KetangModel.h"
@interface ClassromeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (nonatomic, strong)UIImageView *imageView ;
@property (nonatomic, strong)UIView *yinyingView ;

@property (weak, nonatomic) IBOutlet UILabel *timelable;
@property(nonatomic,retain) KetangModel *model;
@end
