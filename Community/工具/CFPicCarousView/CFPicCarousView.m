//
//  CFHotTableViewHeaderView.m
//  LiteratureOnLine
//
//  Created by TheMoon on 16/1/18.
//  Copyright (c) 2016年 CFJ. All rights reserved.
//

#import "CFPicCarousView.h"
#import "CFPicModel.h"
// #import "UIImageView+WebCache.h"


static NSInteger currentIndex;
static NSInteger preIndex;
static NSInteger nextIndex;

static CGFloat oneWidth = 0.0;
@interface CFPicCarousView ()<UIScrollViewDelegate>
{
    UIImageView *imaGv;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation CFPicCarousView

- (void)startTimer{
    // 移除原来的
    [self removeTimer];
    // 开启新的
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(doWithTimer) userInfo:nil repeats:YES];
}

- (void)removeTimer{
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CFPicCarousView" owner:self options:nil].lastObject;
        self.frame = frame;
        oneWidth = frame.size.width;
        [self doWithCreateUIWithSize:frame.size];
        
        self.pageControl.frame = CGRectMake(0, self.height - 20, kScreenWidth, 20);
        
        imaGv = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - 42) / 2.0, (self.height - 42) / 2.0, 42, 42)];
        imaGv.image = [UIImage imageNamed:@"视频－播放按钮"];
        imaGv.hidden = YES;
        [self addSubview:imaGv];
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.frame = CGRectMake(0, self.height - 20, kScreenWidth, 20);
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (void)setTypeArray:(NSArray *)typeArray
{
    _typeArray = typeArray;
    if ([_typeArray[0] integerValue] == 1) {
        imaGv.hidden = NO;
    } else {
         imaGv.hidden = YES;
    }

}

- (void)doWithCreateUIWithSize:(CGSize)size{
    //self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(3 * size.width, size.height);
    
    self.scrollView.delegate = self;
    
    self.preImgView.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    self.currentImgView.frame = CGRectMake(size.width, 0.0, size.width, size.height);
    self.nextImgView.frame = CGRectMake(2 * size.width, 0.0, size.width, size.height);
    // 偏移量一直在currentView的位置
    self.scrollView.contentOffset = CGPointMake(size.width, 0.0);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewWithFocusImg:)];
    [self.currentImgView addGestureRecognizer:tapGesture];
}


- (void)setPicModels:(NSMutableArray *)picModels{
    _picModels = picModels;
    [self doWithInitData];
}

#pragma mark - 初始值
- (void)doWithInitData{
    if (!self.picModels.count) {
        return;
    }
    currentIndex = 0;
    
    self.pageControl.numberOfPages = self.picModels.count;
    // 设置图片
    [self doWithImgView];
    
    // 启动计时器
    if (!self.timer) {
        [self startTimer];
    }
}

#pragma mark - 设置图片
- (void)doWithImgView{
    preIndex = (currentIndex - 1 + self.picModels.count) % self.picModels.count ;
    nextIndex = (currentIndex + 1 + self.picModels.count) % self.picModels.count;
    
    if (!self.isNetPic) {
        self.preImgView.image = [UIImage imageNamed:[self.picModels[preIndex]picName]];
        self.currentImgView.image = [UIImage imageNamed:[self.picModels[currentIndex]picName]];
        self.nextImgView.image = [UIImage imageNamed:[self.picModels[nextIndex]picName]];
    }else{
         // 网络请求
        [self.preImgView sd_setImageWithURL:[NSURL URLWithString:self.picModels[preIndex]] placeholderImage:[UIImage imageNamed:@""]];
        [self.currentImgView sd_setImageWithURL:[NSURL URLWithString:self.picModels[currentIndex]] placeholderImage:[UIImage imageNamed:@""]];
        [self.nextImgView sd_setImageWithURL:[NSURL URLWithString:self.picModels[nextIndex]] placeholderImage:[UIImage imageNamed:@""]];
    }
}


#pragma mark - 计时器处理
- (void)doWithTimer{
   
    currentIndex = (currentIndex + 1 + self.picModels.count) % self.picModels.count;
  
    // 设置图片
    [self doWithImgView];
    
    if(self.picModels.count > 1){
        // 设置动画
         [self addAnimationView:self.currentImgView WithType:@"rippleEffect" subType:kCATransitionFromLeft duration:0.5];
    }
    
    self.scrollView.contentOffset = CGPointMake(oneWidth, 0);
    self.pageControl.currentPage = currentIndex;
}


#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 开始拖拽，移除计时器
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offX = self.scrollView.contentOffset.x;
    
   
   
    
    // 偏移了
    if (offX  > oneWidth ) {
        // 向左滚动
        currentIndex = (currentIndex + 1 + self.picModels.count) % self.picModels.count;
    }else if(offX  < oneWidth){
        // 往右
        currentIndex = (currentIndex - 1 + self.picModels.count) % self.picModels.count;
    }
    
    NSString *type  = _typeArray[currentIndex];
    if ([type integerValue] == 1) {
        imaGv.hidden = NO;
    } else {
        imaGv.hidden = YES;
    }
    
    // 设置图片
    [self doWithImgView];
    
    self.scrollView.contentOffset = CGPointMake(oneWidth, 0);
    self.pageControl.currentPage = currentIndex;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    // 拖拽结束，重启timer
    [self startTimer];
}

#pragma mark - pageControl事件处理
- (IBAction)pageControlValueChangedAction:(UIPageControl *)sender {
    [self.timer invalidate];
    self.timer = nil;
    
    currentIndex = sender.currentPage;
    
    // 设置图片
    [self doWithImgView];
    
    // 重新启动
    [self startTimer];
}

- (void)tapImageViewWithFocusImg:(UITapGestureRecognizer *)gesture{
    if (self.myTapCurrentImgBlock) {
        self.myTapCurrentImgBlock(currentIndex);
    }
}



#pragma mark - 过渡动画
- (void)addAnimationView:(UIView *)view WithType:(NSString *)type subType:(NSString *)subType duration:(CGFloat)duration{
    
    CATransition *transition = [CATransition animation];
    transition.subtype = subType;
    transition.type = type;
    transition.duration = duration;
    [view.layer addAnimation:transition forKey:@"layerAnimation"];
}

- (void)removeAnimationView:(UIView *)view{
    [view.layer removeAnimationForKey:@"layerAnimation"];
}

@end
