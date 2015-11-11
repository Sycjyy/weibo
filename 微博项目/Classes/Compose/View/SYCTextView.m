//
//  SYCTextView.m
//  微博项目
//
//  Created by sycjyy on 15/11/10.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTextView.h"

@interface SYCTextView ()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation SYCTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        
        UILabel *label = [[UILabel alloc] init];
        
        
        [self addSubview:label];
        
        _placeHolderLabel = label;
        
    }
    
    return _placeHolderLabel;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    // label的尺寸跟文字一样
    [self.placeHolderLabel sizeToFit];
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    
    
    self.placeHolderLabel.hidden = hidePlaceHolder;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
    
    //    NSLog(@"%@",self.font);
    //    self.placeHolderLabel.font = self.font;
}


@end
