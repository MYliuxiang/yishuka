//
//  InputCheck.m
//  icontact4ios
//
//  Created by simon on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InputCheck.h"

@implementation InputCheck
//判断是否是数字
+(BOOL) isNumber:(NSString *)string{
    NSCharacterSet *cs;     
    cs =[[NSCharacterSet characterSetWithCharactersInString:NUMBERSPERIOD]invertedSet];     
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];  
    BOOL basicTest = [string isEqualToString:filtered];  
    return basicTest; 
}
//判断是否是手机号码
+(BOOL) isPhone:(NSString *)string{
    NSString *Regex = @"\\b(1)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];  
    return [phoneTest evaluateWithObject:string];  
}

//判断输入的文字个数
+(BOOL) inputNum:(NSString *)string{
    NSString *Regex = @"[\s\S]{0,12}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [phoneTest evaluateWithObject:string];
}

////判断是否是手机号码
//+(BOOL) isPhone:(NSString *)string{
//    NSString *Regex = @"\\b(1)[3568][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    return [phoneTest evaluateWithObject:string];
//}

//判断是否是email地址
+(BOOL) isEmail:(NSString *)string{
    NSString*Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";  
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];  
    return [emailTest evaluateWithObject:string]; 
}

@end
