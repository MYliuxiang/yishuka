//
//  LSluzhiVC.m
//  Community
//
//  Created by 未来社区 on 16/7/8.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "LSluzhiVC.h"

@interface LSluzhiVC ()<UITextViewDelegate>

@end

@implementation LSluzhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text = self.title;
    
    _textView.delegate = self;
    _fabu_Button.backgroundColor = Color_nav;
    [_fabu_Button setTitle:@"保存并发布" forState:UIControlStateNormal];
    _fabu_Button.titleLabel.font = [UIFont systemFontOfSize:14];
    _fabu_Button.layer.cornerRadius = 5;
    _fabu_Button.layer.masksToBounds = YES;
    
    [_fabu_Button addTarget:self action:@selector(fabu_ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _SpimgView.image = self.imgAry[0];
    _SpimgView.userInteractionEnabled = YES;
    
    UIButton *video_button = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-42)/2.0, (240-42)/2.0, 42, 42)];
    [video_button setImage:[UIImage imageNamed:@"视频－播放按钮"] forState:UIControlStateNormal];
    [_SpimgView addSubview:video_button];
    
    _miaoshu_label = [[UILabel alloc]init];
    _miaoshu_label.frame = CGRectMake(10, 8,kScreenWidth-20,20);
    _miaoshu_label.text = @"写一些关于本节视频的描述...";
    _miaoshu_label.font = [UIFont systemFontOfSize:14];
    _miaoshu_label.textColor = Color(184,184,184);
    [_textView addSubview:_miaoshu_label];


    
    
    _zishu = [[UILabel alloc]init];
    _zishu.frame = CGRectMake(0, 150-20, kScreenWidth-10, 20);
    _zishu.font = [UIFont systemFontOfSize:14];
    _zishu.textColor = Color(184,184,184);
    _zishu.textAlignment = NSTextAlignmentRight;
    _zishu.text = @"0/140";
    [_textView addSubview:_zishu];
    
    
    self.isBack = NO;
    [self addleftBtntitleString:@"重录" imageString:@"返回"];
    
    
}

- (void)fabu_ButtonAction{
//    http://101.200.127.204:9000/yishuka/index.php?m=Api&c=WebService&a=uploadImgApp
//    4.7 上传视频文件	http://XXXXXX/index.php?m=Api&c=WebService&a=uploadMp4App
//    提交参数	filename
//    返回参数	url视频地址
//    
//    4.8 发布回课记	courseMp4Sub
//    提交参数	member_id用户ID
//    id通告ID
//    class_id班级ID
//    thumb视频图
//    url视频路径
//    title通告标题
//    description描述
    
    if (_textView.text.length == 0) {
        [MBProgressHUD showError:@"描述不能为空" toView:self.view];
        return;
    }
    
    [WXDataService postMP4:URL_shiping params:nil fileData:_spAry[0] finishBlock:^(id result) {
        if ([[result objectForKey:@"status"] integerValue] == 0){
            NSDictionary *data = result[@"result"];
            NSString *spurl = data[@"url"];
            [self image_Upload:spurl];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

//上传图片
- (void)image_Upload:(NSString*)spurl{
    NSData *imageData = UIImageJPEGRepresentation(_imgAry[0], .3);
    [WXDataService postImage:URL_shangchuan params:nil fileData:imageData finishBlock:^(id result) {
        
        //成功
        if ([[result objectForKey:@"status"] integerValue] == 0){
            NSDictionary *dic = result[@"result"];
            NSString *headimgurl = dic[@"headimgurl"];
            [self UPload_data:headimgurl spurl:spurl];
        }else{
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}



- (void)UPload_data:(NSString *)imgurl spurl:(NSString *)spurl{

    //    提交参数	member_id用户ID
    //    id通告ID
    //    class_id班级ID
    //    thumb视频图
    //    url视频路径
    //    title通告标题
    //    description描述
    
    
    NSDictionary *params = @{@"member_id":[UserDefaults objectForKey:Userid],
                             @"id":self.hkid,
                             @"class_id":self.Class_id,
                             @"thumb":imgurl,
                             @"url":spurl,
                             @"title":self.title,
                             @"description":_textView.text};
    
    [WXDataService requestAFWithURL:URL_courseMp4Sub params:params httpMethod:@"POST" isHUD:YES finishBlock:^(id result) {
        
        if ([[result objectForKey:@"status"] integerValue] == 0){
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            [self.delegate luzhiwancheng];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}

//----------------------------textViewdelelgate----------------------------------------
- (void)textViewDidBeginEditing:(UITextView *)textView {
    _miaoshu_label.hidden = YES;
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length==0) {
        _miaoshu_label.hidden = NO;
    }
    
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
#define MY_MAX 140
    
    _zishu.text = [NSString stringWithFormat:@"%ld/140",text.length];
    
    if ((textView.text.length - range.length + text.length) > MY_MAX)
    {
        NSString *substring = [text substringToIndex:MY_MAX - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        return NO;
    }
    else
    {
        return YES;
    }
}



- (void)textViewDidChange:(UITextView *)textView

{
    _zishu.text = [NSString stringWithFormat:@"%ld/140",textView.text.length];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
