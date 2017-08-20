//
//  MeSetVC.m
//  Community
//
//  Created by 刘翔 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "MeSetVC.h"

@interface MeSetVC ()<UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation MeSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imagenames = @[@"个人－空间",@"个人－意见",@"个人－密码",@"个人－客服"];
    self.titles = @[@"我的空间",@"意见反馈",@"修改密码",@"客服电话"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navbarHiden = YES;
    [self _initViews];
}

- (void)_initViews
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
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
    avatarImageView.image = [UIImage imageNamed:@"001.png"];
    avatarImageView.layer.cornerRadius = 30;
    avatarImageView.layer.masksToBounds = YES;
    [imageView addSubview:avatarImageView];
    avatarImageView.clipsToBounds = YES;
    avatarImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiugai)];
    [avatarImageView addGestureRecognizer:tap];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, avatarImageView.bottom, kScreenWidth, 30)];
    nameLabel.text = @"张丽";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:nameLabel];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame: CGRectMake(kScreenWidth/ 2.0 - 50, 20, 50, 100)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor=[UIColor whiteColor];
    [titleLable setFont:[UIFont systemFontOfSize:16]];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"我是大咖";
    [titleLable sizeToFit];
    titleLable.center = CGPointMake(kScreenWidth / 2.0, 42);
    
    [view addSubview:titleLable];
    
    
        UIButton *backButtton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButtton.frame = CGRectMake(15, 30, 20, 20);
        [backButtton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backButtton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [view addSubview:backButtton];
    
    
    _tableView.tableHeaderView = view;
    

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)xiugai
{
    NSLog(@"修改头像");
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"相机",@"相册",nil];
    [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}



#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:  //打开本地相册
            [self CreameAction:1];
            break;
        case 1:
            [self CreameAction:2];
            break;
    }
}


////拍照的点击事
- (void)CreameAction:(NSInteger )index{

    UIView *vvv = [[UIApplication sharedApplication].keyWindow viewWithTag:7000];
    [UIView animateWithDuration:.35 animations:^{
        [vvv setTop:kScreenHeight];
    }];;

    static NSUInteger sourceType;

    if (index ==1) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(index ==2){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{

         UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        avatarImageView.image = image;
    }];

   

}

//




#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *identifire = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13, 24, 24)];
            imageView.tag = 100;
            [cell.contentView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, imageView.top, 100, 24)];
            label.textColor = Color_nav;
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 101;
            [cell.contentView addSubview:label];
            
        }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:100];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        imageView.image = [UIImage imageNamed:self.imagenames[indexPath.row]];
        label.text = self.titles[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = Color_cell;
    if (indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = @"400 -666-888";

    }else {
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";

    }
        return cell;
        

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;

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
    if (indexPath.row == 0) {
        NSLog(@"我的空间");
    }
    if (indexPath.row == 1) {
        NSLog(@"意见反馈");
    }
    if (indexPath.row == 2) {
        NSLog(@"修改密码");
    }
    if (indexPath.row == 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打翔哥电话" message:@"18617348375" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        
        
    }

}


#pragma mark UIAlertView Delegate---------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:18617348375"]];
    }

}

@end














