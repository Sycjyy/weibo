//
//  UIImage+Image.h
//  微博项目
//
//  Created by sycjyy on 15/10/14.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+(instancetype)imageWithStretchableName:(NSString *)imageName;
@end
