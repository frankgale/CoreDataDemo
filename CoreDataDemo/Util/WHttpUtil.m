//
//  WHttpUtil.m
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/26.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "WHttpUtil.h"

@implementation WHttpUtil

- (NSURLSession *)urlSession{
    if (!_urlSession) {
        _urlSession = [NSURLSession sharedSession];
    }
    return _urlSession;
}

#pragma mark ----- 下载文件
- (void)downloadWithData:(NSURL *)url success:(FResult)result faile:(Faile)faile{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [self.urlSession downloadTaskWithRequest:request];
    NSURLSessionDownloadTask *loadTask = [self.urlSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            faile(error);
        } else {
            result(location);
        }
    }];
    [loadTask resume];

}


#pragma mark ----- 上传文件



#pragma mark ----- 请求数据
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"get"];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setAllHTTPHeaderFields:params];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(data);
        }
    }];
    [dataTask resume];
}


+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    NSArray *keys = [params allKeys];
    NSArray *values = [params allValues];
    NSString *content = [[NSString alloc] init];
    for (int i = 0; i < keys.count; i++) {
        content = [content stringByAppendingString:keys[i]];
        content = [content stringByAppendingString:@"="];
        content = [content stringByAppendingString:values[i]];
        if (i == keys.count - 1) {
            
        } else {
            content = [content stringByAppendingString:@"&"];
        }
    }
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(data);
        }
    }];
    [dataTask resume];
}


@end
