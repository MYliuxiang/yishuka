//
//  texukechengDetailVC.m
//  Community
//
//  Created by 李江 on 16/5/16.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "texukechengDetailVC.h"
#import "JiaoshiCell.h"
#import "BaoMingVC.h"
@interface texukechengDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
   UITableView *_tableView;
}
@end

@implementation texukechengDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = self.model.title;
    self.ISFANHUI = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    [self _loadData];
    [self _initView];


}

- (void)_loadData
{
    
    NSDictionary *params;
    
    params = @{@"member_id":[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Userid]],@"id":self.model.cid};
    
    [WXDataService requestAFWithURL:URL_classInfo params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        
        if(result){
            
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                NSDictionary *dic = result[@"result"];
                ClassInfoModel *model = [[ClassInfoModel alloc] initWithDataDic:dic];
                model.cid = dic[@"id"];
                model.cdescription = dic[@"description"];
                self.cmodel = model;
                
                TeacherModel *tmodel = [[TeacherModel alloc] initWithDataDic:dic[@"teacher"]];
                tmodel.tid = dic[@"teacher"][@"teacher_id"];
                tmodel.cdescription = dic[@"teacher"][@"description"];
                self.tmodel = tmodel;

                [_tableView reloadData];
                [_webView loadHTMLString:self.cmodel.content baseURL:nil];

                
            }else{
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];


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
    [self.view addSubview:_tableView];
    
    
    NSLog(@"%d",[[UserDefaults objectForKey:Group] intValue]);
    
    if ([[UserDefaults objectForKey:Group] intValue] != 2) {
        
        if ([self.model.is_full intValue] == 0) {
            
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        footView.backgroundColor = [UIColor whiteColor];
        
        UIButton *lingquButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lingquButton.frame =CGRectMake((kScreenWidth-200)/2.0,20, 200, 45);
        [lingquButton setTitle:@"立即报名" forState:UIControlStateNormal];
//        lingquButton.titleLabel.font = [UIFont systemFontOfSize:15];
        lingquButton.backgroundColor = Color_nav;
        [lingquButton addTarget:self action:@selector(lijibaoming) forControlEvents:UIControlEventTouchUpInside];
        lingquButton.layer.cornerRadius = 5;
        // 按钮边框宽度
        lingquButton.layer.masksToBounds = YES;
        [footView addSubview:lingquButton];
        _tableView.tableFooterView = footView;
            
        }
        
    }
    
}


#pragma mark -------- 报名 -----------------
- (void)lijibaoming
{
    
    BaoMingVC *vc = [[BaoMingVC alloc] init];
    vc.isbaoming = YES;
    vc.BMid = self.model.cid;
    vc.titleString = self.text;
    [self .navigationController pushViewController:vc animated:YES];

    
    

}

#pragma mark ----- TableViewDataSource ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString *cellID = @"JiaoshiCellID";
        JiaoshiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"JiaoshiCell" owner:nil options:nil]lastObject];;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.tmodel;
        return cell;
   
    }else if (indexPath.section == 0){
    
        static NSString *identifire = @"CellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.cmodel.cdescription];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        
        return cell;

        
    }else {
        static NSString *identifire = @"CellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            
            _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
            _webView.tag = 200;
            _webView.delegate = self;
            _webView.scrollView.scrollEnabled = NO;
            [cell.contentView addSubview:_webView];
        }
        
        _webView.frame = CGRectMake(0, 0, kScreenWidth, self.myheight + 20);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } 
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    self.myheight = [height_str intValue];
    
    [_tableView reloadData];
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return [UITableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
        
    }else if (indexPath.section == 1){
    
        return [JiaoshiCell whc_CellHeightForIndexPath:indexPath tableView:tableView];

    
    } else {
        
        return self.myheight + 20;
        
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, bgView.height)];
    if (section == 1) {
         label.text = @"任课老师:";
    }else if(section == 2){
    
        label.text = @"课程安排:";

    } else {
         label.text = @"课程内容:";
    }
    
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [bgView addSubview:label];
    return bgView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
