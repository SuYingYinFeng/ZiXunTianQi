//
//  HCSPopView.m
//  彩票HCS
//
//  Created by 黄灿森 on 16/3/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSPopView.h"

@implementation HCSPopView

/**
 *  弹出PopView到指定的定
 *
 *  @param point 指定的点
 */
+ (HCSPopView *)showPopViewCenterInPoint:(CGPoint)point
{
    HCSPopView *popView = [[NSBundle mainBundle] loadNibNamed:@"HCSPopView" owner:nil options:nil][0];
    popView.center = point;
    
    //添加到窗口
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    
    return popView;
}

/**
 *  隐藏到指定的点
 *
 *  @param point 指定的点
 *  @param completion 隐藏完成时要执行的代码
 */
- (void)hiddenInPoint:(CGPoint)point completion:(void (^)())completion
{
    [UIView animateWithDuration:0.5 animations:^{
        self.center = point;
        //缩放动画
        self.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
        
    } completion:^(BOOL finished) {
        //把当前view移除
        [self removeFromSuperview];
        
        //执行传入的代码
        completion();
        
    }];
}


/**
 *  关闭按钮点击时调用
 *
 *  @param sender UIButton
 */
- (IBAction)cloceButtonClick:(UIButton *)sender {

    //通知代理
    if ([self.delegate respondsToSelector:@selector(popViewClickCloceButton:)]) {
        [self.delegate popViewClickCloceButton:self];
    }
    NSLog(@"1123123");
}


@end
