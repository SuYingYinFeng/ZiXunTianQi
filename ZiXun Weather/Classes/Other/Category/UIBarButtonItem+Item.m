//
//  UIBarButtonItem+Item.m
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/4/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)NormalImage HighlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:NormalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
//    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:button.bounds];
    [contentView addSubview:button];
    
    // 如果把按钮包装成UIBarButtonItem，点击范围会扩大，把按钮放在UIView,在把UIView包装成UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)NormalImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:NormalImage forState:UIControlStateNormal];
    [button setImage:selImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:button.bounds];
    [contentView addSubview:button];
    
    // 如果把按钮包装成UIBarButtonItem，点击范围会扩大，把按钮放在UIView,在把UIView包装成UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

@end
