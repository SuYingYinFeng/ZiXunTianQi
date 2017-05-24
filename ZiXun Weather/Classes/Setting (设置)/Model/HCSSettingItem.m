//
//  HCSSettingItem.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSSettingItem.h"

@implementation HCSSettingItem

+ (instancetype)settingItemWithImage:(UIImage *)image title:(NSString *)title {
    
    HCSSettingItem *item = [[self alloc] init];
    item.cellImage = image;
    item.cellTitle = title;
    return item;
    
}
@end
