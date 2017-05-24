//
//  HCSWeatherMiddleView.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCSCityItem;

@interface HCSWeatherMiddleView : UIView

+ (instancetype)loadMiddleCellView;

@property (nonatomic,strong) HCSCityItem *cityItem;

@end
