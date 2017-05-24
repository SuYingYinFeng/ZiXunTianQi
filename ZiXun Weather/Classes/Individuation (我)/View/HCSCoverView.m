//
//  HCSCoverView.m
//  彩票HCS
//
//  Created by 黄灿森 on 16/3/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSCoverView.h"

@implementation HCSCoverView

/**
 *  弹出一个遮盖
 */
+ (void)show
{
    //显示到最外面东西,都是添加到窗口上面的.
    //如果一个控件为透明,那么它里面的子控件全部为透明.
    HCSCoverView *coverView = [[HCSCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.alpha = 0.6;
    coverView.backgroundColor = [UIColor blackColor];
    
    //添加到窗口([UIApplication sharedApplication].keyWindow)获取当前主窗口
    [[UIApplication sharedApplication].keyWindow addSubview:coverView];
    

}

@end
