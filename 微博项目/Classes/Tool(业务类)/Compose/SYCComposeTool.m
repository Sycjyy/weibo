//
//  SYCComposeTool.m
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCComposeTool.h"
#import "SYCComposeParam.h"
#import "SYCUploadParam.h"
#import "SYCHttpTool.h"
#import "MJExtension.h"

@implementation SYCComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    SYCComposeParam *param = [SYCComposeParam param];
    param.status = status;
    
    [SYCHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    SYCComposeParam *param = [SYCComposeParam param];
    param.status = status;
    
    // 创建上传的模型
    SYCUploadParam *uploadP = [[SYCUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：以后如果一个方法，要传很多参数，就把参数包装成一个模型
    [SYCHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

@end
