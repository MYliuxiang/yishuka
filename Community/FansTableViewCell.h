//
//  FansTableViewCell.h
//  Community
//
//  Created by 李立 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FansTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *touxiangImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *categoryLabel;
@property(nonatomic,strong)UILabel *biaozhuLabel;
@property(nonatomic,strong)UIButton *dialogueButton;
@property(nonatomic,strong)UIButton *followButton;

-(void)initTouxiangImageView:(NSString *)touxiangImageView NameLabel:(NSString *)nameLabel CategoryLabel:(NSString *)categoryLabel BiaozhuLabel:(NSString *)biaozhuLabel  FollowButton:(NSString *)followButton;

//好友
-(void)initTouxiangImageView:(NSString *)touxiangImageView NameLabel:(NSString *)nameLabel CategoryLabel:(NSString *)categoryLabel BiaozhuLabel:(NSString *)biaozhuLabel  Isko:(BOOL)isko;
@end
