//
//  MeViewController.m
//  Community
//
//  Created by 李江 on 16/3/19.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "MeViewController.h"
#import "FansViewController.h"
#import "WorksCell.h"
#import "MeSetVC.h"
#import "OthersHomeVC.h"
#import "CollectionVC.h"
#import "FansViewController.h"
#import "GuanZhuListVC.h"
#import "ClassroomDetailsVC.h"
#import "AddressbookController.h"
#import "PrivateVC.h"
#import "ClassroomVC.h"
#import "ModifydataViewController.h"
#import "ContactViewController.h"
#import "LJShouCangVC.h"
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

@interface MeViewController ()<UIImagePickerControllerDelegate,UINavigationBarDelegate>
@property(nonatomic,strong)NSString *tiaoshu;

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *gg =[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:Headimgurl]] ;
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:gg] placeholderImage:[UIImage imageNamed:@"001.png"]];
    nameLabel.text = [UserDefaults objectForKey:Name_sure];
    
    [self tiaoshudata];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"我";
    self.dataList = @[@"1",@"2",@"3"];
    self.titles = @[@[@"私信",@"我的班级",@"收藏夹"],@[@"修改资料",@"修改密码",@"意见反馈",@"联系客服",@"清除缓存"]];
    self.imageNames =@[@[@"我－私信",@"我－班级",@"我－收藏"],@[@"我－资料",@"我－密码",@"我－意见",@"我－电话",@"我－清除"]];
    
    self.navbarHiden = NO;
    self.nav.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self _initViews];
    [self _loadata];

}
- (void)_loadata
{
    [WXDataService requestAFWithURL:URL_customerService params:nil httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        
        
        if(result){
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
            
                [Phone clearTable];
                 Phone *phone = [[Phone alloc] init];
                 phone.phone = result[@"result"];
                [phone save];
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:1];
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            }
            //没有数据了
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:self.view];
                
            }
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [MBProgressHUD showError:@"网络连接失败！" toView:self.view];
        
        
    }];
}

- (void)tiaoshudata{

    [WXDataService requestAFWithURL:URL_getNoteNews params:@{@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" isHUD:NO finishBlock:^(id result) {
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            _tiaoshu = result[@"result"];
        
        }
        
        [_tableView reloadData];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];


}


- (void)_initViews
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];

    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 160) / 2.0, 30, 160, 40)];
    button.backgroundColor = Color_nav;
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backLogin) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.layer.cornerRadius = 2;
    button.layer.masksToBounds = YES;
    _tableView.tableFooterView = footView;
    
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint firstPoint = CGPointMake(0, imageView.height);
    CGPoint secondPoint = CGPointMake(kScreenWidth, imageView.height);

    [path moveToPoint:firstPoint];

    [path addQuadCurveToPoint:secondPoint controlPoint:CGPointMake(kScreenWidth / 2.0, imageView.height - 30 * 2)];

    CAShapeLayer *_trackLayer = [CAShapeLayer layer];//创建一个track shape layer
    _trackLayer.frame = imageView.bounds;
    _trackLayer.fillColor = [[UIColor whiteColor] CGColor];
    _trackLayer.strokeColor = [UIColor whiteColor].CGColor;//指定path的渲染颜色
    _trackLayer.opacity = 1; //背景透明度小一点
    _trackLayer.lineCap = kCALineCapButt;//指定线的边缘是圆的
    _trackLayer.lineWidth = 1.0;//线的宽度
    _trackLayer.path =[path CGPath];
    [imageView.layer addSublayer:_trackLayer];
    
    
    
    avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 60) / 2.0, imageView.height - 60, 60, 60)];
//    avatarImageView.backgroundColor = [UIColor redColor];
//    avatarImageView.image = [UIImage imageNamed:@"001.png"];
//    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:[UserDefaults objectForKey:Headimgurl]] placeholderImage:[UIImage imageNamed:@"001.png"]];
    avatarImageView.layer.cornerRadius = 30;
    avatarImageView.layer.masksToBounds = YES;
    [imageView addSubview:avatarImageView];
    avatarImageView.clipsToBounds = YES;
    avatarImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiugai)];
    [avatarImageView addGestureRecognizer:tap];
    
    UIImageView *fiximage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    fiximage.userInteractionEnabled = YES;
    fiximage.image = [UIImage imageNamed:@"个人－编辑头像"];
    fiximage.center = CGPointMake(kScreenWidth / 2.0 + 25, imageView.height - 15);
    [imageView addSubview:fiximage];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, avatarImageView.bottom, kScreenWidth, 30)];
