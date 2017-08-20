//
//  FounddetailsVC.m
//  Community
//
//  Created by lijiang on 16/3/31.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "FounddetailsVC.h"
#import "ScrollView.h"
#import "FounddetailCell.h"
#import "CourseListVC.h"
#import "DiscovermemberlistViewController.h"
#import "BaoMingVC.h"
#import "TeXukechengVC.h"
#import "BanjiListVC.h"
#import "JiaoshiTeamVC.h"
#import "FoundModel.h"
#import "PLModel.h"
#import "LognViewController.h"
#import "BaseNavigationController.h"
#import "NJBannerView.h"
#import "CFPicCarousView.h"
#import "CROneCell.h"

@interface FounddetailsVC ()<ScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIWebViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UIView *_celllineView;
    CFPicCarousView *picCarousView;
    UILabel *titleLbale;

}
@property(nonatomic,strong)NJBannerView *bannerV;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,strong)NSMutableArray *imgdata;
@property(nonatomic,strong)NSMutableArray *imgType;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,copy)NSString *count; //总条数


@end

@implementation FounddetailsVC{

    FoundModel *_model;
    int _pageIndex;
    BOOL _isdownLoad;
    UIWebView *_webVeiw;
    UIView *_headerView;
    UIView *_view;
    UITextField* _fasongfiled;
    
    
}

- (void)back
{
    [self close:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"机构详情";
    
    self.ISFANHUI = YES;
  
    
    [self _initView];
    [self _lodaData];
//    [self _loadDataPhone];
    [self pinglundataservice];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
}


#pragma mark --------------- 请求数据 --------------------------------------
- (void)_lodaData
{

    [WXDataService requestAFWithURL:Url_agencyInfo params:@{@"member_id":[UserDefaults objectForKey:Userid],@"id":_ID} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        NSLog(@"result:%@",result);
        _imgdata = [NSMutableArray new];
        _imgType = [NSMutableArray new];
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            NSDictionary *dic = result[@"result"];
            _model = [[FoundModel alloc]initWithDataDic:dic[@"info"]];
            _model.Founddescription = dic[@"info"][@"description"];
            _model.thumb_list = dic[@"thumb_list"];
            titleLbale.text = self.textstr;
            _model.foundid = [NSString stringWithFormat:@"%@",dic[@"info"][@"id"]];
            self.phone = dic[@"info"][@"mobile"];
            [_webVeiw loadHTMLString:_model.Founddescription  baseURL:nil];
            
//            self.text = _model.title;
           
            NSMutableArray *typeArray = [NSMutableArray new];
            [_model.thumb_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *url = obj[@"url"];
                NSString *type = obj[@"type"];
                [typeArray addObject:type];
                
                [_imgdata addObject:url];
                
            }];
             picCarousView.typeArray = typeArray;
             picCarousView.picModels = [_imgdata mutableCopy];

        }
        
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            [MBProgressHUD showError:result[@"msg"] toView:self.view];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    

}




- (void)pinglundataservice
{
    
    NSDictionary *params;
    
    params = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[UserDefaults objectForKey:Userid],@"id":self.ID};
    
    
    [WXDataService requestAFWithURL:URL_agencyInfoCommentList params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        _pageIndex ++;
        
        if(result){
            NSDictionary *dic = result[@"result"];
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                
                NSMutableArray *marray = [NSMutableArray array];
                NSArray *array = dic[@"list"];
                _count = dic[@"count"];
                for (NSDictionary *subDic in array) {
                    PLModel *model = [[PLModel alloc] initWithDataDic:subDic];
//                    model.hid = subDic[@"id"];
                    [marray addObject:model];
                }
                
                if (_isdownLoad) {
                    self.dataList = marray;
                    
                    [_tableView.mj_header endRefreshing];
                 
                } else {
                    [self.dataList addObjectsFromArray:marray];
                    [_tableView.mj_footer endRefreshing];
                }
                
                if ([dic[@"page"] intValue] == 0) {
                    //没有更多了
                    if (_isdownLoad) {
                        
                        [_tableView.mj_header endRefreshing];
                        [_tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        
                        [_tableView.mj_header endRefreshing];
                        [_tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    
                    
                }else{
                    //还有更多
                    if (_isdownLoad) {
                        
                        [_tableView.mj_header endRefreshing];
                        [_tableView.mj_footer resetNoMoreData];
                    } else {
                        
                        [_tableView.mj_footer endRefreshing];
                        [_tableView.mj_footer resetNoMoreData];
                    }
                    
                }
                
                [_tableView reloadData];
                
            }
            
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                if (_isdownLoad) {
                    [_tableView.mj_header endRefreshing];
                } else {
                    [_tableView.mj_footer endRefreshing];
                }
                
//                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        if (_isdownLoad) {
            [_tableView.mj_header endRefreshing];
        } else {
            [_tableView.mj_footer endRefreshing];
        }
        
    }];
    
}



