//
//  ChangepassViewController.h
//  PaiMai
//
//  Created by 李立 on 16/2/29.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangepassViewController : BaseViewController<UITextFieldDelegate>
{
    CGPoint pointindex;

}
@property(nonatomic,copy)NSString *Yanzhengma;
@property(nonatomic,strong)UIButton *backButtton1;
@property(nonatomic,strong)UIScrollView *scrollView;
@end
