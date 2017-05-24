//
//  HCSMineCell.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSMineCell.h"

@implementation HCSMineCell

- (void)awakeFromNib {
    // Initialization code
}


#pragma mark - 只要一个控件调用Init方法创建，底层就会调用initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - 通过代码初始化cell就会调用这个
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 不要cell选中样式,注意：只是选中cell没有效果，但是cell还是可以选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置cell背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:[HCSResizeImageTool HCSResizeImageWithImageName:@"mainCellBackground"]];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
