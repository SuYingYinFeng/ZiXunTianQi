//
//  HCSCollectionViewCell.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCSDailyForecastItem;

@interface HCSCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) HCSDailyForecastItem *dailyAllForecastItem;

@end
