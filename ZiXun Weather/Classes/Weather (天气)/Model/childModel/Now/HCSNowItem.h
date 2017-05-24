//
//  HCSNowItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/31.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HCSCondNowItem;
@class HCSWindNowItem;

@interface HCSNowItem : NSObject

@property (nonatomic,strong) HCSCondNowItem *cond;

@property (nonatomic,strong) NSString *fl;

@property (nonatomic,strong) NSString *hum;

@property (nonatomic,strong) NSString *pcpn;

@property (nonatomic,strong) NSString *pres;

@property (nonatomic,strong) NSString *tmp;

@property (nonatomic,strong) NSString *vis;

@property (nonatomic,strong) HCSWindNowItem *wind;

@end
