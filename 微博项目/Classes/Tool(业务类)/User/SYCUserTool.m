//
//  SYCUserTool.m
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCUserTool.h"

#import "SYCUser.h"
#import "SYCUserParam.h"
#import "SYCUserResult.h"

#import "SYCHttpTool.h"
#import "SYCAccountTool.h"
#import "SYCAcconut.h"

#import "MJExtension.h"

@implementation SYCUserTool

+ (void)unreadWithSuccess:(void (^)(SYCUserResult *))success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    SYCUserParam *param = [SYCUserParam param];
    param.uid = [SYCAccountTool account].uid;
    
    [SYCHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转换模型
        SYCUserResult *result = [SYCUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
        
    }];
}

+ (void)userInfoWithSuccess:(void (^)(SYCUser *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    SYCUserParam *param = [SYCUserParam param];
    param.uid = [SYCAccountTool account].uid;
    
    [SYCHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 用户字典转换用户模型
        SYCUser *user = [SYCUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
