//
//  UIView+Frame.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/4/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setHcs_x:(CGFloat)hcs_x
{
    CGRect frame = self.frame;
    frame.origin.x = hcs_x;
    self.frame = frame;
}

- (void)setHcs_y:(CGFloat)hcs_y
{
    CGRect frame = self.frame;
    frame.origin.y = hcs_y;
    self.frame = frame;
}

- (void)setHcs_width:(CGFloat)hcs_width
{
    CGRect frame = self.frame;
    frame.size.width = hcs_width;
    self.frame = frame;
}

- (void)setHcs_height:(CGFloat)hcs_height
{
    CGRect frame = self.frame;
    frame.size.height = hcs_height;
    self.frame = frame;
}

- (CGFloat)hcs_x
{
    return self.frame.origin.x;
}

- (CGFloat)hcs_y
{
    return self.frame.origin.y;
}

- (CGFloat)hcs_width
{
    return self.frame.size.width;
}

- (CGFloat)hcs_height
{
    return self.frame.size.height;
}


@end
