//
//  HCSNewsViewModel.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSNewsViewModel.h"
#import "HCSNewsItem.h"

static CGFloat const space = 8;

@implementation HCSNewsViewModel

#pragma mark - 计算好每个cell的高度
- (void)setNewsItem:(HCSNewsItem *)newsItem
{
    _newsItem = newsItem;
    
/***************** 1.计算topView的高度,设置topView的frame,更新cell的高度 **************************/
    
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = HCSScreenW;
    CGFloat topViewH = 0;
    
    CGFloat textTitleW = HCSScreenW - 2 * space - 40;
    NSString *text = [newsItem title];
    // 注意：计算文字高度，使用constrainedToSize
    CGFloat textTitleH = [text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(textTitleW, MAXFLOAT)].height;
    
    CGFloat textContentW = HCSScreenW - 2 * space;
    NSString *textContent = [newsItem content];
    // 注意：计算文字高度，使用constrainedToSize
    CGFloat textContentH = [textContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(textContentW, MAXFLOAT)].height;
    
    topViewH = textContentH + textTitleH + 2 * space;
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    _cellHeight = CGRectGetMaxY(_topViewFrame) + space;
    
/***************** 2.计算中间view，判断是否计算,更新cell的高度 **************************/
    
    if (![newsItem.img  isEqual: @""]) {
        CGFloat middleX = space;
        CGFloat middleY = _cellHeight;
        CGFloat middleW = textContentW;
        CGFloat widthValue = [newsItem.img_length floatValue];
        CGFloat heightValue = [newsItem.img_width floatValue];
         CGFloat middleH = textContentW / widthValue * heightValue;
//        if (middleH > HCSScreenH) { // 大图
//            middleH = 300;
//            // 记录是否是大图
//            newsItem.is_bigPicture = YES;
//        }
        _middleViewFrame = CGRectMake(middleX, middleY, middleW, middleH);
        
        _cellHeight = CGRectGetMaxY(_middleViewFrame) + space;
    }

    
/***************** 3.计算底部View,更新cell的高度 **************************/
    
    CGFloat bottomX = 0;
    CGFloat bottomY = _cellHeight;
    CGFloat bottomW = HCSScreenW;
    CGFloat bottomH = 17 * 2 + 8 * 3;
    _bottomViewFrame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    _cellHeight = CGRectGetMaxY(_bottomViewFrame) + space;
}


@end
