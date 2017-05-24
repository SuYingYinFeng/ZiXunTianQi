//
//  UIImage+OriginalImage.m
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/4/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIImage+OriginalImage.h"

@implementation UIImage (OriginalImage)

+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    //返回一张原始图片
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;

}

@end
