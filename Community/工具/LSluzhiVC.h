//
//  LSluzhiVC.h
//  Community
//
//  Created by 未来社区 on 16/7/8.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@protocol luzhidelegate <NSObject>
- (void)luzhiwancheng;
@end


@interface LSluzhiVC : BaseViewController



@property (weak, nonatomic) IBOutlet UIImageView *SpimgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *fabu_Button;
@property (strong, nonatomic)UILabel *miaoshu_label;
@property(nonatomic,strong)NSMutableArray *imgAry;
@property(nonatomic,strong)NSMutableArray *spAry;

@property(nonatomic,copy)NSString *hkid;
@property(nonatomic,copy)NSString *Class_id;
@property(nonatomic,copy)NSString *title;
@property (strong, nonatomic)UILabel *zishu;

@property(nonatomic,weak)id <luzhidelegate>delegate;

@end
