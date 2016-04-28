//
//  JsonUtil.m
//  FGBase
//
//  Created by Ken Feng on 16/4/20.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "JsonUtil.h"
#import <objc/runtime.h>

@implementation JsonUtil

+ (NSDictionary *)DataToDict:(NSData *)data{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"error:%@", error);
        return nil;
    }
    return dic;
}

+ (id)DictToModel:(NSString *)cName andDict:(NSDictionary *)dic{
    Class c = NSClassFromString(cName);
    id objc = [c new];
    NSMutableArray *keys = [NSMutableArray new];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(c, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        [keys addObject:key];
    }
    for (NSString *key in keys) {
        id value = [dic valueForKey:key];
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

+ (NSArray *)DataToModel:(NSString *)cName andData:(NSData *)data{
    NSDictionary *dict = [self DataToDict:data];
    NSArray *array = [dict valueForKey:@"data"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        id objc = [self DictToModel:cName andDict:array[i]];
        [mutableArray addObject:objc];
    }
    return mutableArray;
}


@end
