//
//  BulletinboardHeader.m
//  Community
//
//  Created by 刘翔 on 16/3/24.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BulletinboardHeader.h"
#import "BbheaderCell.h"

@implementation BulletinboardHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
//        [self date];
    }
    return self;
}

- (void)date
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:now];
    // 得到星期几
    // 1(星期天) 2(星期1) 3(星期2) 4(星期3) 5(星期4) 6(星期5) 7(星期6)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    self.firstDate = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    self.lastDate = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年MM月dd日"];
    
    NSDateFormatter *formater1 = [[NSDateFormatter alloc] init];
    [formater1 setDateFormat:@"MM月dd日"];
    
    dateLabel.text = [NSString stringWithFormat:@"%@ - %@",[formater stringFromDate:self.firstDate],[formater1 stringFromDate:self.lastDate]];
    
    self.dateArray = [NSMutableArray new];
    for (int i = 0; i < 7; i++) {
        
        NSDate *date = [NSDate dateWithDays:i afterDate:self.firstDate];
        
        [self.dateArray addObject:date];
        
    }
    [self.collection reloadData];
    
    for (int i = 0; i < self.dateArray.count; i++) {
        
        NSDate *date = self.dateArray[i];
        
        if ([date isToday]) {
            [_collection selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
    
}

- (void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
//    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
//    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *inputDate = [inputFormatter dateFromString:dateStr];
//    
//    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
//    [outputFormatter setLocale:[NSLocale currentLocale]];
//    [outputFormatter setDateFormat:@"yyyy年MM月"];
//    NSString *str= [outputFormatter stringFromDate:inputDate];
//    
//    dateLabel.text = [NSString stringWithFormat:@"%@",str];


}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    
    TimeModel *firstmodel = self.dataList.firstObject;
    TimeModel *lastmodel = self.dataList.lastObject;
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:lastmodel.time];
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月"];
    NSString *str= [outputFormatter stringFromDate:inputDate];
   
    dateLabel.text = [NSString stringWithFormat:@"%@",str];
  
    [_collection reloadData];

    if (self.seletedModel == nil) {
      
        for (int i = 0; i < _dataList.count; i ++) {
            TimeModel *model = self.dataList[i];
            if ([model.time isEqualToString:self.dateStr]) {
                self.seletedModel = model;
            }
        }
    }
  
    
    for (int i = 0; i < _dataList.count; i ++) {
        TimeModel *model = self.dataList[i];
        if ([model.time isEqualToString:self.seletedModel.time]) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            [_collection selectItemAtIndexPath:indexpath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
    }


}

- (void)_initViews
{
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    dateLabel.text = @"2015年10月12 - 10月14号";
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.backgroundColor = Color(254, 206, 72);
    [self addSubview:dateLabel];
    
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(30, 0, 20, 40);
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"通告牌－日程－左"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kScreenWidth - 50, 0, 20, 40);
    [rightButton setImage:[UIImage imageNamed:@"通告牌－日程－右"] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.itemSize = CGSizeMake(kScreenWidth / 7.0,60);
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //self.layout.headerReferenceSize = CGSizeMake(kScreenWidth , 50);
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 60) collectionViewLayout:self.layout];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_collection registerNib:[UINib nibWithNibName:@"BbheaderCell" bundle:nil] forCellWithReuseIdentifier:@"BbheaderCellID"];
    _collection.bounces = NO;
    _collection.pagingEnabled = YES;
    _collection.showsHorizontalScrollIndicator = NO;
    _collection.showsVerticalScrollIndicator = NO;
    _collection.backgroundColor = Color(254, 206, 72);
    _collection.allowsMultipleSelection = NO;
    [self addSubview:_collection];
    
    
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 110, 110, 105, 20)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.width - 25, 20)];
    label.text = @"回今天";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    [backView addSubview:label];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(backView.width - 20, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"右箭头"];
    [backView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [backView addGestureRecognizer:tap];
    self.clipsToBounds = YES;
    [self addSubview:backView];

    
    
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(kScreenWidth - 90, 110, 70, 20);
//    backBtn.backgroundColor = [UIColor redColor];
//    [backBtn setImage:[UIImage imageNamed:@"右箭头"] forState:UIControlStateNormal];
//    [backBtn setTitle:@"回今天" forState:UIControlStateNormal];
//    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
//    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);

//    [self addSubview:backBtn];


}

- (void)back
{
    
//    [self date];
    
//    for (int i = 0; i < self.dateArray.count; i++) {
//        
//        NSDate *date = self.dateArray[i];
//        
//        if ([date isToday]) {
//            [_collection selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//            self.clickBlock(YES);
//        }
//    }
//    

    [LXCachNetWorking postREquestCacheUrlStr:URL_infoList withDic:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"time":self.dateStr} success:^(id result) {
        NSLog(@"%@",result);
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSArray *timeList = result[@"result"][@"time_list"];
            NSMutableArray *marray = [NSMutableArray array];
            for (NSDictionary *subdic in timeList) {
                TimeModel *model = [[TimeModel alloc] initWithDataDic:subdic];
                if ([model.time isEqualToString:self.dateStr]) {
                    self.seletedModel = model;
                    _clickBlock(model);
                }
                [marray addObject:model];
              
            }
            
            self.dataList = marray;
            self.lastWeek = result[@"result"][@"lastWeek"];
            self.nextWeek = result[@"result"][@"nextWeek"];
            
            
        }
        
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络连接失败！" toView:[UIApplication sharedApplication].keyWindow];
    }netBlock:^(NSInteger netType) {
        NSLog(@"net%ld",netType);
    }];


}

