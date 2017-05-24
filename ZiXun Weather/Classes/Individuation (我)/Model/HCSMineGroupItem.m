//
//  HCSMineGroupItem.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/12.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSMineGroupItem.h"

@implementation HCSMineGroupItem

+ (instancetype)groupItemWithRowArray:(NSArray *)rowArray {
    
    HCSMineGroupItem *item = [[self alloc] init];
    item.rowItemArray = rowArray;
    return item;
}


@end
