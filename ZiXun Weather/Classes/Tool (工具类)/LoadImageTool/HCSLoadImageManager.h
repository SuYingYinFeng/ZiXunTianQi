//
//  HCSLoadImageManager.h
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/5/5.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIImageView+WebCache.h>

@interface HCSLoadImageManager : NSObject

/**
*   加载图片
*
*  @param urlStr         图片url
*  @param placeholder    图片占位图片
*  @param progressBlock  加载过程中回调
*  @param completedBlock 加载完成，回调
*  @param imageView      要加载图片的控件
*/

+ (void)hcs_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock imageView:(UIImageView *)imageView;


@end
