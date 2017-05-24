//
//  HCSMineItem.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/12.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSMineItem.h"

@implementation HCSMineItem

+ (instancetype)settingItemWithImage:(UIImage *)image title:(NSString *)title {
    
    HCSMineItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    return item;
    
}

- (NSString *)accountName
{
    NSString *accountName = [HCSSaveTool objectForKey:accountNameKey];
    if (accountName) {
        return accountName;
    }
    return nil;
}

@end
