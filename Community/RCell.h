//
//  RCell.h
//  Community
//
//  Created by 刘翔 on 16/4/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCell : UICollectionViewCell
{
    UILabel *label;

}
@property (nonatomic,assign) int index;
@property (nonatomic,retain) NSArray *classhours;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign)BOOL IsTeacher;


@end
