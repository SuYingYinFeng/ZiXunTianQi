//
//  HCSWeatherCell.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HCSWeatherTopCell,
    HCSWeatherMiddleCell,
    HCSWeatherBottomCell,
} HCSWeatherView;

@interface HCSWeatherCell : UITableViewCell

@property (nonatomic,assign) HCSWeatherView weatherViewStutes;

@end
