//
//  CollectionVC.m
//  Community
//
//  Created by 李江 on 16/3/25.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "CollectionVC.h"
#import "CollectoinCell.h"
#import "ClassroomDetailsVC.h"
@interface CollectionVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"收藏";
    
    [self _initView];
}

- (void)_initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     _tableView.rowHeight = 178;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];


}
#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *identifire = @"cellID";
    CollectoinCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectoinCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = Color_cell;
    return cell;
    
}

#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{

    // 添加一个删除按钮
    UITableViewRowAction *deleterowaction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }];
    
    deleterowaction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    
    return @[deleterowaction];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassroomDetailsVC *vc = [[ClassroomDetailsVC alloc] init];
    vc.isketangji = YES;
    [self.navigationController pushViewController:vc animated:YES];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
