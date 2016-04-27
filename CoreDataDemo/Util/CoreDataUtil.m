//
//  CoreDataUtil.m
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/23.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "CoreDataUtil.h"

@implementation CoreDataUtil

+ (void)insertEntityWithEntityName:(NSString *)entityName andProperties:(NSDictionary *)dict andClassName:(NSString *)className andSuccess:(Success)success andFaile:(Faile)faile{
    Class c = NSClassFromString(className);
     AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(c, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        id value = [dict valueForKey:key];
        if (value) {
            [entity setValue:value forKey:key];
        }
    }
    NSError *error;
    if ([context save:&error]) {
        success(entity);
    } else {
        if (faile) {
            faile(error);
        }
    }
}

+ (void)selectEntitiesFromCoreDataWithEntityName:(NSString *)entityName andBegin:(NSInteger)begin andLength:(NSInteger)length andResult:(Result)result andFaile:(Faile)faile{
    NSArray *array;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.fetchOffset = begin;
    request.fetchLimit = length;
    NSError *error;
    array = [context executeFetchRequest:request error:&error];
    if (!error) {
        result(array);
    } else {
        if (faile) {
            faile(error);
        }
    }
}

+ (void)deleteEntityWithEntityName:(NSString *)entityName andBegin:(NSUInteger)begin andLength:(NSUInteger)length andFaile:(Faile)faile{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (!error) {
        for (int i = 0; i < array.count; i++) {
            if (i >= begin && i <= length) {
                [context deleteObject:array[i]];
            }
        }
        [delegate saveContext];
    } else{
        if (faile) {
            faile(error);
        }
    }
}

@end