//    nameLabel.text = [UserDefaults objectForKey:Username];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:nameLabel];
    
    
//    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, nameLabel.bottom, kScreenWidth, 1)];
//    imageView1.backgroundColor = ColorRGB(221, 214, 203, 1);
//    [view addSubview:imageView1];
//    
//    
//    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, nameLabel.bottom + 49, kScreenWidth, 1)];
//    imageView2.backgroundColor = ColorRGB(221, 214, 203, 1);
//    [view addSubview:imageView2];
//
//    
//    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 240) / 2.0, nameLabel.bottom, 80, 50)];
//    [view addSubview:view1];
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
//    [view1 addGestureRecognizer:tap1];
//    
//    guanzhu = [[UILabel alloc] initWithFrame:CGRectMake(0,5, 80, 20)];
//    guanzhu.text = @"20";
//    guanzhu.numberOfLines = 0;
//    guanzhu.font = [UIFont systemFontOfSize:14];
//    guanzhu.textAlignment = NSTextAlignmentCenter;
//    guanzhu.textColor = Color_nav;
//    [view1 addSubview:guanzhu];
//    
//   UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 80, 20)];
//    label1.text = @"关注";
//    label1.numberOfLines = 0;
//    label1.font = [UIFont systemFontOfSize:14];
//    label1.textAlignment = NSTextAlignmentCenter;
//    label1.textColor = [UIColor blackColor];
//    [view1 addSubview:label1];
//
//    
//    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(view1.right, nameLabel.bottom, 80, 50)];
//    [view addSubview:view2];
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
//    [view2 addGestureRecognizer:tap2];
//    fensi = [[UILabel alloc] initWithFrame:CGRectMake(0,5, 80, 20)];
//    fensi.text = @"100";
//    fensi.font = [UIFont systemFontOfSize:14];
//    fensi.textColor = Color_nav;
//
//    fensi.textAlignment = NSTextAlignmentCenter;
//    [view2 addSubview:fensi];
//    
//    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 80, 20)];
//    label2.text = @"粉丝";
//    label2.font = [UIFont systemFontOfSize:14];
//    label2.textAlignment = NSTextAlignmentCenter;
//    label2.textColor = [UIColor blackColor];
//    [view2 addSubview:label2];
//    
//
//    
//    
//    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(view2.right, nameLabel.bottom, 80, 50)];
//    [view addSubview:view3];
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)];
//    [view3 addGestureRecognizer:tap3];
//    shoucang = [[UILabel alloc] initWithFrame:CGRectMake(0,5, 80, 20)];
//    shoucang.text = @"30";
//    shoucang.textColor = Color_nav;
//
//    shoucang.font = [UIFont systemFontOfSize:14];
//    shoucang.textAlignment = NSTextAlignmentCenter;
//    
//    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 80, 20)];
//    label3.text = @"收藏";
//    label3.font = [UIFont systemFontOfSize:14];
//    label3.textAlignment = NSTextAlignmentCenter;
//    label3.textColor = [UIColor blackColor];
//    [view3 addSubview:label3];
//    
//    [view3 addSubview:shoucang];
//    
//
//    
//    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(view1.right, nameLabel.bottom + 5, 1, 40)];
//    imageView3.backgroundColor = ColorRGB(221, 214, 203, 1);
//    [view addSubview:imageView3];
//    
//    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(view2.right, nameLabel.bottom + 5, 1, 40)];
//    imageView4.backgroundColor = ColorRGB(221, 214, 203, 1);
//    [view addSubview:imageView4];
//    
//    UILabel *titleLable = [[UILabel alloc] initWithFrame: CGRectMake(kScreenWidth/ 2.0 - 50, 20, 50, 100)];
//    titleLable.backgroundColor = [UIColor clearColor];
//    titleLable.textColor=[UIColor whiteColor];
//    [titleLable setFont:[UIFont systemFontOfSize:16]];
//    titleLable.textAlignment = NSTextAlignmentCenter;
//    titleLable.text = @"我是大咖";
//    [titleLable sizeToFit];
//    titleLable.center = CGPointMake(kScreenWidth / 2.0, 42);
//
//    
//    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
//    right.frame = CGRectMake(kScreenWidth - 60, 20, 40, 44);
//    [right setImage:[UIImage imageNamed:@"nav_icon_set"] forState:UIControlStateNormal];
//    right.backgroundColor = [UIColor clearColor];
//    [right addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:right];
//    
//    [view addSubview:titleLable];
    
   
    _tableView.tableHeaderView = view;
    

}

