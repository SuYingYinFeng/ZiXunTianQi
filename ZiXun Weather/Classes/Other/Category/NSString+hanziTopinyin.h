//
//  NSString+hanziTopinyin.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hanziTopinyin)

/**
 *  只能传入汉字，如果不是，程序崩溃
 *
 *  @param hanziString     汉字
 *  @param isMandarinLatin 是否加声调
 *
 *  @return 拼音
 */

+ (NSString *)stringToPinyinWithHanziString:(NSString *)hanziString isMandarinLatin:(BOOL)isMandarinLatin;

@end
