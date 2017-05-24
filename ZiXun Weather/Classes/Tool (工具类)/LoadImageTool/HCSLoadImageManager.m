//
//  HCSLoadImageManager.m
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/5/5.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSLoadImageManager.h"

@implementation HCSLoadImageManager

+ (void)hcs_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock imageView:(UIImageView *)imageView
{
    // 判断下 SDWebImage有没有做过缓存，如果做过，就直接获取缓存图片，就不需要加载
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    
    if (cacheImage) {
        imageView.image = cacheImage;
    }else
    {
        //上网获取图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
    }
    
}

@end
