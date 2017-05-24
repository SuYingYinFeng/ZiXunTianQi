//
//  HCSSettingCell.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCSSettingItem;

@interface HCSSettingCell : UITableViewCell

//快速的创建一个Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

//@property (strong, nonatomic) HCSSettingItem *rowSettingItem;


@end
