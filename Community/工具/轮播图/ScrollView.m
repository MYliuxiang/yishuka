//
//  ScrollView.m
//  LunBoTuDemo
//
//  Created by 邱云翔 on 15/12/27.
//  Copyright © 2015年 old Driver. All rights reserved.
//

#import "ScrollView.h"
#import "UIImageView+WebCache.h"

@interface ScrollView ()<UIScrollViewDelegate>

{
    NSUInteger currentIndex;
}
@property (nonatomic,strong) UIImageView *currentView;
@property (nonatomic,strong) UIImageView *leftView;
@property (nonatomic,strong) UIImageView *rightView;

@end
@implementation ScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        currentIndex = 0;
        [self ViewShouldBeginScroll];
        self.scroll.delegate = self;
    }
    return self;
}


- (NSTimer *)timer {
    if (!_timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(ViewShouldBeginScroll) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (UIScrollView *)scroll {
    if (!_scroll) {
        self.scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scroll.pagingEnabled = YES;
        _scroll.bounces = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.delegate = self;
        [_scroll setContentOffset:CGPointMake(0, 0)];
        _scroll.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
        [self addSubview:_scroll];
    }
    return _scroll;
}

- (UIPageControl *)pageVC {
    if (!_pageVC) {
        self.pageVC = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, self.frame.size.height - 30, 100, 20)];
//        _pageVC.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 20) ;
        _pageVC.pageIndicatorTintColor = [UIColor whiteColor];
        _pageVC.currentPageIndicatorTintColor = Color_nav;
        _pageVC.numberOfPages = self.imageDataArr.count;
        [self addSubview:_pageVC];
    }
    return _pageVC;
}

- (UIImageView *)currentView {
    if (!_currentView) {
        self.currentView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _currentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tellDelegateShouldAction:)];
        [_currentView addGestureRecognizer:tap];
        [self.scroll addSubview:_currentView];
        
//        
//        UIImageView *play = [[UIImageView alloc] initWithFrame:CGRectMake((self.currentView.width-50)/2.0,(self.currentView.height-50)/2.0, 50, 50)];
//        play.backgroundColor = [UIColor yellowColor];
//        [self.currentView addSubview:play];
        
    }
    return _currentView;
}

- (UIImageView *)leftView {
    if (!_leftView) {
        self.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.scroll addSubview:_leftView];
        
    }
    
    return _leftView;
}

- (UIImageView *)rightView {
    if (!_rightView) {
        self.rightView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
        [self.scroll addSubview:_rightView];
        
//        
//        UIImageView *play = [[UIImageView alloc] initWithFrame:CGRectMake((self.rightView.width-50)/2.0,(self.rightView.height-50)/2.0, 50, 50)];
//        play.backgroundColor = [UIColor redColor];
//        [self.rightView addSubview:play];
    }
    return _rightView;
}

//这个方法必须触发
- (void)ViewShouldBeginScroll {
    [UIView animateWithDuration:0.4 animations:^{
        [self.scroll setContentOffset:CGPointMake(self.scroll.contentOffset.x + self.frame.size.width, 0) animated:NO];
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scroll];
    }];
}


#pragma -mark - UIScrollViewDelegate -

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.imageDataArr) {
        return;
    }
    if (0 == self.scroll.contentOffset.x) {
        currentIndex --;
    } else if (self.frame.size.width * 2 == self.scroll.contentOffset.x) {
        currentIndex ++;
    }
    NSInteger leftIndex,rightIndex;
    
    if (currentIndex == -1 ) {
        currentIndex = self.imageDataArr.count - 1;
    };
    
    if (currentIndex == self.imageDataArr.count) {
        currentIndex = 0;
    }
    
    rightIndex = currentIndex + 1;
    leftIndex = currentIndex - 1;
    if (rightIndex == self.imageDataArr.count) {
        rightIndex = 0;
    };
    if (leftIndex == -1) {
        leftIndex = self.imageDataArr.count - 1;
    };
    
    [self setUpValueForImageViewWith:leftIndex rightIndex:rightIndex];
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}

//子类重写适应model
- (void)setUpValueForImageViewWith:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    NSDictionary *leftDic = self.imageDataArr[leftIndex];
    NSDictionary *Dic = self.imageDataArr[leftIndex];
    NSDictionary *rightDic = self.imageDataArr[leftIndex];
    
    [self.leftView sd_setImageWithURL:[NSURL URLWithString:leftDic[@"url"]]];
    [self.currentView sd_setImageWithURL:[NSURL URLWithString:Dic[@"url"]]];
    [self.rightView sd_setImageWithURL:[NSURL URLWithString:rightDic[@"url"]]];
    self.pageVC.currentPage = currentIndex;
    
    BOOL _isbool;
    if ([Dic[@"type"] integerValue] == 1) {
        _isbool = NO;
    } else {
        _isbool = YES;
    
    }
    
    UIImageView *play = [[UIImageView alloc] initWithFrame:CGRectMake((self.leftView.width-50)/2.0,(self.leftView.height-50)/2.0, 50, 50)];
    play.hidden = _isbool;
    play.image = [UIImage imageNamed:@"回课记－播放"];
    [self addSubview:play];

}

- (void)replaceCurrentDataArrayWithArray:(NSArray *)array {
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
    self.imageDataArr = array;
    self.leftView.image = nil;
    self.currentView.image = nil;
    self.rightView.image = nil;
    if (_timer) {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

#pragma - mark - SelfDelegate -
- (void)tellDelegateShouldAction:(UITapGestureRecognizer *)tap {
    //获得此时下标
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapImageView:)]) {
        
//        NSDictionary *Dic = self.imageDataArr[currentIndex];
//        NSLog(@" == %@",Dic[@"type"]);
        
        [self.delegate tapImageView:currentIndex];
    }
}



@end
