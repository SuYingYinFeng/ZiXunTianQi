//
//  HCSDailyForecastItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/31.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HCSAstroDailyItem;
@class HCSCondDailyItem;
@class HCSTmpDailyItem;
@class HCSWindDaityItem;

@interface HCSDailyForecastItem : NSObject

@property (nonatomic,strong) HCSAstroDailyItem *astro;

@property (nonatomic,strong) HCSCondDailyItem  *cond;

@property (nonatomic,strong) NSString *date;

@property (nonatomic,strong) NSString *hum;

@property (nonatomic,strong) NSString *pcpn;

@property (nonatomic,strong) NSString *pop;

@property (nonatomic,strong) NSString *pres;

@property (nonatomic,strong) NSString *vis;

@property (nonatomic,strong) HCSTmpDailyItem *tmp;

@property (nonatomic,strong) HCSWindDaityItem *wind;

@end
