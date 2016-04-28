//
//  JsonUtil.h
//  FGBase
//
//  Created by Ken Feng on 16/4/20.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject

/**
 *  data转字典
 *
 *  @param data数据
 *
 *  @return 字典
 */
+ (NSDictionary *)DataToDict:(NSData *)data;

/**
 *  字典转对象
 *
 *  @param cName   类名
 *  @param dic 字典
 *
 *  @return 转好的对象
 */
+ (id)DictToModel:(NSString *)cName andDict:(NSDictionary *)dic;

/**
 *  数据转对象
 *
 *  @param cName 类名
 *  @param data  数据
 *
 *  @return 对象数组
 */
+ (NSArray *)DataToModel:(NSString *)cName andData:(NSData *)data;


@end
