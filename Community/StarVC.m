//
//  StarVC.m
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "StarVC.h"
#import "StarCell.h"
#import "TopscreenView.h"
#import "RecordFinishVC.h"
#import "ClassroomDetailsVC.h"
@interface StarVC ()

@end

@implementation StarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"星秀场";
    [self _initViews];
}

- (void)_initViews
{
    topView = [[TopscreenView alloc] initWithFrame:CGRectMake(0, 94, kScreenWidth, 1)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.clipsToBounds = YES;
    [self.view addSubview:topView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    StarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StarCell" owner:nil options:nil] lastObject];
        
    }
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassroomDetailsVC *vc = [[ClassroomDetailsVC alloc] init];
    vc.isketangji = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;

}

- (IBAction)videoAction:(id)sender {
    

    [UIView animateWithDuration:0.25 animations:^{
        topView.height = 0;
    } completion:^(BOOL finished) {
        if(finished){
            RecordFinishVC *recordfinishVC = [[RecordFinishVC alloc]init];
            [self.navigationController pushViewController:recordfinishVC animated:YES];

        }
    }];
    
}
- (IBAction)paixunAction:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        topView.height = 210;
        
    } completion:^(BOOL finished) {
        
    }];
   
}

- (IBAction)chakanAction:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        topView.height = 0;
    } completion:^(BOOL finished) {
        if(finished){
            
            
        }
    }];
}


@end
