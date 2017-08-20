//
//  MapSearchView.m
//  Community
//
//  Created by Viatom on 16/6/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "MapSearchView.h"

@implementation MapSearchView

+ (instancetype)viewFromNIB {
    // 加载xib中的视图，其中xib文件名和本类类名必须一致
    // 这个xib文件的File's Owner必须为空
    // 这个xib文件必须只拥有一个视图，并且该视图的class为本类
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return views[0];
}

- (void)awakeFromNib
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 3.0, 0, 1, 40)];
    imageView.backgroundColor = Color_bg;
    [self addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 3.0*2, 0, 1, 40)];
    imageView2.backgroundColor = Color_bg;
    [self addSubview:imageView2];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, kScreenWidth, .5)];
    imageView1.backgroundColor = Color_bg;
    [self addSubview:imageView1];
    
    
}

- (void)setText1:(NSString *)text1
{
    _text1 = text1;
    //    self.fisrstBtn.text = _text1;
    [self.firstBtn setTitle:text1 forState:UIControlStateNormal];
    self.firstBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.firstBtn.imageView.width, 0, self.firstBtn.imageView.width);
    self.firstBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.firstBtn.titleLabel.width, 0, -self.firstBtn.titleLabel.width);
}

- (void)setText2:(NSString *)text2
{
    _text2 = text2;
    [self.scendBtn setTitle:text2 forState:UIControlStateNormal];
    self.scendBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.scendBtn.imageView.width, 0, self.scendBtn.imageView.width);
    self.scendBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.scendBtn.titleLabel.width, 0, -self.scendBtn.titleLabel.width);
    
}

- (void)setText3:(NSString *)text3
{
    _text3 = text3;
    //    self.fisrstBtn.text = _text1;
    [self.threeBtn setTitle:text3 forState:UIControlStateNormal];
    self.threeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.threeBtn.imageView.width, 0, self.threeBtn.imageView.width);
    self.threeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.threeBtn.titleLabel.width, 0, -self.threeBtn.titleLabel.width);
}




- (IBAction)oneAC:(id)sender {
    self.clik(1);

}

- (IBAction)threeAC:(id)sender {
    
    self.clik(3);

}

- (IBAction)twoAC:(id)sender {
    
    self.clik(2);

}
@end











