//
//  SYCBaseParam.m
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCBaseParam.h"
#import "SYCAccountTool.h"
#import "SYCAcconut.h"

@implementation SYCBaseParam

+(instancetype)param{
    SYCBaseParam *param = [[self alloc] init];
    
    param.access_token = [SYCAccountTool account].access_token;
    
    return param;

}

@end
