//
//  SYCStatusCacheTool.h
//  微博项目
//
//  Created by sycjyy on 15/11/7.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYCStatusParam;
@interface SYCStatusCacheTool : NSObject

// statuses:模型数组（SYCStatus）
+ (void)saveWithStatuses:(NSArray *)statuses;

+ (NSArray *)statusesWithParam:(SYCStatusParam *)param;

@end
