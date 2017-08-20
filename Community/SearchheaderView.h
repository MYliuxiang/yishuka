//
//  SearchheaderView.h
//  PaiMai
//
//  Created by Viatom on 16/3/1.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchheaderView : UIView

@property (nonatomic,copy)  void (^clik)(int tag);

@property (weak, nonatomic) IBOutlet UIButton *fisrstBtn;
@property (weak, nonatomic) IBOutlet UIButton *scendBtn;
- (IBAction)buttonAC2:(id)sender;


- (IBAction)buttonAC1:(id)sender;

@property (nonatomic,copy) NSString *text1;
@property (nonatomic,copy) NSString *text2;

+ (instancetype)viewFromNIB;

@end
