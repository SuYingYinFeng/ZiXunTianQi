//
//  HCSBoolSpecialModeTool.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/13.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSBoolSpecialModeTool.h"

@implementation HCSBoolSpecialModeTool

+ (BOOL)boolSpecialModeToolValidateEmail:(NSString *)email
{
     NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
     NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
     return [emailTest evaluateWithObject:email];
}

+ (BOOL) boolSpecialModeToolValidatePassword:(NSString *)passWord

{
    
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
  
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
        
    return [passWordPredicate evaluateWithObject:passWord];
    
}

+ (BOOL)boolSpecialModeToolValidateMobile:(NSString *)phoneNumber
{
    
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    if ([regexTestMobile evaluateWithObject:phoneNumber]) {
            return YES;
    }else {
            return NO;
    }
}

@end
