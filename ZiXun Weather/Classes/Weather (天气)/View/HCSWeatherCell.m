//
//  HCSWeatherCell.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSWeatherCell.h"


@interface HCSWeatherCell ()

@end

@implementation HCSWeatherCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.image = [HCSResizeImageTool HCSResizeImageWithImageName:@"hour_info_bg"];
    self.backgroundView = backgroundImageView;

}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

// 只要一个控件调用Init方法创建，底层就会调用initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

// 通过代码初始化cell就会调用这个
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
  
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
