//
//  TopSctollView.m
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "TopSctollView.h"

#define BUTTONGAP 10
#define CONTENTSIZEX [[UIScreen mainScreen] bounds].size.width
#define POSITION (int)(scrollView.contentOffset.x/[[UIScreen mainScreen] bounds].size.width)

@implementation TopSctollView

@synthesize titleArray;
@synthesize userSelectedButtonTag;
@synthesize scrollViewSelectedID;
@synthesize buttonOrignXArray;
@synthesize buttonWithArray;


+ (TopSctollView *)getInstance{
    static TopSctollView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithFrame:CGRectMake(0, 0, CONTENTSIZEX, 30)];
    });
    return instance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        userSelectedButtonTag = 100;
        scrollViewSelectedID = 100;
        
        self.buttonOrignXArray = [[NSMutableArray alloc] init];
        self.buttonWithArray = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)initWithTitleButtons{
    
    float xPos = 0.0f;
    for(int i = 0; i < [self.titleArray count]; i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.titleArray objectAtIndex:i];
        [button setTag:i + 100];
        if(i == 0){
            button.selected = YES;
        }
        [button setImage:[UIImage imageNamed:@"v"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"上"] forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:Color_nav forState:UIControlStateHighlighted];
        [button setTitleColor:Color_nav forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        int buttonWidth = self.titleArray.count > 5 ? kScreenWidth / 5.0 : kScreenWidth /self.titleArray.count;
        button.frame = CGRectMake(xPos, 0, buttonWidth, 30);
        [buttonOrignXArray addObject:@(xPos)];
        //按钮的X坐标
        xPos += buttonWidth;
        //按钮的宽度
        [self.buttonWithArray addObject:@(button.frame.size.width)];

        float a = button.imageView.width;
        float b = button.titleLabel.width;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, b + a );
        button.imageEdgeInsets = UIEdgeInsetsMake(0,b + a, 0, 0);
        NSLog(@"%f%f",button.imageView.width,button.titleLabel.width);

        [self addSubview:button];
    }
    //视图的位移
    self.contentSize = CGSizeMake(xPos, 30);
   
}

- (void)selectNameButton:(UIButton *)sender{
    

    if (self.titleArray.count > 5) {
        [self adjustScrollViewContentX:sender];
    }
    
    //如果跟换按钮
    if(sender.tag != userSelectedButtonTag){
        UIButton *mybutton = (UIButton *)[self viewWithTag:userSelectedButtonTag];
        mybutton.selected = NO;
        userSelectedButtonTag = sender.tag;
    }
    //按钮选中状态
    if(!sender.selected){
        sender.selected = YES;
        [UIView animateWithDuration:0.25 animations:^{
            [shadowImage setFrame:CGRectMake(sender.frame.origin.x,
                                             0,
                                             [[self.buttonWithArray objectAtIndex:sender.tag - 100] floatValue],
                                             44)];
        } completion:^(BOOL finished) {
            if(finished){

                //滑动选择页面
                scrollViewSelectedID = sender.tag;
                
            }
        }];
    
    }
    
    self.clickBlock(userSelectedButtonTag - 100);
}

//调整滚动按钮显示
- (void)adjustScrollViewContentX:(UIButton *)sender{
    
    float originX = [[self.buttonOrignXArray objectAtIndex:(sender.tag - 100)] floatValue];
    float width = [[self.buttonWithArray objectAtIndex:(sender.tag - 100)] floatValue];
    

    if (originX + width / 2.0 > kScreenWidth / 2.0  && self.contentSize.width - originX > kScreenWidth / 2.0) {
            [self setContentOffset:CGPointMake(originX + width / 2.0 - kScreenWidth / 2.0 , 0) animated:YES];

        }
    if (originX + width / 2.0 <= kScreenWidth / 2.0) {
        [self setContentOffset:CGPointMake(0 , 0) animated:YES];
    }
    if (self.contentSize.width - originX <= kScreenWidth / 2.0) {
        
        [self setContentOffset:CGPointMake(self.contentSize.width - kScreenWidth , 0) animated:YES];

    }
    



   
    
}

- (void)setButttonUnSelect{
    UIButton *button = (UIButton *)[self viewWithTag:scrollViewSelectedID];
    button.selected = NO;
}

- (void)setButtonSelect{
    //选中滑动的按钮
    UIButton *button = (UIButton *)[self viewWithTag:scrollViewSelectedID];
    [UIView animateWithDuration:0.25 animations:^{
        [shadowImage setFrame:CGRectMake(button.frame.origin.x, 0,
                                         [[self.buttonWithArray objectAtIndex:button.tag - 100] floatValue],
                                         44)];
    } completion:^(BOOL finished) {
        if(finished){
            if(!button){
                button.selected = YES;
                userSelectedButtonTag = button.tag;
            }
        }
    }];
}

- (void)setScrollViewContentOffset{
    float originX = [[self.buttonOrignXArray objectAtIndex:(scrollViewSelectedID - 100)] floatValue];
    float width = [[self.buttonWithArray objectAtIndex:(scrollViewSelectedID - 100)] floatValue];
    
    if (originX + width / 2.0 > kScreenWidth / 2.0  && self.contentSize.width - originX > kScreenWidth / 2.0) {
        [self setContentOffset:CGPointMake(originX + width / 2.0 - kScreenWidth / 2.0 , 0) animated:YES];
        
    }
    if (originX + width / 2.0 <= kScreenWidth / 2.0) {
        [self setContentOffset:CGPointMake(0 , 0) animated:YES];
    }
    if (self.contentSize.width - originX <= kScreenWidth / 2.0) {
        
        [self setContentOffset:CGPointMake(self.contentSize.width - kScreenWidth , 0) animated:YES];
        
    }
}
@end
