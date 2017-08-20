//
//  FooterReusableView.m
//  Community
//
//  Created by 刘翔 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FooterReusableView.h"

@implementation FooterReusableView

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)buttonAction:(id)sender {
    
    self.clickBlock(1);
}

@end
