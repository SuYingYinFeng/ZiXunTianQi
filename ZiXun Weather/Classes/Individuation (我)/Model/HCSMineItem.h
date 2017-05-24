//
//  HCSMineItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/12.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    HCSRowTypeArrow,
    HCSRowTypeSwitch,
    HCSRowTypeDefault,
    HCSRowTypeNew,
    HCSRowTypeAD
} HCSRowType;

static NSString * const accountNameKey = @"mineAccountName";

@interface HCSMineItem : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *cellLabelText;
@property (nonatomic, strong) NSString *accountName;

//行当中右侧辅助视图的类型
@property (nonatomic, assign) HCSRowType rowType;

//设置要跳转的控制器的名称
@property (nonatomic , assign) Class ToPushClass;

//要执行的代码
@property (nonatomic ,copy)void(^operationTask)(NSIndexPath *indexPath);


+ (instancetype)settingItemWithImage:(UIImage *)image title:(NSString *)title;

@end