//退出登录
- (void)backLogin
{
    [UserDefaults setBool:NO forKey:ISLogin];
    [UserDefaults setObject:@"" forKey:Userid];
    [UserDefaults setObject:@"" forKey:Username];
    [UserDefaults setObject:@"" forKey:idcard];
    [UserDefaults setObject:@"" forKey:Mobile];
    [UserDefaults setObject:@"" forKey:Group];
    [UserDefaults setObject:@"" forKey:Headimgurl];
    [UserDefaults setObject:@"" forKey:Name_sure];
    [UserDefaults setObject:@"" forKey:birthday];
    [UserDefaults setObject:@"" forKey:Address];
    [UserDefaults setObject:@"" forKey:Description];
    [UserDefaults synchronize];
    [MyLogin gotoLoginViewWithTarget:self];
}

- (void)rightAction:(UIButton *)sender
{
    MeSetVC *vc = [[MeSetVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tap1
{

    NSLog(@"关注");
//    OthersHomeVC *VC = [[OthersHomeVC alloc] init];
//    [self.navigationController pushViewController:VC animated:YES];
    GuanZhuListVC *guanzhuVC = [[GuanZhuListVC alloc]init];
    [self.navigationController pushViewController:guanzhuVC animated:YES];

}

- (void)tap2
{
    NSLog(@"粉丝");
    FansViewController *fansVC = [[FansViewController alloc]init];
    [self.navigationController pushViewController:fansVC animated:YES];
}

- (void)tap3
{
    NSLog(@"收藏");
    CollectionVC *collVC = [[CollectionVC alloc]init];
    [self.navigationController pushViewController:collVC animated:YES];
    
    
}

- (void)xiugai
{
    NSLog(@"修改头像");
//    MeSetVC *vc = [[MeSetVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    ModifydataViewController *modifydataVC = [[ModifydataViewController alloc]init];
    [self.navigationController pushViewController:modifydataVC animated:YES];
    


}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.imageNames[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *identifire = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 24, 24)];
//            imageView.tag = 100;
//            [cell.contentView addSubview:imageView];
//            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, imageView.top, 100, 24)];
//            label.textColor = [UIColor blackColor];
//            label.font = [UIFont systemFontOfSize:14];
//            label.tag = 101;
//            [cell.contentView addSubview:label];
            
//            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 35 - 8, 18, 8, 8)];
//            label1.layer.cornerRadius = 4;
//            label1.layer.masksToBounds = YES;
//            label1.tag = 99;
//            label1.backgroundColor = [UIColor redColor];
//            [cell.contentView addSubview:label1];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 - 1, kScreenWidth, 1)];
            lineView.backgroundColor = Color_line;
            [cell.contentView addSubview:lineView];
            
        }
        
//    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:100];
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
  

    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.section][indexPath.row]];
   
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(85,7, 8, 8)];
    label1.layer.cornerRadius = 4;
    label1.layer.masksToBounds = YES;
    label1.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:label1];
    label1.hidden = YES;
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        if ([_tiaoshu integerValue]==0) {
             label1.hidden = YES;
        }else{
         label1.hidden = NO;
        }
       
        
    }

    
    if (indexPath.section == 1 && (indexPath.row == 3 || indexPath.row == 4)) {

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = Color_nav;
        NSArray *array = [Phone findAll];
        if (indexPath.row == 4) {
            
             float count =  [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
            YYCache *cache = [[YYCache alloc] initWithName:@"SPHttpCache"];
            float count1 = [cache.diskCache totalCost]/1024.0/1024.0;
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",count + count1];

        }else{
        if (array.count ==0) {
            cell.detailTextLabel.text = @"";

        }else{
            Phone *phone = array[0];
            cell.detailTextLabel.text = phone.phone;

        }
        }


    }else{
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";

    
    }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        


}


