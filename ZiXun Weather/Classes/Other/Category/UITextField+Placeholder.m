//
//  UITextField+Placeholder.m
//  BuDeJie
//
//  Created by xmg on 16/4/28.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

+ (void)load
{
    // 获取方法实现
    Method  setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method  setXmg_placeholderMethod = class_getInstanceMethod(self, @selector(setXMG_placeholder:));
    method_exchangeImplementations(setPlaceholderMethod, setXmg_placeholderMethod);
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
   // 把属性保存到系统的类 runtime动态添加属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

// 设置占位文字并且还要设置占位文字颜色
- (void)setXMG_placeholder:(NSString *)placeholder
{
    [self setXMG_placeholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;

}
@end
