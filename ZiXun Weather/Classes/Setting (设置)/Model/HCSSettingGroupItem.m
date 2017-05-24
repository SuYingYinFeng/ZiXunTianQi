//
//  HCSSettingGroupItem.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSSettingGroupItem.h"

@implementation HCSSettingGroupItem

+ (instancetype)settingGroupItemWithRowSettingArray:(NSArray *)rowSettingArray
{
    HCSSettingGroupItem *groupItem = [[self alloc] init];
    groupItem.rowSettingItemArray = rowSettingArray;
    return groupItem;

}

@end
