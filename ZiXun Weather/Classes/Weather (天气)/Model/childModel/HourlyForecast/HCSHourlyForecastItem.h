//
//  HCSHourlyForecastItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/31.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HCSWindHourlyItem;

@interface HCSHourlyForecastItem : NSObject

@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *hum;
@property (nonatomic,strong) NSString *pop;
@property (nonatomic,strong) NSString *pres;
@property (nonatomic,strong) NSString *tmp;
@property (nonatomic,strong) HCSWindHourlyItem *wind;

@end
