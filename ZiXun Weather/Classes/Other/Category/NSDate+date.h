//
//  NSDate+date.h
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/5/7.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (date)
// 判断下是否是今年
- (BOOL)isThisYear;
// 判断下是否是今天
- (BOOL)isThisDay;
// 判断下是否是昨天
- (BOOL)isYesterday;

// 获取日期与当前日期差值
- (NSDateComponents *)detalDateWithNow;

@end
