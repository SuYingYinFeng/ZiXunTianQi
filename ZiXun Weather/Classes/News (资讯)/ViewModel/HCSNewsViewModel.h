//
//  HCSNewsViewModel.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HCSNewsItem;

@interface HCSNewsViewModel : NSObject

@property (nonatomic, strong) HCSNewsItem *newsItem;


/**
 *  TopView的frame
 */
@property (nonatomic,assign) CGRect topViewFrame;

// middleView(Picture)的frame
@property (nonatomic,assign) CGRect middleViewFrame;

// 底部view
@property (nonatomic, assign) CGRect bottomViewFrame;

/**
 *  newsCell的高度，即整个cell的高度
 */
@property (nonatomic,assign) CGFloat cellHeight;

@end
