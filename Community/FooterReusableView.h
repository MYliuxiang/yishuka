//
//  FooterReusableView.h
//  Community
//
//  Created by 刘翔 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterReusableView : UICollectionReusableView
@property (nonatomic,copy) void (^clickBlock)(int i);
- (IBAction)buttonAction:(id)sender;

@end
