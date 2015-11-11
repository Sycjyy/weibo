//
//  SYCAcconut.m
//  微博项目
//
//  Created by sycjyy on 15/10/18.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCAcconut.h"

#define SYCAcconutTokenKey @"token"
#define SYCExpires_inKey @"expires"
#define SYCUidKey @"uid"
#define SYCExpires_dateKey @"date"
#define SYCNameKey @"name"

@implementation SYCAcconut

+(instancetype)acconutWithDict:(NSDictionary *)dict{
    SYCAcconut *acconut = [[self alloc] init];
    
    [acconut setValuesForKeysWithDictionary:dict];
    
    return acconut;
}

-(void)setExpires_in:(NSString *)expires_in{
    _access_token = expires_in;
    
    //过期时间 ＝ 当前时间 ＋ 有效期
    
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

//文件归档的时候要用
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_access_token forKey:SYCAcconutTokenKey];
    [aCoder encodeObject:_expires_in forKey:SYCExpires_inKey];
    [aCoder encodeObject:_expires_date forKey:SYCExpires_dateKey];
    [aCoder encodeObject:_uid forKey:SYCUidKey];
    [aCoder encodeObject:_name forKey:SYCNameKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        //注意:一定要赋值
        _uid = [aDecoder decodeObjectForKey:SYCUidKey];
        _expires_date = [aDecoder decodeObjectForKey:SYCExpires_dateKey];
        _expires_in = [aDecoder decodeObjectForKey:SYCExpires_inKey];
        _access_token = [aDecoder decodeObjectForKey:SYCAcconutTokenKey];
        _name = [aDecoder decodeObjectForKey:SYCNameKey];
    }
    return self;
}
@end
