//
//  HCSFileManager.h
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/5/3.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

/*
 作用：处理文件尺寸
 */
/*
 业务类细节
 1.一定要在类最前面 告诉别人这个类干嘛用的
 2.方法一定要用文档注释
 3.方法的实现要严谨，考虑到各种不利情况
 */
#import <Foundation/Foundation.h>

@interface HCSFileManager : NSObject
/**
 *  指定一个文件夹全路径，就获取文件夹大小
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹大小
 */
+ (NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath;

/**
 *  指定一个文件夹路径，删除
 *
 *  @param directoryPath 文件夹全路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
