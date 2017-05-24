//
//  HCSPopView.h
//  彩票HCS
//
//  Created by 黄灿森 on 16/3/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCSPopView;

@protocol  HCSPopViewDelegate <NSObject>

- (void)popViewClickCloceButton:(HCSPopView *)popView;

@end

@interface HCSPopView : UIView

/**
 *  弹出PopView到指定的定
 *
 *  @param point 指定的点
 */
+ (HCSPopView *)showPopViewCenterInPoint:(CGPoint)point;

/**
 *  隐藏到指定的点
 *
 *  @param point 指定的点
 */
- (void)hiddenInPoint:(CGPoint)point completion:(void (^)())completion;

//代理属性
@property (nonatomic,weak) id <HCSPopViewDelegate> delegate;

@end