////下啦刷新
- (void)downLoad
{
    _isdownLoad = YES;
    _pageIndex = 1;
    [self pinglundataservice];
    
}

//上啦加载
- (void)upLoad
{
    _isdownLoad = NO;
    [self pinglundataservice];
    
}




////请求电话
//- (void)_loadDataPhone
//{
//    
//    [WXDataService requestAFWithURL:URL_customerService params:nil httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
//        
//        
//        if(result){
//            
//            if ([[result objectForKey:@"status"] integerValue] == 0) {
//                
//                self.phone = result[@"result"];
//                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:([[UserDefaults objectForKey:Group] integerValue] == 1 ? 3 : 4)];
//                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//              
//            }
//            
//            //没有数据了
//            if ([[result objectForKey:@"status"] integerValue] == 1) {
//                
//                [MBProgressHUD showError:result[@"msg"] toView:self.view];
//                
//            }
//        }
//    } errorBlock:^(NSError *error) {
//        NSLog(@"%@",error);
//        
//        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
//        
//        
//    }];
//
//}


- (void)pinglunMydataService{
    
    
    if ([UserDefaults boolForKey:ISLogin] == NO) {
        weakSelf(weakSelf);
        LognViewController*registerVC = [[LognViewController alloc] init];
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:registerVC];
        [weakSelf presentViewController:navi animated:YES completion:nil];
        return;
    }
    
    
    
    if (_fasongfiled.text.length==0) {
        [MBProgressHUD showError:@"评论不能为空" toView:self.view];
        return;
    }
    
    NSDictionary *params =@{@"member_id":[UserDefaults objectForKey:Userid],
                            @"id":self.ID,@"content":_fasongfiled.text};
    
    [WXDataService requestAFWithURL: URL_agencyCommentSub params:params httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
                                                                      
                                                                      if ([result[@"status"] integerValue]==0) {
                                                                          
                                                                          _fasongfiled.text  =@"";
                                                                        
                                                                          _isdownLoad = YES;
                                                                          _pageIndex=1;
                                                                          [self pinglundataservice];
                                                                        
                                                                          [MBProgressHUD showSuccess:result[@"msg"] toView:self.view];
                                                                      }else{
                                                                          [MBProgressHUD showError:result[@"msg"] toView:self.view];
                                                                      }
                                                                      [_tableView reloadData];
                                                                  } errorBlock:^(NSError *error) {
                                                                      NSLog(@"%@",error);
                                                                  }];
    
    
}



- (void)_initView
{

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64-51) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    _tableView.tableHeaderView = _headerView;
    _tableView.backgroundColor = Color_bg;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 0.1)];
    [self.view addSubview:_tableView];
    
    
    picCarousView = [[CFPicCarousView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 155 * ratioHeight)];
    picCarousView.netPic = YES;
    [picCarousView removeTimer];
    picCarousView.myTapCurrentImgBlock = ^(NSInteger index){
        NSLog(@"点击的图片下标是：%ld", index);
        
        [self tapImageView:index];
    };
    [self.view addSubview:picCarousView];

    [_headerView addSubview:picCarousView];

    titleLbale = [[UILabel alloc]initWithFrame:CGRectMake(10, picCarousView.bottom, kScreenWidth - 20, 36)];
    titleLbale.font = [UIFont boldSystemFontOfSize:17];
    titleLbale.numberOfLines = 0;
    titleLbale.backgroundColor = [UIColor whiteColor];
    titleLbale.textColor = [UIColor blackColor];
    [_headerView addSubview:titleLbale];

    //轮播图
