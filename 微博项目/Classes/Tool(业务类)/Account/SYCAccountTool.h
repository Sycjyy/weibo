//
//  SYCAccountTool.h
//  微博项目
//
//  Created by sycjyy on 15/10/18.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYCAcconut;
@interface SYCAccountTool : NSObject

+(void)saveAccount:(SYCAcconut *)account;

+(SYCAcconut *)account;
@end
