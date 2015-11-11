//
//  SYCBaseParam.h
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;
@end