#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮

//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    if (indexPath.section < 4) {
//        return nil;
//    }
//    // 添加一个删除按钮
//    UITableViewRowAction *deleterowaction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//
//    }];
//    
//    deleterowaction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
//    
//    
//    return @[deleterowaction];
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 10;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, bgview.height - 1, kScreenWidth, 1)];
    lineView.backgroundColor = Color_line;
    [bgview addSubview:lineView];
    if (section == 0) {
        bgview.backgroundColor = [UIColor whiteColor];
    } else {
        bgview.backgroundColor = [UIColor clearColor];
    }

    return bgview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 50;
    


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    
            if (indexPath.row == 0) {
            NSLog(@"私信");

            PrivateVC *vc = [[PrivateVC alloc] init];
                vc.ISFANHUI = YES;
            [self.navigationController pushViewController:vc animated:YES];
            

        }else if (indexPath.row == 1){
            
            NSLog(@"我的班级");
            MyClassVCVC *addressbookVC = [[MyClassVCVC alloc]init];
            addressbookVC.ISFANHUI = YES;
            [self.navigationController pushViewController:addressbookVC animated:YES];
            

            
        }else{
            
            NSLog(@"收藏夹");
            LJShouCangVC *vc = [[LJShouCangVC alloc]init];
            vc.ISFANHUI = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }

    }else{
    
    
        if (indexPath.row == 0) {
            NSLog(@"修改资料");
//            MeSetVC *vc = [[MeSetVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
            ModifydataViewController *modifydataVC = [[ModifydataViewController alloc]init];
            modifydataVC.ISFANHUI = YES;
            [self.navigationController pushViewController:modifydataVC animated:YES];
            

            
        }else if(indexPath.row == 1){
        
            ModifyPssWordVC *vc = [[ModifyPssWordVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        
        }else if (indexPath.row == 2){
        
            NSLog(@"意见反馈");
            ContactViewController *contactVC = [[ContactViewController alloc]init];
            contactVC.ISFANHUI = YES;
            [self.navigationController pushViewController:contactVC animated:YES];

        }else if(indexPath.row == 3){
        
            NSLog(@"联系电话");

            NSArray *array = [Phone findAll];
            if (array.count ==0) {
                
            }else{
                Phone *phone = array[0];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打电话" message:phone.phone delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                alert.tag = 100;
                [alert show];
            }

            
           
        }else{
        
            //清除缓存
            NSString *message = [NSString stringWithFormat:@"确定要清除缓存吗?"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 101;
            [alert show];
            

            
        }
        
    }
    
//    if (indexPath.section == 1) {
//        NSLog(@"查看私信列表");
//        PrivateVC *vc = [[PrivateVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//
//    }
//    if(indexPath.section == 3){
//    
//        NSLog(@"作品");
//        ClassroomVC *vc = [[ClassroomVC alloc]init];
//        
//         [self.navigationController pushViewController:vc animated:YES];
//    
//    }
//    if (indexPath.section >= 4) {
//        ClassroomDetailsVC *vc = [[ClassroomDetailsVC alloc] init];
//        vc.isketangji = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }

}

#pragma mark UIAlertView Delegate---------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            NSArray *array = [Phone findAll];
            Phone *phone = array[0];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone.phone]]];
        }
 
    }else{
    
    if (buttonIndex == 0) {
        
    }else{
        
        YYCache *cache = [[YYCache alloc] initWithName:@"SPHttpCache"];
        [cache.diskCache removeAllObjects];
        [[SDImageCache sharedImageCache] clearDisk];
        [_tableView reloadData];
        
    }
    }
}


-(void)button
{
    FansViewController *fansVC = [[FansViewController alloc]init];
    [self.navigationController pushViewController:fansVC animated:YES];

}
-(void)button1
{
//    FansViewController *fansVC = [[FansViewController alloc]init];
//    [self.navigationController pushViewController:fansVC animated:YES];
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    UIColor *color=[UIColor redColor];
//    CGFloat offset=scrollView.contentOffset.y;
//    if (offset<0) {
//        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:0];
//    }else {
//        CGFloat alpha=1-((64-offset)/64);
//        self.navigationController.navigationBar.backgroundColor=[color colorWithAlphaComponent:alpha];
//    }
//}


@end



















