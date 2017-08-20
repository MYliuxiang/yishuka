//
//  PtivateReplyVC.m
//  Community
//
//  Created by 刘翔 on 16/4/23.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "PtivateReplyVC.h"

@interface PtivateReplyVC ()

@end

@implementation PtivateReplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text = @"私信回复";
    self.cancelBtn.layer.borderWidth = .5;
    self.cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    

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

- (IBAction)sendAC:(id)sender {
}
- (IBAction)cancelAC:(id)sender {
}
@end



























