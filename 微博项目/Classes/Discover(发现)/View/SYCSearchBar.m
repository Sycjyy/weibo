//
//  SYCSearchBar.m
//  微博项目
//
//  Created by sycjyy on 15/10/17.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCSearchBar.h"
#import "UIImage+Image.h"
#import "UIView+Frame.h"

@implementation SYCSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        
        self.leftView = imageV;
        
        self.font = [UIFont systemFontOfSize:13];
        //
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
