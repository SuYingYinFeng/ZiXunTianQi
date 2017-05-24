//
//  HCSWeatherExponentView.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/26.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCSCityItem;

@interface HCSWeatherExponentView : UIView

+ (instancetype)loadExponentCellView;

@property (nonatomic,strong) HCSCityItem *cityItem;

@end
