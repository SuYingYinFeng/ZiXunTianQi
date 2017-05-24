//
//  HCSFileManager.m
//  BaiSiBuDeJie
//
//  Created by 黄灿森 on 16/5/3.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "HCSFileManager.h"

@implementation HCSFileManager



#pragma mark - 指定一个文件夹路径，就获取文件夹尺寸
+ (NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath
{
    // 1.获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    // 判断是否传入进来 是不是文件夹路径
    // 判断是否是文件夹
    BOOL isDirectory = NO;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 直接报错
        // name:异常名字
        // reason:异常原因
        NSException *exception = [NSException exceptionWithName:@"FilePathErrer" reason:@"the file path must be the full file path and the file directory must be exist" userInfo:nil];
    
        [exception raise];
    };
    
    // 2.获取文件夹里面所有文件全路径
    // subpathsAtPath:获取文件夹里面所有子路径,把所有子级目录全部获取
    NSArray *subPaths = [manager subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    for (NSString *subPath in subPaths) {
        // 获取文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 如果是隐藏文件 或者 文件夹 不需要计算 优化
        if ([filePath containsString:@".DS"]) continue;
        
        // 判断是否是文件夹
        BOOL isDirectory = NO;
        BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if (!isExist || isDirectory) continue;
        
        // 获取文件尺寸
        NSInteger fileSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        totalSize += fileSize;
        
    }
    
    return totalSize;
}

#pragma mark - 指定一个文件夹路径，删除
+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    // 1.获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    // 判断是否传入进来 是不是文件夹路径
    // 判断是否是文件夹
    BOOL isDirectory = NO;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 直接报错
        // name:异常名字
        // reason:异常原因
        NSException *exception = [NSException exceptionWithName:@"FilePathErrer" reason:@"the file path must be the full file path and the file directory must be exist" userInfo:nil];
        
        [exception raise];
    };
    // 获取文件夹里面所有子文件,只能获取下一级
    NSArray *contentsPath = [manager contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *contentPath in contentsPath) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:contentPath];
        [manager removeItemAtPath:filePath error:nil];
    }
    

}

@end
