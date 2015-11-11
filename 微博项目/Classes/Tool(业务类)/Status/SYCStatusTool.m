//
//  SYCStatusTool.m
//  微博项目
//
//  Created by sycjyy on 15/10/19.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCStatusTool.h"

#import "SYCHttpTool.h"
#import "SYCStatus.h"
#import "SYCAccountTool.h"
#import "SYCAcconut.h"

#import "SYCStatusParam.h"
#import "SYCStatusResult.h"

#import "MJExtension.h"
#import "SYCStatusCacheTool.h"


@implementation SYCStatusTool

+(void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure{
    
    SYCStatusParam *param = [[SYCStatusParam alloc]init];
    param.access_token = [SYCAccountTool account].access_token;
    if (sinceId) {
        param.since_id = sinceId;
    }
    
    NSArray *statuses = [SYCStatusCacheTool statusesWithParam:param];
    
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    [SYCHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        //获得微博字典数组
        SYCStatusResult *result = [SYCStatusResult objectWithKeyValues:responseObject];
       
        if (success) {
            success(result.statuses);
        }
        
        [SYCStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
      
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure{
    
    SYCStatusParam *param = [[SYCStatusParam alloc] init];
    param.access_token = [SYCAccountTool account].access_token;
    if (maxId) {
        param.max_id = maxId;
    }
    
    NSArray *statuses = [SYCStatusCacheTool statusesWithParam:param];
    
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    [SYCHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        //获得微博字典数组
        SYCStatusResult *result = [SYCStatusResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
        
        [SYCStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
