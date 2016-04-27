//
//  Game.h
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/26.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, assign) NSUInteger numPlay;
@property (nonatomic, strong) NSString *urlPlay;
@property (nonatomic, strong) NSString *imgLogo;
@property (nonatomic, strong) NSString *desc;


@end
