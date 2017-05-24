//
//  HCSCityItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/30.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HCSApiItem;
@class HCSBasicItem;
@class HCSDailyForecastItem;
@class HCSHourlyForecastItem;
@class HCSNowItem;
@class HCSSuggestionItem;

@interface HCSCityItem : NSObject

@property (nonatomic,strong) HCSApiItem *aqi;

@property (nonatomic,strong) HCSBasicItem *basic;

@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSArray *daily_forecast;
@property (nonatomic,strong) HCSDailyForecastItem *dailyForecast;

@property (nonatomic,strong) NSArray *hourly_forecast;
@property (nonatomic,strong) HCSHourlyForecastItem *hourlyForecast;

@property (nonatomic,strong) HCSNowItem *now;

@property (nonatomic,strong) HCSSuggestionItem *suggestion;

@end
