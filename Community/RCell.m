//
//  RCell.m
//  Community
//
//  Created by 刘翔 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "RCell.h"

@implementation RCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
}

- (void)_initViews
{
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(((kScreenWidth - 50) / 7 - 19 ) / 2.0, ((210 - 40) / 4 - 19) / 2.0, 19,19)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 9.5;
    label.layer.masksToBounds = YES;
    [self.contentView addSubview:label];

}


- (void)layoutSubviews
{

    if (self.index < 7) {
        label.backgroundColor = [UIColor clearColor];
        label.text = self.text;

        
    }else{
        
        
        if ([self.text isEqualToString:@"0"]) {
            if (self.IsTeacher) {
                
                label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"通告牌－加事件"]];
                label.text = @"";
            }else{
                label.backgroundColor = ColorRGB(252, 176, 46, 1);
                label.text = @"";
            }
            
        }else{
            
            label.text = self.text;
            label.backgroundColor = [UIColor redColor];
            
        }
        
    }


}




@end
