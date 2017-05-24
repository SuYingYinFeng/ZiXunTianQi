//
//  HCSResizeImageTool.m
//  资讯天气
//
//  Created by 黄灿森 on 16/4/24.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSResizeImageTool.h"

@implementation HCSResizeImageTool

+ (UIImage *)HCSResizeImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];

    return image;
}

@end
