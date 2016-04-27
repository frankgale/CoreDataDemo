//
//  WHttpUtil.h
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/26.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Faile)(NSError *error);
typedef void(^FResult)(NSURL *url);
@interface WHttpUtil : NSObject
@property (nonatomic, strong) NSURLSession *urlSession;

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure ;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

- (void)downloadWithData:(NSURL *)url success:(FResult)result faile:(Faile)faile;
@end
