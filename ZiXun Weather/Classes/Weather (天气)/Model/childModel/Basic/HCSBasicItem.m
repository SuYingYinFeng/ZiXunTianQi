//
//  HCSBasicItem.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/31.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSBasicItem.h"
#import <MJExtension/MJExtension.h>

@implementation HCSBasicItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end