//    self.picView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 155 * ratioHeight)];
//    self.picView.delegate = self;
//    self.picView.backgroundColor = [UIColor clearColor];
//    //#warning 定时器默认关闭，手动打开，没有处理滑动时暂停NSTimer
//    [self.picView.timer fire ];
//    [_headerView addSubview:self.picView];
    
    
    _webVeiw  = [[UIWebView alloc]initWithFrame:CGRectMake(0,titleLbale.bottom, kScreenWidth, 20)];
    _webVeiw.delegate = self;
    _webVeiw.scrollView.bounces=NO;
    _webVeiw.scrollView.scrollEnabled = NO;
    _webVeiw.scrollView.showsHorizontalScrollIndicator = NO;
    _webVeiw.scrollView.showsVerticalScrollIndicator = NO;
    [_webVeiw setBackgroundColor:[UIColor clearColor]];
    [_webVeiw setOpaque:NO];
    [_headerView addSubview:_webVeiw];
    
    
    //发表评论的背景视图
    _view = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-51,kScreenWidth,51)];
    _view.backgroundColor = Color_bg;
    [self.view addSubview:_view];
    
    
    _fasongfiled = [[UITextField alloc]initWithFrame:CGRectMake(8,10, kScreenWidth-86,35)];
    _fasongfiled.backgroundColor = [UIColor whiteColor];
    _fasongfiled.delegate = self;
    [_view addSubview:_fasongfiled];
    _fasongfiled.layer.masksToBounds = YES;
    _fasongfiled.layer.cornerRadius = 5;
    _fasongfiled.placeholder = @"评论内容";
    _fasongfiled.font =[UIFont systemFontOfSize:12];
    _fasongfiled.leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];;
    _fasongfiled.leftViewMode = UITextFieldViewModeAlways;
//    [_fasongfiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    //发送按钮键
    UIButton *fsbutton = [[UIButton alloc]initWithFrame:CGRectMake(_fasongfiled.right+5,_fasongfiled.top,62,_fasongfiled.height)];
    [_view addSubview:fsbutton];
    [fsbutton setTitle:@"发送" forState:UIControlStateNormal];
    [fsbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fsbutton.titleLabel.font =[ UIFont systemFontOfSize:12];
    fsbutton.backgroundColor = [UIColor whiteColor];
    fsbutton.layer.masksToBounds = YES;
    fsbutton.layer.cornerRadius = 5;
    [fsbutton addTarget:self action:@selector(fsbuttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self _initRightItem];

}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    
    _webVeiw.height = height + 30;
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);
    _webVeiw.scrollView.backgroundColor = [UIColor whiteColor];
    _webVeiw.backgroundColor = [UIColor whiteColor];
    _headerView.height = _webVeiw.bottom;
    _tableView.tableHeaderView = _headerView;
    [_tableView reloadData];
    
}


- (void)fsbuttonAction{
    [_fasongfiled resignFirstResponder];
    [self pinglunMydataService];
    NSLog(@"发送");
    
}



#pragma mark ----- TableViewDataSource ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return ([[UserDefaults objectForKey:Group] integerValue] == 1 ? 5 : 6);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == ([[UserDefaults objectForKey:Group] integerValue] == 1 ? 4 : 5)) {
        return _dataList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == ([[UserDefaults objectForKey:Group] integerValue] == 1 ? 4 : 5))
    {
        
        static NSString *identifire = @"cellID1";
        CROneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CROneCell" owner:nil options:nil] lastObject];
            
        }
        PLModel *model = self.dataList[indexPath.row];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headimgurl]];
        cell.nameLabel.text = model.nickname;
        cell.commentLabel.text = model.title;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

        
    } else {
        
        static NSString *identifire = @"cellID4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];

            
        }
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    
        if(indexPath.section == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"机构－课程2"];
            cell.textLabel.text = @"标准课程";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"";
        
        }else if (indexPath.section == 1) {
            
            cell.imageView.image = [UIImage imageNamed:@"机构－课程1"];
            cell.textLabel.text = @"特需课程";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"";
            
            
        }else if(indexPath.section == 2){
            cell.imageView.image = [UIImage imageNamed:@"机构－老师"];
            cell.textLabel.text = @"师资团队";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"";
            
            
        }else if(indexPath.section == 3){
            cell.imageView.image = [UIImage imageNamed:@"机构－电话"];
            cell.textLabel.text = @"联系电话";
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = Color_nav;
            cell.detailTextLabel.text = self.phone;
            
            
        }else if(indexPath.section ==  4){
            cell.imageView.image = [UIImage imageNamed:@"机构－应聘"];
            cell.textLabel.text = @"教师应聘";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"";
            
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0 ) {
//        
//        return 260;
//        
//    }  else
        if (indexPath.section <= ([[UserDefaults objectForKey:Group] integerValue] == 1 ? 3 : 4)){
        
        return 60;
    } else {
        return [CROneCell whc_CellHeightForIndexPath:indexPath tableView:tableView] + 10;
    
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0) {
        return 10;
    }
    if (section == ([[UserDefaults objectForKey:Group] integerValue] == 1 ? 4 : 5)) {
        if (_dataList.count == 0) {
            return .1;
        }
        return 40;
    }
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 6) {
//        return 60;
//    }
    return .1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == ([[UserDefaults objectForKey:Group] integerValue] == 1 ? 4 : 5)) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        if (_dataList.count == 0) {
            bgView.hidden = YES;
        } else {
            bgView.hidden = NO;
        }
        
        UIView *witeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        witeView.backgroundColor = [UIColor clearColor];
        [bgView addSubview:witeView];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-90, 16, 14, 14)];
       
        imageView.image = [UIImage imageNamed:@"评论"];
        [bgView addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+ 5, imageView.top, 100, imageView.height)];
        label.text = [NSString stringWithFormat:@"%@条评论",_count];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = Color_text;
        [bgView addSubview:label];
        return bgView;

    }
    return nil;

}

