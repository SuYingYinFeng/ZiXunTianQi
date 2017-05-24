//
//  HCSNewsItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSNewsItem : NSObject
/**
 *  新闻标题
 */
@property (nonatomic,strong) NSString *title;
/**
 *  新闻摘要
 */
@property (nonatomic,strong) NSString *content;

/**
 *  新闻全标题
 */
@property (nonatomic,strong) NSString *full_title;
/**
 *  发布时间
 */
@property (nonatomic,strong) NSString *pdate;
/**
 *  新闻链接
 */
@property (nonatomic,strong) NSString *url;
/**
 *  新闻配图链接(可能为空)
 */
@property (nonatomic,strong) NSString *img;
/**
 *  配图宽度
 */
@property (nonatomic,strong) NSString *img_length;
/**
 *  配图高度
 */
@property (nonatomic,strong) NSString *img_width;

@property (nonatomic,assign) BOOL is_bigPicture;
/**
 *  发布全时间 yyyy-MM-dd HH-mm-ss
 */
@property (nonatomic,strong) NSString *pdate_src;
/**
 *  新闻来源
 */
@property (nonatomic,strong) NSString *src;


@end
