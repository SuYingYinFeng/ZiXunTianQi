//
//  NSString+hanziTopinyin.m
//  ZiXun Weather
//
//  Created by 黄灿森 on 16/5/27.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "NSString+hanziTopinyin.h"

@implementation NSString (hanziTopinyin)

+ (NSString *)stringToPinyinWithHanziString:(NSString *)hanziString isMandarinLatin:(BOOL)isMandarinLatin
{
    NSUInteger strlenght = hanziString.length;
    if (strlenght == 0) return nil;
    NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziString];
    
    
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
    }
    
    if (isMandarinLatin) return ms;
    
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        
        for (NSInteger i = 0 ; i < strlenght - 1; i++) {
            NSRange range = [ms rangeOfString:@" "];
            [ms deleteCharactersInRange:range];
            
        }
    }
    return ms;
}

- (void)topinyin
{
    
    NSMutableArray *mTemp = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityChinaName" ofType:@"plist"];
    
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    
    NSString *str = nil;
    
    for (NSDictionary *dict in dictArray) {
        
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
        
        [mutableDict setValuesForKeysWithDictionary:dict];
        
        str = [NSString stringToPinyinWithHanziString:dict[@"city"] isMandarinLatin:NO];
        
        [mutableDict setValue:str forKey:@"cityE"];
        
        NSDictionary *cityContentDict = (NSDictionary *)mutableDict;
        
        [mTemp addObject:cityContentDict];
        
    }
    
    
    NSArray *cityArray = (NSArray *)mTemp;
    
    [cityArray writeToFile:@"/Users/huangcansen/Desktop/cityName.plist" atomically:YES];
}

@end

