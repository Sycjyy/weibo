//
//  SYCHttpTool.h
//  微博项目
//
//  Created by sycjyy on 15/10/19.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYCUploadParam;
@interface SYCHttpTool : NSObject
/**
 *  发送POST请求
 *  parameters :请求参数
 *  
 */
+ (void) POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  发送GET请求
 *  parameters :请求参数
 *
 */
+ (void) GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  上传请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(SYCUploadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;


@end
