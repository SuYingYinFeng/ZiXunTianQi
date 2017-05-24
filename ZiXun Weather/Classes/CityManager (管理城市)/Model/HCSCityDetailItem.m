//
//  HCSCityDetailItem.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/28.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSCityDetailItem.h"
#import <MJExtension/MJExtension.h>

@implementation HCSCityDetailItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

+ (NSArray *)mj_allowedCodingPropertyNames
{
    return @[@"city",@"cityE",@"prov",@"ID"];
}


@end
