//
//  HCSCellTopView.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCSNewsItem;

@interface HCSCellTopView : UIView

+ (instancetype)loadTopViewForCell;

@property (nonatomic,strong) HCSNewsItem *topViewNewsItem;

@end
