//
//  SYCAccountTool.m
//  微博项目
//
//  Created by sycjyy on 15/10/18.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCAccountTool.h"
#import "SYCAcconut.h"
#define SYCAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation SYCAccountTool

// 类方法一般用静态变量代替成员属性
static SYCAcconut *_account;
+(void)saveAccount:(SYCAcconut *)account{
    
    [NSKeyedArchiver archiveRootObject:account toFile:SYCAccountFileName];
}

+(SYCAcconut *)account{
    
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:SYCAccountFileName];
        //判断是否过期
        if ( [[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}

@end
