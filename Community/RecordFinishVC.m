//
//  RecordFinishVC.m
//  Community
//
//  Created by lijiang on 16/4/11.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "RecordFinishVC.h"
#import "SeleFriendlyViewController.h"
@interface RecordFinishVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation RecordFinishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"录制完成";
    
    [self _initView];
}
- (void)_initView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
    [self _initFooter];

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
    _tableView.tableFooterView = view;
    
}

- (void)tijiao:(UIButton *)sender
{
    
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
     return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifire = @"cellID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, (90 / 2.0 * ratioHeight - 20) / 2.0, 40, 20)];
                label.text = @"名称";
                label.textColor = [UIColor blackColor];
                label.font = [UIFont systemFontOfSize:16];
                label.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:label];
                
                UITextView *textfield = [[UITextView alloc] initWithFrame:CGRectMake(label.right, label.top ,  kScreenWidth - label.right - 10, label.height)];
                textfield.backgroundColor = [UIColor clearColor];
                textfield.keyboardType = UIKeyboardTypeDefault;
                textfield.bounces = NO;
                textfield.tag = indexPath.row + 100;
                textfield.delegate = self;
                textfield.font = [UIFont systemFontOfSize:14];
                textfield.returnKeyType = UIReturnKeyDone;
                [cell.contentView addSubview:textfield];
                
                UILabel *label1 = [[UILabel alloc] init];
                label1.font = [UIFont systemFontOfSize:16];
                label1.frame =CGRectMake(5 ,0, textfield.width - 20, textfield.height);
                label1.text = @"请填写名称";
                label1.font = [UIFont systemFontOfSize:16];
                label1.tag = 99;
                label1.textColor = [UIColor colorWithRed:199 / 255.0 green:196 / 255.0 blue:196 / 255.0 alpha:1];
                label1.enabled = NO;         //lable必须设置为不可用
                [textfield addSubview:label1];
                
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 90 / 2.0 * ratioHeight - 1, kScreenWidth - 20, 1)];
                lineView.backgroundColor = Color_bg;
                [cell.contentView addSubview:lineView];
            }
            cell.backgroundColor = Color_cell;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if (indexPath.row == 1)
        {
            static NSString *identifire = @"cellID1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,0, kScreenWidth, 80 * ratioHeight)];
                label.text = @"添加封面图片";
                label.textColor = [UIColor blackColor];
                label.font = [UIFont systemFontOfSize:16];
                label.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:label];

                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 80 * ratioHeight - 1, kScreenWidth - 20, 1)];
                lineView.backgroundColor = Color_bg;
                [cell.contentView addSubview:lineView];
            }
            cell.backgroundColor = Color_cell;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
        } else {
        
            static NSString *identifire = @"cellID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
            
                UITextView *textfield = [[UITextView alloc] initWithFrame:CGRectMake(10, 0 ,  kScreenWidth - 20, 80 * ratioHeight)];
                textfield.delegate = self;
                textfield.backgroundColor = [UIColor clearColor];
                textfield.keyboardType = UIKeyboardTypeDefault;
                textfield.tag = indexPath.row + 100;
                textfield.font = [UIFont systemFontOfSize:16];
                textfield.returnKeyType = UIReturnKeyDone;
                [cell.contentView addSubview:textfield];
                
                UILabel *label1 = [[UILabel alloc] init];
                label1.font = [UIFont systemFontOfSize:16];
                label1.frame =CGRectMake(5 , 0, textfield.width - 20, 25 * ratioHeight);
                label1.text = @"这一刻想法...";
                label1.font = [UIFont systemFontOfSize:16];
                label1.tag = 100;
                label1.textColor = [UIColor colorWithRed:199 / 255.0 green:196 / 255.0 blue:196 / 255.0 alpha:1];
                label1.enabled = NO;         //lable必须设置为不可用
                [textfield addSubview:label1];
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 120 * ratioHeight - 1, kScreenWidth - 20, 1)];
                lineView.backgroundColor = Color_bg;
                [cell.contentView addSubview:lineView];
            }
            cell.backgroundColor = Color_cell;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
        
        }
      
    } else {
       
        static NSString *identifire = @"cellID4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 90 / 2.0 * ratioHeight - 1, kScreenWidth - 20, 1)];
            lineView.backgroundColor = Color_bg;
            [cell.contentView addSubview:lineView];
        }
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"录像－@好友"];
            cell.textLabel.text = @"好友";
        }
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"录像－发到星秀场"];
            cell.textLabel.text = @"发到星秀场";
        }
        cell.backgroundColor = Color_cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
    }
   
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SeleFriendlyViewController *seleVC = [[SeleFriendlyViewController alloc]init];
            [self.navigationController pushViewController:seleVC animated:YES];
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            return 90 / 2.0 * ratioHeight;
            
        } else if (indexPath.row == 1){
            return  80 * ratioHeight;
        
        }else {
            return 120 * ratioHeight;
        }
    } else {
        return 90 / 2.0 * ratioHeight;
    }



}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return .1;
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag == 100) {
        UILabel *label = (UILabel *)[textView viewWithTag:99];
        if (textView.text.length == 0) {
            label.text = @"请填写名称";
        }else{
            label.text = @"";
        }
    } else {
    
        UILabel *label = (UILabel *)[textView viewWithTag:100];
        if (textView.text.length == 0) {
            label.text = @"这一刻想法...";
        }else{
            label.text = @"";
        }
    
    }
    
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
