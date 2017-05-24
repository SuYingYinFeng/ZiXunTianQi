//
//  HCSMineGroupItem.h
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/12.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSMineGroupItem : NSObject

//头部标题
@property (strong, nonatomic) NSString *headerT;
//尾部标题
@property (strong, nonatomic) NSString *footerT;
//一组当中有多少行
@property (strong, nonatomic) NSArray *rowItemArray;

+ (instancetype)groupItemWithRowArray:(NSArray *)rowArray;



@end
