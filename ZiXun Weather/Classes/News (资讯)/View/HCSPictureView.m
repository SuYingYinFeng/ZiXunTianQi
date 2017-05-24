//
//  HCSPictureView.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/15.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSPictureView.h"
#import <DALabeledCircularProgressView.h>
#import <UIImageView+WebCache.h>
#import "HCSNewsItem.h"
#import "HCSLoadImageManager.h"

@interface HCSPictureView ()

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *pictureProgressView;

@property (weak, nonatomic) IBOutlet UIImageView *newsPicture;

@end

@implementation HCSPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    _pictureProgressView.roundedCorners = 10;
    _pictureProgressView.progressLabel.textColor = [UIColor whiteColor];
    
}

+ (instancetype)loadPictureViewForCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


#pragma mark - 重写pictureViewNewsItem setter
- (void)setPictureViewNewsItem:(HCSNewsItem *)pictureViewNewsItem
{
    _pictureViewNewsItem = pictureViewNewsItem;
    
    NSString *imageURL = pictureViewNewsItem.img;
    imageURL = [imageURL stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    [HCSLoadImageManager hcs_setImageWithURL:imageURL placeholderImage:nil progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        if (expectedSize < 0) return;
        // expectedSize 下载总量
        // receivedSize:下载量
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        _pictureProgressView.progress = progress;
        _pictureProgressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        

        
    } imageView:_newsPicture];

    
}

@end
