//
//  ContactViewController.h
//  PaiMai
//
//  Created by 李立 on 16/5/7.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactViewController : BaseViewController<UITextViewDelegate>

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *lael1;

@end
