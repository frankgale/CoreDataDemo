//
//  CoreDataUtil.h
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/23.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <objc/runtime.h>

typedef void(^ Success)(NSManagedObject *obj);//成功
typedef void(^ Faile)(NSError *error);//报错
typedef void(^ Result)(NSArray *array);//结果
@interface CoreDataUtil : NSObject

/**
 *  将对象插入到coredata中
 *
 *  @param entityName 实体名称
 *  @param dict       对象数据字典
 *  @param className  对象类名
 */
+ (void)insertEntityWithEntityName:(NSString *)entityName andProperties:(NSDictionary *)dict andClassName:(NSString *)className andSuccess:(Success)success andFaile:(Faile)faile;

/**
 *  将对象数据从coredata中取出
 *
 *  @param entityName 实体名称
 *  @param begin      开始位置
 *  @param length     长度
 *
 *  @return 查询到的对象数组
 */
+ (void)selectEntitiesFromCoreDataWithEntityName:(NSString *)entityName andBegin:(NSInteger)begin andLength:(NSInteger)length andResult:(Result)result andFaile:(Faile)faile;

/**
 *  将数据从coredata中删除
 *  @param begin      开始位置
 *  @param length     长度
 *
 *  @param entityName 实体名称
 */
+ (void)deleteEntityWithEntityName:(NSString *)entityName andBegin:(NSUInteger)begin andLength:(NSUInteger)length andFaile:(Faile)faile;

@end
