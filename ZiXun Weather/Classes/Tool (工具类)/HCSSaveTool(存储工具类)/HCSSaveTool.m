//
//  HCSSaveTool.m
//  资讯天气
//
//  Created by 黄灿森 on 16/4/30.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSSaveTool.h"

@implementation HCSSaveTool

/**
 *  根据key值从偏好设置当上读取数据
 *
 *  @param key 指定的key值
 *
 *  @return 获取的数据
 */


+ (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/**
 *  根据key值把指定的内容存到偏好设置当中
 *
 *  @param object 要存的内容
 *  @param key 指定的key值
 */
+ (void)setObject:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}





@end
