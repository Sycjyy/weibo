//
//  SYCStatusTool.h
//  微博项目
//
//  Created by sycjyy on 15/10/19.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//  处理微博数据类

#import <Foundation/Foundation.h>

@interface SYCStatusTool : NSObject
/**
 *  请求更新的数据
 *
 */
+(void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

+(void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;
@end