- (void)dealloc{

    [_fmVideoPlayer removeFromSuperview];
    [_fmVideoPlayer.player pause];
    _fmVideoPlayer.delegate = nil;
    _fmVideoPlayer = nil;

}

- (void)close:(BOOL)isfull
{
    if (isfull) {
        
        
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [_tableView addSubview:_fmVideoPlayer];
            _fmVideoPlayer.frame = CGRectMake(0, 0, kScreenWidth, 155 * ratioHeight);
        }];
        
        if (_fmVideoPlayer.playOrPauseBtn.selected == YES) {
            
            [_fmVideoPlayer.player play];
            
        }else{
            [_fmVideoPlayer.player pause];
            
            
        }

        [_fmVideoPlayer removeFromSuperview];
        [_fmVideoPlayer.player pause];
        _fmVideoPlayer.delegate = nil;
        _fmVideoPlayer = nil;
        
        
    }else{
        
        [_fmVideoPlayer removeFromSuperview];
        [_fmVideoPlayer.player pause];
        _fmVideoPlayer.delegate = nil;
        _fmVideoPlayer = nil;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self close:NO];
    
    if (indexPath.section == 0 ) {
        NSLog(@"标准课程");
        TeXukechengVC *texukechengVC = [[TeXukechengVC alloc]init];
        texukechengVC.isSpecial = NO;
        texukechengVC.ID = self.ID;
        texukechengVC.text = @"标准课程";
        [self.navigationController pushViewController:texukechengVC animated:YES];
        //        DiscovermemberlistViewController *discoverVC = [[DiscovermemberlistViewController alloc]init];
        //        [self.navigationController pushViewController:discoverVC animated:YES];
    }
    //特需课程
    if (indexPath.section == 1 ) {
        NSLog(@"特需课程");
        TeXukechengVC *texukechengVC = [[TeXukechengVC alloc]init];
        texukechengVC.isSpecial = YES;
        texukechengVC.ID = self.ID;
        texukechengVC.text = @"特需课程";
        [self.navigationController pushViewController:texukechengVC animated:YES];
//        DiscovermemberlistViewController *discoverVC = [[DiscovermemberlistViewController alloc]init];
//        [self.navigationController pushViewController:discoverVC animated:YES];
    }
    //师资团队
    if (indexPath.section == 2 ) {
        NSLog(@"师资团队");
        JiaoshiTeamVC *jiaoshiTeamVC = [[JiaoshiTeamVC alloc]init];
        jiaoshiTeamVC.ID = self.ID;
        [self.navigationController pushViewController:jiaoshiTeamVC animated:YES];
        
    }
    //班级列表
    //报名电话
    if (indexPath.section == 3 ) {
        if (self.phone.length != 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打" message:self.phone delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];

        }
          }
    //应聘
    if (indexPath.section == ([[UserDefaults objectForKey:Group] integerValue] == 1 ? 8 : 4) ) {
        BaoMingVC *vc = [[BaoMingVC alloc] init];
        vc.isbaoming = NO;
        vc.BMid = _model.foundid;
        [self .navigationController pushViewController:vc animated:YES];
    }
    
}


