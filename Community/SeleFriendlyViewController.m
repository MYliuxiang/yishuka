//
//  SeleFriendlyViewController.m
//  Community
//
//  Created by 未来社区 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "SeleFriendlyViewController.h"
#import "friendsCell.h"
#import "friendteacherCell.h"


@interface SeleFriendlyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic ,strong)NSMutableArray *dataAry;
@property(nonatomic,strong)NSMutableDictionary *Seledic;

@end

@implementation SeleFriendlyViewController{
    NSString *_identfy;
    NSString *_identfy2;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text = @"选择好友";
    [self _InitViews];
    [self _initFooter];
    
    _Seledic = [NSMutableDictionary new];
}


- (void)_InitViews{
    //创建
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,64,kScreenWidth,kScreenHeight-64)];
    self.tableview.delegate =self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    
    _tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    
    
    NSArray *data = @[@"1",@"2",@"1",@"2"];
    
    self.dataAry = [NSMutableArray new];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataAry addObject:obj];
    }];
    
    
    
    
    _identfy = @"friendsCell";
    [self.tableview registerNib:[UINib nibWithNibName:@"friendsCell" bundle:nil] forCellReuseIdentifier:_identfy];
    
    _identfy2 = @"friendteacherCell";
    [self.tableview registerNib:[UINib nibWithNibName:@"friendteacherCell" bundle:nil] forCellReuseIdentifier:_identfy2];
}

- (void)_initFooter
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, kScreenWidth - 30, 35 * ratioHeight)];
    button1.layer.cornerRadius = 3;
    button1.layer.masksToBounds = YES;
    button1.backgroundColor = Color_nav;
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(tijiao:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
     self.tableview.tableFooterView = view;
    
}

- (void)tijiao:(UIButton *)sender
{
    
    
}


#pragma mark ------tableview代理方法------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *idx = self.dataAry[indexPath.row];
    if ([idx integerValue]==1) {
        
        friendsCell *cell = [tableView dequeueReusableCellWithIdentifier:_identfy];
        if (cell==nil) {
            cell =(friendsCell *)[[[NSBundle mainBundle] loadNibNamed:@"friendteacherCell" owner:self options:nil]lastObject];
        }
        
        [cell.message setImage:[UIImage imageNamed:@"选择－灰色"] forState:UIControlStateNormal];
        
         [cell.message setImage:[UIImage imageNamed:@"选择－黄色"] forState:UIControlStateSelected];
        
        [cell.message addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.message.tag= 1000+indexPath.row;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if([idx integerValue]==2){
        
        friendteacherCell *cell = [tableView dequeueReusableCellWithIdentifier:_identfy2];
        if (cell==nil) {
            cell =(friendteacherCell *)[[[NSBundle mainBundle] loadNibNamed:@"friendteacherCell" owner:self options:nil]lastObject];
        }
            [cell.message setImage:[UIImage imageNamed:@"选择－灰色"] forState:UIControlStateNormal];
        cell.message.tag= 10000+indexPath.row;
        
        [cell.message addTarget:self action:@selector(messageAction1:) forControlEvents:UIControlEventTouchUpInside];
        
            [cell.message setImage:[UIImage imageNamed:@"选择－黄色"] forState:UIControlStateSelected];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}


- (void)messageAction:(UIButton *)button{
    button.selected =! button.selected;
    NSString *index = [NSString stringWithFormat:@"%ld",button.tag-1000];
    if (button.selected) {
        [_Seledic setObject:index forKey:index];
    }else{
        [_Seledic removeObjectForKey:index];
    }
    
    NSLog(@"%@",_Seledic);
}

- (void)messageAction1:(UIButton *)button{
    button.selected =! button.selected;
    NSString *index = [NSString stringWithFormat:@"%ld",button.tag-10000];
    if (button.selected) {
        [_Seledic setObject:index forKey:index];
    }else{
        [_Seledic removeObjectForKey:index];
    }
    
     NSLog(@"%@",_Seledic);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
