//
//  ProfessionalchoiceViewController.h
//  Community
//
//  Created by 李立 on 16/3/26.
//  Copyright © 2016年 李江. All rights reserved.
//

#import "BaseViewController.h"

@interface ProfessionalchoiceViewController : BaseViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSArray *_nameArray;
}

@property (strong, nonatomic) UIPickerView *pickerView;



@end
