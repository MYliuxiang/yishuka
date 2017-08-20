//
//  BbheaderCell.m
//  Community
//
//  Created by 刘翔 on 16/3/24.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BbheaderCell.h"
#import "RCell.h"

@implementation BbheaderCell

- (void)awakeFromNib {
    
    self.IsTeacher = YES;
//    self.dates = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
   
    // Initialization code
    self.backgroundColor =  Color(254, 206, 72);
//    self.tishiLB.layer.cornerRadius = 3;
//    self.tishiLB.layer.masksToBounds = YES;
    self.countLabel.layer.cornerRadius = 7.5;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.backgroundColor = [UIColor whiteColor];
   
}


- (void)setDate:(NSDate *)date
{
    _date = date;
//    _dateLabel.text = dateStr;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:_date];
    
    // 得到几号
    NSInteger day = [comp day];
    NSString *str = [NSString stringWithFormat:@"%d",day];
    _dateLabel.text = str;

   
    
}

- (void)setIsToday:(BOOL)IsToday
{
    _IsToday = IsToday;
    if (_IsToday) {
        
        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.textColor = [UIColor whiteColor];
        
    }else{
        
        _countLabel.backgroundColor = [UIColor whiteColor];
        _countLabel.textColor = Color_nav;
        
    }

}

- (void)setModel:(TimeModel *)model
{
    _model = model;
    _dateLabel.text = [_model.time substringFromIndex:8];
    _countLabel.text = [NSString stringWithFormat:@"%d",[model.count intValue]];

}


- (void)setISWeekEnd:(BOOL)ISWeekEnd
{
    _ISWeekEnd = ISWeekEnd;
    if (_ISWeekEnd) {
        
        self.tishiLB.hidden = NO;
        
    }else{
    
        self.tishiLB.hidden = YES;
    }


}


@end
