//
//  CALayer+Boder.m
//  PaiMai
//
//  Created by Viatom on 16/2/29.
//  Copyright © 2016年 Viatom. All rights reserved.
//

#import "CALayer+Boder.h"

@implementation CALayer (Boder)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
