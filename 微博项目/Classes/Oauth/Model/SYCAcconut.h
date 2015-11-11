//
//  SYCAcconut.h
//  微博项目
//
//  Created by sycjyy on 15/10/18.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "access_token" = "2.00nqMxdF0CKKoqaf2be168cc0p56Fy";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5171052017;
 */
@interface SYCAcconut : NSObject<NSCoding>
/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  账户的唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  账户的有效期
 */
@property (nonatomic, copy) NSString *remind_in;
/**
 *  过期时间
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;



+(instancetype)acconutWithDict:(NSDictionary *)dict;

@end
