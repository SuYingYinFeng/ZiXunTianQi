//
//  HCSCityItem.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/30.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSCityItem.h"
#import <MJExtension/MJExtension.h>

@implementation HCSCityItem

// 告诉MJExtension当前模型数组中字典需要转换成哪个模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"daily_forecast":@"HCSDailyForecastItem",@"hourly_forecast":@"HCSHourlyForecastItem"};
}

- (void)setDaily_forecast:(NSArray *)daily_forecast
{
    _daily_forecast = daily_forecast;
    
    for (HCSDailyForecastItem *dailyForecastItem in daily_forecast) {
        _dailyForecast = dailyForecastItem;
    }
}

- (void)setHourly_forecast:(NSArray *)hourly_forecast
{
    _hourly_forecast = hourly_forecast;
    
    for (HCSHourlyForecastItem *hourlyForecastItem in hourly_forecast) {
        _hourlyForecast = hourlyForecastItem;
    }
}


@end
