//
//  SearchheaderView.m
//  PaiMai
//
//  Created by Viatom on 16/3/1.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "SearchheaderView.h"

@implementation SearchheaderView



+ (instancetype)viewFromNIB {
    // 加载xib中的视图，其中xib文件名和本类类名必须一致
    // 这个xib文件的File's Owner必须为空
    // 这个xib文件必须只拥有一个视图，并且该视图的class为本类
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return views[0];
}

- (void)awakeFromNib
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0, 0, 1, 40)];
    imageView.backgroundColor = Color_bg;
    [self addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, kScreenWidth, .5)];
    imageView1.backgroundColor = Color_bg;
    [self addSubview:imageView1];
   
    
}

- (void)tap1
{
    
    self.clik(1);
    
}

- (void)tap2
{
    
    NSLog(@"tap2");
    self.clik(2);

    
}

- (void)tap3
{
    NSLog(@"tap3");
    
    
}

- (void)setText1:(NSString *)text1
{
    _text1 = text1;
//    self.fisrstBtn.text = _text1;
    [self.fisrstBtn setTitle:text1 forState:UIControlStateNormal];
    self.fisrstBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.fisrstBtn.imageView.width, 0, self.fisrstBtn.imageView.width);
    self.fisrstBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.fisrstBtn.titleLabel.width, 0, -self.fisrstBtn.titleLabel.width);
}

- (void)setText2:(NSString *)text2
{
    _text2 = text2;
    [self.scendBtn setTitle:text2 forState:UIControlStateNormal];
    self.scendBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.scendBtn.imageView.width, 0, self.scendBtn.imageView.width);
    self.scendBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.scendBtn.titleLabel.width, 0, -self.scendBtn.titleLabel.width);

}






- (IBAction)buttonAC2:(id)sender {
    self.clik(2);
}
- (IBAction)buttonAC1:(id)sender {
    self.clik(1);
}
@end