- (void)rightAction
{
//    self.firstDate = [NSDate dateWithDays:7 afterDate:self.firstDate];
//    self.lastDate = [NSDate dateWithDays:7 afterDate:self.lastDate];
//    
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"yyyy年MM月dd日"];
//    
//    NSDateFormatter *formater1 = [[NSDateFormatter alloc] init];
//    [formater1 setDateFormat:@"MM月dd日"];
//    
//    dateLabel.text = [NSString stringWithFormat:@"%@ - %@",[formater stringFromDate:self.firstDate],[formater1 stringFromDate:self.lastDate]];
//    
//    self.dateArray = [NSMutableArray new];
//    for (int i = 0; i < 7; i++) {
//        
//        NSDate *date = [NSDate dateWithDays:i afterDate:self.firstDate];
//        [self.dateArray addObject:date];
//        
//    }
//    
//    [self.collection reloadData];
    
    [LXCachNetWorking postREquestCacheUrlStr:URL_infoList withDic:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"time":self.nextWeek} success:^(id result) {
        NSLog(@"%@",result);
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSArray *timeList = result[@"result"][@"time_list"];
            NSMutableArray *marray = [NSMutableArray array];
            for (NSDictionary *subdic in timeList) {
                TimeModel *model = [[TimeModel alloc] initWithDataDic:subdic];
                [marray addObject:model];
            }
          
            self.dataList = marray;
            self.lastWeek = result[@"result"][@"lastWeek"];
            self.nextWeek = result[@"result"][@"nextWeek"];
            
            
        }
        
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络连接失败！" toView:[UIApplication sharedApplication].keyWindow];
    }netBlock:^(NSInteger netType) {
        NSLog(@"net%ld",netType);
    }];

}

- (void)leftAction
{
    
//    self.lastDate = [NSDate dateWithDays:7 beforDate:self.lastDate];
//    self.firstDate = [NSDate dateWithDays:7 beforDate:self.firstDate];
//    
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"yyyy年MM月dd日"];
//    
//    NSDateFormatter *formater1 = [[NSDateFormatter alloc] init];
//    [formater1 setDateFormat:@"MM月dd日"];
//    
//    dateLabel.text = [NSString stringWithFormat:@"%@ - %@",[formater stringFromDate:self.firstDate],[formater1 stringFromDate:self.lastDate]];
//    
//    self.dateArray = [NSMutableArray new];
//    for (int i = 0; i < 7; i++) {
//        
//        NSDate *date = [NSDate dateWithDays:i afterDate:self.firstDate];
//        
//        [self.dateArray addObject:date];
//        
//    }
//    [self.collection reloadData];
    
    [LXCachNetWorking postREquestCacheUrlStr:URL_infoList withDic:@{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"time":self.lastWeek} success:^(id result) {
        NSLog(@"%@",result);
        
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSArray *timeList = result[@"result"][@"time_list"];
            NSMutableArray *marray = [NSMutableArray array];
            for (NSDictionary *subdic in timeList) {
                TimeModel *model = [[TimeModel alloc] initWithDataDic:subdic];
                [marray addObject:model];
            }
            
            self.dataList = marray;
            self.lastWeek = result[@"result"][@"lastWeek"];
            self.nextWeek = result[@"result"][@"nextWeek"];
            
            
        }
        
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"网络连接失败！" toView:[UIApplication sharedApplication].keyWindow];
    }netBlock:^(NSInteger netType) {
        NSLog(@"net%ld",netType);
    }];

}


#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    BbheaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BbheaderCellID" forIndexPath:indexPath];
    if (indexPath.row == 5 || indexPath.row == 6){
        
        cell.ISWeekEnd = YES;
        
    }else{
    
        cell.ISWeekEnd = NO;
    }
//    cell.date = self.dateArray[indexPath.row];
    TimeModel *model = self.dataList[indexPath.row];
    cell.model = model;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth / 7.0 - 30) / 2, 0, 30, 60)];
    view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.7];
    cell.selectedBackgroundView = view;
    cell.selectedBackgroundView.frame = CGRectMake((kScreenWidth / 7.0 - 30) / 2, 0, 30, 60);
    if ([self.dateStr isEqualToString:model.time]) {
        
        cell.IsToday = YES;
    
    }else{
    
        cell.IsToday = NO;
    }
    
    [cell setNeedsLayout];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    TimeModel *model = self.dataList[indexPath.row];
    self.seletedModel = model;
    self.clickBlock(model);

}

//日期转换
- (NSString *)dateStrWhithComementStr:(NSString *)dateStr
{
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:dateStr];

    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str= [outputFormatter stringFromDate:inputDate];
    return str;

}




@end
