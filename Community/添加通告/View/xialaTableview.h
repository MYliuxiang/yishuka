//
//  xialaTableview.h
//  Community
//
//  Created by 未来社区 on 16/7/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiGouModel.h"

@protocol xialadelegate <NSObject>

- (void)JGmodel:(JigouModel *)model type:(NSInteger )type room:(NSString *)string;

@end
@interface xialaTableview : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataAry;
@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)id <xialadelegate> delegate;

- (void)dataAry:(NSArray *)dataAry type:(NSInteger)type;

@end
