//
//  SYCStatusResult.m
//  微博项目
//
//  Created by sycjyy on 15/10/19.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCStatusResult.h"
#import "SYCStatus.h"

@implementation SYCStatusResult
//自动把字典数组转换成对应的类的数组
+(NSDictionary *)objectClassInArray{
    return @{@"statuses":[SYCStatus class]};
}
@end
