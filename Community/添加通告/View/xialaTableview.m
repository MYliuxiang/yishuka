//
//  xialaTableview.m
//  Community
//
//  Created by 未来社区 on 16/7/9.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "xialaTableview.h"
#import "JiGouModel.h"
#import "ClassLIstModel.h"

@implementation xialaTableview
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.width, self.height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [self addSubview:_tableView];
    }
    return self;
}


- (void)dataAry:(NSArray *)dataAry type:(NSInteger)type{
    _dataAry= dataAry;
    _type =type;
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identify = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    if (_type==1 || _type==2) {
        JigouModel *model = _dataAry[indexPath.row];
        cell.textLabel.text = model.title;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode =NSLineBreakByWordWrapping;
    }else{
        NSString *room = _dataAry[indexPath.row];
        cell.textLabel.text = room;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode =NSLineBreakByWordWrapping;
    
    }
    


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_type==1) {
        JigouModel *model = _dataAry[indexPath.row];
        [self.delegate JGmodel:model type:1 room:nil];
    }else if (_type==2){
        JigouModel *model = _dataAry[indexPath.row];
        [self.delegate JGmodel:model type:2 room:nil];
        
    }else{
        JigouModel *model = _dataAry[indexPath.row];
        [self.delegate JGmodel:model type:3 room:_dataAry[indexPath.row]];
    }
    


    
}

@end
