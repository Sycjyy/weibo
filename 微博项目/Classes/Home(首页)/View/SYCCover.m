//
//  SYCCover.m
//  微博项目
//
//  Created by sycjyy on 15/10/17.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCCover.h"

@implementation SYCCover

-(void)setDimBackground:(BOOL)dimBackground{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
    }
}

+(instancetype)show{
    SYCCover *cover = [[SYCCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    return cover;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        [self.delegate coverDidClickCover:self];
    }
}


@end
