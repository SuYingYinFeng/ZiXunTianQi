//
//  HCSSettingItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/14.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HCSRowSettingTypeArrow,
    HCSRowSettingTypeSwitch,
    HCSRowSettingTypeDetail,
} HCSSettingRowType;

@interface HCSSettingItem : NSObject

@property (strong, nonatomic) UIImage *cellImage;
@property (strong, nonatomic) NSString *cellTitle;
@property (strong, nonatomic) NSString *cellDetailText;

//行当中右侧辅助视图的类型
@property (nonatomic, assign) HCSSettingRowType settingRowType;

//设置要跳转的控制器的名称
@property (nonatomic , assign) Class ToPushViewClass;

//要执行的代码
@property (nonatomic ,copy)void(^operationSettingTask)(NSIndexPath *indexPath);

//当前开关状态
@property (nonatomic, assign) BOOL switchState;

+ (instancetype)settingItemWithImage:(UIImage *)image title:(NSString *)title;

@end
