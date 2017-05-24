//
//  HCSSettingGroupItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSSettingGroupItem : NSObject

//头部标题
@property (strong, nonatomic) NSString *headerTitle;
//尾部标题
@property (strong, nonatomic) NSString *footerTitle;
//一组当中有多少行
@property (strong, nonatomic) NSArray *rowSettingItemArray;

+ (instancetype)settingGroupItemWithRowSettingArray:(NSArray *)rowSettingArray;



@end
