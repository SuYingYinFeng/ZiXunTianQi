//
//  HCSBoolSpecialModeTool.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/13.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSBoolSpecialModeTool : NSObject
/**
 *  判断是否为邮箱
 *
 *  @param email 要判断的字符串
 *
 *  @return YES/NO
 */
+ (BOOL) boolSpecialModeToolValidateEmail:(NSString *)email;

/**
 *  判断是否为密码
 *
 *  @param passWord 要判断的字符串
 *
 *  @return YES/NO
 */
+ (BOOL) boolSpecialModeToolValidatePassword:(NSString *)passWord;

/**
 *  判断是否为手机号码
 *
 *  @param passWord 要判断的字符串
 *
 *  @return YES/NO
 */
+ (BOOL)boolSpecialModeToolValidateMobile:(NSString *)phoneNumber;

@end
