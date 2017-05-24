//
//  UIBarButtonItem+Item.h
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/4/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)NormalImage HighlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)NormalImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

@end