//#pragma mark ------------ 菜单点击事件 ---------------------------------
//- (void)RightItemAction:(UITapGestureRecognizer *)tap
//{
//    //简介
//    if(tap.view.tag == 200)
//    {
//        
//    }
//    //课程
//    if(tap.view.tag == 201)
//    {
//        CourseListVC *sourcelistVC = [[CourseListVC alloc]init];
//        [self.navigationController pushViewController:sourcelistVC animated:YES];
//        
//    }
//    //查看成员
//    if(tap.view.tag == 202)
//    {
//        NSLog(@"查看成员列表");
//        DiscovermemberlistViewController *discoverVC = [[DiscovermemberlistViewController alloc]init];
//        [self.navigationController pushViewController:discoverVC animated:YES];
//        
//    }
//    //客服电话
//    if(tap.view.tag == 203)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打" message:@"400-666-8888" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        [alert show];
//    }
//    
//    
//}

#pragma mark UIAlertView Delegate---------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *urlstr = [NSString stringWithFormat:@"tel:%@",self.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstr]];
    }
    
}

#pragma mark ---------- 课程切换 ------------------
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    //标准课程
    if (tap.view.tag == 200) {
        [UIView animateWithDuration:.35 animations:^{
            _celllineView.left = 20;
        } completion:nil];
        
    }
    //特需课程
    if (tap.view.tag == 201) {
        [UIView animateWithDuration:.35 animations:^{
            _celllineView.left = 20 + 140;
        } completion:nil];
    }
    
    
}


#pragma mark ----- 轮播图点击事件 ------------------
- (void)tapImageView:(NSInteger)index 
{
    NSDictionary *dic = _model.thumb_list[index];
    //视频
    if ([dic[@"type"] integerValue] == 1) {
        NSString *mp4 = dic[@"mp4"];
        NSLog(@"mp4:%@",mp4);
        
        if (self.fmVideoPlayer == nil) {
            self.fmVideoPlayer = [FMGVideoPlayView videoPlayView];// 创建播放器
            self.fmVideoPlayer.delegate = self;
        }
        [_fmVideoPlayer setUrlString:mp4];
        
        // [_fmVideoPlayer setUrlString:@"http://flv2.bn.netease.com/videolib3/1605/20/QVMmc2460/SD/movie_index.m3u8"];
        _fmVideoPlayer.frame = CGRectMake(0, 0, kScreenWidth, 155 * ratioHeight);
        [_tableView addSubview:_fmVideoPlayer];
        _fmVideoPlayer.contrainerViewController = self;
        [_fmVideoPlayer.player play];
        [_fmVideoPlayer showToolView:NO];
        _fmVideoPlayer.playOrPauseBtn.selected = YES;
        _fmVideoPlayer.hidden = NO;
        
        
    }
    //图片
    if ([dic[@"type"] integerValue] == 2) {
        
         NSLog(@"图片");
       
    }
    
}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        _fullVc = [[FullViewController alloc] init];
    }
    return _fullVc;
}

- (void)videoplayViewSwitchOrientation:(BOOL)isFull{
    if (isFull) {
        [self.navigationController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self.fmVideoPlayer];
            _fmVideoPlayer.center = self.fullVc.view.center;
            
            //            [_fmVideoPlayer.player play];
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _fmVideoPlayer.frame = self.fullVc.view.bounds;
                
                //                self.fmVideoPlayer.danmakuView.frame = self.fmVideoPlayer.frame;
                
            } completion:nil];
            
            if (_fmVideoPlayer.playOrPauseBtn.selected == YES) {
                
                [_fmVideoPlayer.player play];
                
            }else{
                [_fmVideoPlayer.player pause];
                
                
            }
            
        }];
    } else {
        
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [_tableView addSubview:_fmVideoPlayer];
            _fmVideoPlayer.frame = CGRectMake(0, 0, kScreenWidth, 155 * ratioHeight);
        }];
        
        if (_fmVideoPlayer.playOrPauseBtn.selected == YES) {
            
            [_fmVideoPlayer.player play];
            
        }else{
            [_fmVideoPlayer.player pause];
            
            
        }
        
    }
    
}


#pragma mark --------- 发布评论 ------------------------
- (void)sendBtuAction
{
    
    
}

#pragma mark --------- 查看全部 ----------
- (void)quanbuBtn
{




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
