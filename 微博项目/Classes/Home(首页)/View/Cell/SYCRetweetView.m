//
//  SYCRetweetView.m
//  微博项目
//
//  Created by sycjyy on 15/11/4.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCRetweetView.h"

#import "SYCStatusFrame.h"
#import "SYCStatus.h"
#import "SYCPhotosView.h"
#import "UIImage+Image.h"


@interface SYCRetweetView()

// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;

//配图
@property (nonatomic, weak) SYCPhotosView *photosView;
@end
@implementation SYCRetweetView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

- (void)setUpAllChildView{
    //name
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = SYCNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    //text
    UILabel *textView = [[UILabel alloc] init];
    textView.font = SYCTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    //配图
    SYCPhotosView *photosView = [[SYCPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}

- (void)setStatusF:(SYCStatusFrame *)statusF{
    _statusF = statusF;
    
    [self setUpFrame];
    
    [self setUpData];
}

- (void)setUpFrame{
    _nameView.frame = _statusF.retweetNameFrame;
    
    _textView.frame = _statusF.retweetTextFrame;
    
    _photosView.frame = _statusF.retweetPhotosFrame;
}

- (void)setUpData{
    
    SYCStatus *status = _statusF.status;
    
    _nameView.text = status.retweetName;
    
    _textView.text = status.retweeted_status.text;
    
    _photosView.pic_urls = status.retweeted_status.pic_urls;
    
}

@end
