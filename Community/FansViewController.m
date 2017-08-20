//
//  FansViewController.m
//  Community
//
//  Created by 李立 on 16/3/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FansViewController.h"
#import "FansTableViewCell.h"
@interface FansViewController ()
{
    UIImageView *_bjview;

}
@end

@implementation FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.text = @"粉丝";
    [self _initView];
    
}

//初始化视图
-(void)_initView
{
    //创建表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth  , kScreenHeight ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _myTableView.bounces = NO;
    
    
    
    //尾视图
    _tableView.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
                footerbjView;
        
    });
    
    [self.view addSubview:_tableView];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    FansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FansTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        //线条
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 90 - .5, kScreenWidth, .5)];
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        [cell.contentView addSubview:lineview];
 
        
        }
   
    
    [cell initTouxiangImageView:@"001" NameLabel:@"苗秀秀" CategoryLabel:@"老师" BiaozhuLabel:@"器乐 钢琴" Isko:NO];
    
//    [cell initTouxiangImageView:@"001" NameLabel:@"李立立" CategoryLabel:@"学生" BiaozhuLabel:@"器乐 钢琴" Isko:YES];
    

    
    return cell;
}


//单元格点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    
    if ([UserDefaults boolForKey:ISLogin] == YES) {
        
        if (indexPath.row == 0 ) {
            
        }else if (indexPath.row == 1){
            NSLog(@"我的收藏");
           
        }else if (indexPath.row == 2)
        {
           
            
        }
        else if (indexPath.row == 3)
        {
            
        }else{
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"13718434501"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
        
    }else{
//        LognViewController *longnVC = [[LognViewController alloc]init];
//        [self presentViewController:longnVC animated:YES completion:nil];
        
        
    }
    
}


@end
