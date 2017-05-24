//
//  HCSPictureView.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCSNewsItem;
@interface HCSPictureView : UIView

+ (instancetype)loadPictureViewForCell;

@property (nonatomic,strong) HCSNewsItem *pictureViewNewsItem;

@end
