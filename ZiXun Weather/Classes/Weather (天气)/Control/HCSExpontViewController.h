//
//  HCSExpontViewController.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/6/4.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCSCityItem;

@interface HCSExpontViewController : UIViewController

@property (nonatomic,strong) HCSCityItem *cityItem;
@property (nonatomic,strong) NSString *brf;
@property (nonatomic,strong) NSString *txt;

@end
