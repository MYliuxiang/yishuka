//
//  MapSearchView.h
//  Community
//
//  Created by Viatom on 16/6/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapSearchView : UIView
@property (nonatomic,copy)  void (^clik)(int tag);
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *scendBtn;

@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
- (IBAction)oneAC:(id)sender;
- (IBAction)threeAC:(id)sender;
- (IBAction)twoAC:(id)sender;

@property (nonatomic,copy) NSString *text1;
@property (nonatomic,copy) NSString *text2;
@property (nonatomic,copy) NSString *text3;


+ (instancetype)viewFromNIB;

@end





