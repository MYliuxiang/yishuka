//
//  AddressbookController.m
//  Community
//
//  Created by 李江 on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "AddressbookController.h"
#import "friendsCell.h"
#import "friendteacherCell.h"
#import "ClassTeamCell.h"
#import "ClassCell.h"

@interface AddressbookController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic ,strong)NSMutableArray *dataAry;
@property(nonatomic ,assign)NSInteger type;


@end

@implementation AddressbookController{

    NSString *_identfy;
    NSString *_identfy2;
    NSString *_identify3;
    NSString *_identify4;
    UIImageView *_img;
    UIView *headerview;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text = @"通讯录";
    [self _InitViews];
    self.type =1;
    
}

- (void)_InitViews{
    
    UIView *bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 64,kScreenWidth,35*ratioHeight)];
    bjview.backgroundColor = Color(245, 182,11);
    [self.view addSubview:bjview];
    
    UIButton *group = [[UIButton alloc]initWithFrame:CGRectMake(0,0,kScreenWidth/2.0, 35*ratioHeight)];
    [group setTitle:@"群组" forState:UIControlStateNormal];
    [group setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    group.titleLabel.font = [UIFont systemFontOfSize:15];
    [group addTarget:self action:@selector(grapAction) forControlEvents:UIControlEventTouchUpInside];
    [bjview addSubview:group];
    
    
    
    UIButton *friends = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2.0,0,kScreenWidth/2.0, 35*ratioHeight)];
    [friends setTitle:@"好友" forState:UIControlStateNormal];
    friends.titleLabel.font = [UIFont systemFontOfSize:15];
    [friends addTarget:self action:@selector(friends) forControlEvents:UIControlEventTouchUpInside];
    [bjview addSubview:friends];
    
    
    //创建
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,bjview.bottom, kScreenWidth,kScreenHeight-64-group.height) style:UITableViewStyleGrouped];
    self.tableview.delegate =self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    
    headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50*ratioHeight)];
    _tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    
    //搜索框
    UISearchBar *mysearchB = [[UISearchBar alloc]initWithFrame:headerview.frame];
    mysearchB.delegate = self;
    mysearchB.backgroundColor = [UIColor clearColor];
    
    [[[[mysearchB.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    [mysearchB setBackgroundColor:[UIColor whiteColor]];
    

    
    //设置键盘类型
    mysearchB.barStyle =  UIBarStyleBlackOpaque;
    mysearchB.keyboardType = UIKeyboardAppearanceDefault;
    mysearchB.placeholder = @"Search....";
    [headerview addSubview:mysearchB];
    
    
    
    _img = [[UIImageView alloc]initWithFrame:CGRectMake((group.width-10*ratioWidth)/2.0,bjview.height-5*ratioHeight,10*ratioWidth, 5*ratioHeight)];
    _img.image = [UIImage imageNamed:@"三角形"];
    [bjview addSubview:_img];
    
    NSArray *data = @[@"1",@"2",@"1",@"2"];
    
    self.dataAry = [NSMutableArray new];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self.dataAry addObject:obj];
    }];
    
    
    
    
    _identfy = @"friendsCell";
    [self.tableview registerNib:[UINib nibWithNibName:@"friendsCell" bundle:nil] forCellReuseIdentifier:_identfy];
    
    _identfy2 = @"friendteacherCell";
    [self.tableview registerNib:[UINib nibWithNibName:@"friendteacherCell" bundle:nil] forCellReuseIdentifier:_identfy2];
    
    _identify3 = @"ClassTeamCell";
    [self.tableview registerNib:[UINib nibWithNibName:@"ClassTeamCell" bundle:nil] forCellReuseIdentifier:_identify3];
    
    _identify4 = @"ClassCell";
    [self.tableview registerNib:[UINib nibWithNibName:@"ClassCell" bundle:nil] forCellReuseIdentifier:_identify4];
    
    [_tableview reloadData];
    
}

- (void)grapAction{

    self.type = 1;
    _tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    [UIView animateWithDuration:0.25f animations:^{
        [_img setLeft:(kScreenWidth/2.0-10*ratioWidth)/2.0];
        
    } completion:nil];

    [_tableview reloadData];
    
}


- (void)friends{
    self.type =2;
    _tableview.tableHeaderView = headerview;
    [UIView animateWithDuration:0.25f animations:^{
        [_img setLeft:(kScreenWidth/2.0-10*ratioWidth)/2.0+kScreenWidth/2.0];
        
    } completion:nil];
    [_tableview reloadData];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    NSLog(@"1");
    
}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

     NSLog(@"2");
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

     NSLog(@"3");
}


#pragma mark ------tableview代理方法------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (_type == 1) {
        return self.dataAry.count;
    }
    return 5;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_type==1) {
        return 1;
    }
    
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (_type ==2) {
        NSString *idx = self.dataAry[indexPath.row];
        if ([idx integerValue]==1) {
            
            friendsCell *cell = [tableView dequeueReusableCellWithIdentifier:_identfy];
            if (cell==nil) {
                cell =(friendsCell *)[[[NSBundle mainBundle] loadNibNamed:@"friendteacherCell" owner:self options:nil]lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else if([idx integerValue]==2){
            
            friendteacherCell *cell = [tableView dequeueReusableCellWithIdentifier:_identfy2];
            if (cell==nil) {
                cell =(friendteacherCell *)[[[NSBundle mainBundle] loadNibNamed:@"friendteacherCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
    }else if (_type==1 ){
        NSString *idx = self.dataAry[indexPath.section];
        if ([idx integerValue]==1) {
            
            ClassTeamCell *cell = [_tableview dequeueReusableCellWithIdentifier:_identify3];
            if (cell==nil) {
                cell = (ClassTeamCell *)[[[NSBundle mainBundle]loadNibNamed:@"ClassTeamCell" owner:nil options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if ([idx integerValue]==2){
            
            ClassCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify4];
            if (cell==nil) {
                cell = (ClassCell*)[[[NSBundle mainBundle]loadNibNamed:@"ClassCell" owner:nil options:nil] lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    

    return nil;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type==1) {
         NSString *idx = self.dataAry[indexPath.section];
        if ([idx integerValue]==2) {
            return 120;
        }
    }
    
    return 70;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_type==1) {
        if (section==0) {
            return 0.1;
        }
        
        return 5;
    }

    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (_type==2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 20)];
        
        UILabel *viewlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-10,20)];
        viewlabel.font = [UIFont systemFontOfSize:17*ratioHeight];
        viewlabel.textColor = [UIColor blackColor];
        viewlabel.text = @"A";
        [view addSubview:viewlabel];
        
        return view;
    }

    return nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
