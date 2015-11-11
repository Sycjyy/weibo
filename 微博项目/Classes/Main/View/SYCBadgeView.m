//
//  SYCBadgeView.m
//  微博项目
//
//  Created by sycjyy on 15/10/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCBadgeView.h"
#import "UIView+Frame.h"

#define SYCBadgeViewFont [UIFont systemFontOfSize:11]

@implementation SYCBadgeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = SYCBadgeViewFont;
        
        [self sizeToFit];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    //判断badgeValue是否有值  这里要用badgeValue，而不能用_badgeValue 否则会出错
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithFont:SYCBadgeViewFont];
    
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}


@end
