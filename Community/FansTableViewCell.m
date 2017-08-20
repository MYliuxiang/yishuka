//
//  FansTableViewCell.m
//  Community
//
//  Created by 李立 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FansTableViewCell.h"
#import "PrivateDetailVC.h"
@implementation FansTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //1.创建子视图
        [self initCell];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

//初始化cell
-(void)initCell
{
    
    //头像
    _touxiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50,  50)];
    _touxiangImageView.backgroundColor = [UIColor redColor];
    _touxiangImageView.layer.masksToBounds = YES;
    // 设置圆角角度
    
    _touxiangImageView.layer.cornerRadius = 50/2.0;
    
    // 圆角描边线的宽度
    _touxiangImageView.layer.borderWidth = 0;
    _touxiangImageView.userInteractionEnabled = YES;
    [self addSubview:_touxiangImageView];
    
    //名字
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_touxiangImageView.right+5, 20, 70, 20)];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.text = @"朱八戒";
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_nameLabel];
    
    //类别
    _categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15)];
    _categoryLabel.backgroundColor = [UIColor brownColor];
    _categoryLabel.text = @"学生";
    _categoryLabel.textColor = [UIColor whiteColor];
    _categoryLabel.font = [UIFont systemFontOfSize:12];
    _categoryLabel.layer.masksToBounds = YES;
    _categoryLabel.textAlignment = NSTextAlignmentCenter;
    // 设置圆角角度
    _categoryLabel.layer.cornerRadius = 6.0;
    // 圆角描边线的宽度
    _categoryLabel.layer.borderWidth = 0;
    [self addSubview:_categoryLabel];
    
    //标注
    _biaozhuLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+3, 200, 20)];
    _biaozhuLabel.textColor = [UIColor grayColor];
    _biaozhuLabel.textAlignment = NSTextAlignmentLeft;
    _biaozhuLabel.font = [UIFont systemFontOfSize:16];
    _biaozhuLabel.text = @"音乐 器乐 钢琴";
    [self addSubview:_biaozhuLabel];
    
    //对话按钮
    _dialogueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dialogueButton.frame = CGRectMake(kScreenWidth-120, _nameLabel.top+3, 46/2.0, 46/2.0);
//    _dialogueButton.backgroundColor = [UIColor greenColor];
    [_dialogueButton setImage:[UIImage imageNamed:@"通讯录－私信"] forState:UIControlStateNormal];
    [_dialogueButton addTarget:self action:@selector(dialogueButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dialogueButton];
    
    //关注按钮
    _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _followButton.frame = CGRectMake(kScreenWidth-70, _nameLabel.top, 60, 30);
//    _followButton.backgroundColor = [UIColor greenColor];
    _followButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_followButton setTitle:@"+关注" forState:UIControlStateNormal];
    [_followButton setTitleColor:[UIColor colorWithRed:0.9647 green:0.7569 blue:0.3608 alpha:1] forState:UIControlStateNormal];
    [_followButton addTarget:self action:@selector(followButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_followButton];
    
    
    
}

//对话按钮点击事件
-(void)dialogueButtonAction
{
    NSLog(@"对话");
    
    PrivateDetailVC *vc = [[PrivateDetailVC alloc] init];
    [[self ViewController].navigationController pushViewController:vc animated:YES];

}

-(void)followButtonAction:(UIButton *)btn
{
    NSLog(@"关注");
    if ([btn.titleLabel.text isEqualToString:@"取消关注"])
    {
      [btn setTitle:@"+关注" forState:UIControlStateNormal];
    
    } else {
    
        [btn setTitle:@"取消关注" forState:UIControlStateNormal];

    }
}

-(void)initTouxiangImageView:(NSString *)touxiangImageView NameLabel:(NSString *)nameLabel CategoryLabel:(NSString *)categoryLabel BiaozhuLabel:(NSString *)biaozhuLabel  FollowButton:(NSString *)followButton
{
    _touxiangImageView.image = [UIImage imageNamed:touxiangImageView];
    _nameLabel.text = nameLabel;
    _categoryLabel.text = categoryLabel;
    _biaozhuLabel.text = biaozhuLabel;
    [_followButton setTitle:followButton forState:UIControlStateNormal];
    
    if ([_categoryLabel.text isEqualToString:@"学生"]) {
        _categoryLabel.backgroundColor = [UIColor colorWithRed:0.6196 green:0.7961 blue:0.9294 alpha:1];
    }else if ([_categoryLabel.text isEqualToString:@"老师"]){
      _categoryLabel.backgroundColor = [UIColor colorWithRed:0.9294 green:0.8314 blue:0.5922 alpha:1];
    
    }
    
    if ([_biaozhuLabel.text isEqualToString:@""]) {
        if (_nameLabel.text.length == 2) {
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 30, 40, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
        }else{
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 30, 60, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
            
        }

    }else{
    
        if (_nameLabel.text.length == 2) {
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 20, 40, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
        }else{
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 20, 60, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
            
        }

    }
    
    
    if ([followButton isEqualToString:@"取消关注"]) {
         _followButton.frame = CGRectMake(kScreenWidth-80, _nameLabel.top, 60 * ratioWidth, 30);
         _dialogueButton.frame = CGRectMake(kScreenWidth-120, _nameLabel.top, 30, 30);

    }else{
        _followButton.frame = CGRectMake(kScreenWidth-60, _nameLabel.top, 40 * ratioWidth, 30);
        _dialogueButton.frame = CGRectMake(kScreenWidth-120, _nameLabel.top, 30, 30);

    }
    

}


-(void)initTouxiangImageView:(NSString *)touxiangImageView NameLabel:(NSString *)nameLabel CategoryLabel:(NSString *)categoryLabel BiaozhuLabel:(NSString *)biaozhuLabel Isko:(BOOL)isko
{
    _touxiangImageView.image = [UIImage imageNamed:touxiangImageView];
    _nameLabel.text = nameLabel;
    _categoryLabel.text = categoryLabel;
    _biaozhuLabel.text = biaozhuLabel;
    if ([_categoryLabel.text isEqualToString:@"学生"]) {
        _categoryLabel.backgroundColor = [UIColor colorWithRed:0.6196 green:0.7961 blue:0.9294 alpha:1];
    }else if ([_categoryLabel.text isEqualToString:@"老师"]){
        _categoryLabel.backgroundColor = [UIColor colorWithRed:0.9294 green:0.8314 blue:0.5922 alpha:1];
        
    }
    
    if ([_biaozhuLabel.text isEqualToString:@""]) {
        if (_nameLabel.text.length == 2) {
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 30, 40, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
        }else{
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 30, 60, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
            
        }
        
    }else{
        
        if (_nameLabel.text.length == 2) {
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 20, 40, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
        }else{
            _nameLabel.frame =CGRectMake(_touxiangImageView.right+5, 20, 60, 20);
            _categoryLabel.frame =CGRectMake(_nameLabel.right, _nameLabel.top+3, 50, 15);
            
            
        }
        
    }
    if (isko == YES) {
        _followButton.hidden = YES;
        _dialogueButton.frame = CGRectMake(kScreenWidth-60, _nameLabel.top, 40, 30);

    }
    

}
@end
