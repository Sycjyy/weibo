//
//  SYCUserTool.h
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYCUserResult,SYCUser;
@interface SYCUserTool : NSObject

/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(SYCUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(SYCUser *user))success failure:(void(^)(NSError *error))failure;


@end
