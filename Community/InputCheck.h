//
//  InputCheck.h
//  icontact4ios
//
//  Created by simon on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NUMBERSPERIOD @"0123456789." 

@interface InputCheck : NSObject
+(BOOL) isNumber:(NSString *)string;
+(BOOL) isPhone:(NSString *)string;
+(BOOL) isEmail:(NSString *)string;
+(BOOL) inputNum:(NSString *)string;
@end
