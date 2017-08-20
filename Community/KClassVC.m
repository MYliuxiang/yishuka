//
//  KClassVC.m
//  Community
//
//  Created by Viatom on 16/7/6.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "KClassVC.h"
#import "texukechengDetailVC.h"

@interface KClassVC ()

@end

@implementation KClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [NSMutableArray array];
    self.ISFANHUI = YES;

     if (self.istc) {
         
    self.text = self.tmodel.name;
         
     }else{
         
         
         self.text = self.model.title;

     
     }
    [self _loadData];
    
}

- (void)_loadData
{
    
    if (self.istc) {
        
        
        NSDictionary *params;
        
        params = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"teacher_id":self.tmodel.tid};
        
        [WXDataService requestAFWithURL:URL_teacherClassList params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
            
            
            if(result){
                
                
                if ([[result objectForKey:@"status"] integerValue] == 0) {
                    
                    NSMutableArray *marray = [NSMutableArray array];
                    
                    NSArray *array = result[@"result"];
                    
                    for (NSDictionary *subDic in array) {
                        KClassModel *model = [[KClassModel alloc] initWithDataDic:subDic];
                        model.cid = subDic[@"id"];
                        [marray addObject:model];
                    }
                    self.dataList = marray;
                    [_tableView reloadData];
                }else{
                    
                    [MBProgressHUD showError:result[@"msg"] toView:self.view];
                    
                    
                    
                }
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
            
            [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
            
            
        }];
        
    }else{
    NSDictionary *params;
    
    params = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":self.model.sid,@"aid":self.model.aid,@"type":self.model.type};
        
    [WXDataService requestAFWithURL:URL_agencyClassList params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                NSMutableArray *marray = [NSMutableArray array];
                
                NSArray *array = result[@"result"];
                
                for (NSDictionary *subDic in array) {
                    KClassModel *model = [[KClassModel alloc] initWithDataDic:subDic];
                    model.cid = subDic[@"id"];
                    [marray addObject:model];
                }
                self.dataList = marray;
                [_tableView reloadData];
                
            }else{
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
                
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];
    
    }
    
}

#pragma mark -------UITableView Delegate ------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KClassModel *model = self.dataList[indexPath.row];
    cell.textLabel.text = model.title;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:Group] intValue] != 2){
    if ([model.is_full intValue] == 0) {
        //没有满员
        cell.detailTextLabel.text = @"报名";
        cell.detailTextLabel.textColor = Color_nav;

        
    }else{
    //满员
        cell.detailTextLabel.text = @"满员";
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    }
    }else{
    
        cell.detailTextLabel.text = @"";

    
    }

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    texukechengDetailVC *vc = [[texukechengDetailVC alloc] init];
    vc.model = self.dataList[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end





