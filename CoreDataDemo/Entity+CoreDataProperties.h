//
//  Entity+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/23.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *passWord;

@end

NS_ASSUME_NONNULL_END
