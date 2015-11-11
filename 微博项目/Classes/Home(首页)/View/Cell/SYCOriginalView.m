//
//  SYCOriginalView.m
//  微博项目
//
//  Created by sycjyy on 15/11/4.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCOriginalView.h"

#import "SYCStatusFrame.h"
#import "SYCStatus.h"
#import "SYCPhotosView.h"

#import "UIImage+Image.h"
#import "UIImageView+WebCache.h"

@interface SYCOriginalView()

// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;

// 正文
@property (nonatomic, weak) SYCPhotosView *photosView;

@end
@implementation SYCOriginalView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加所有的子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}

- (void)setUpAllChildView {
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    //昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = SYCNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    //vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    //time
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = SYCTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    //source
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.textColor = [UIColor lightGrayColor];
    sourceView.font = SYCSourceFont;
    [self addSubview:sourceView];
    _sourceView =sourceView;
    
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
    
    _iconView.frame = _statusF.originalIconFrame;
    
    _nameView.frame = _statusF.originalNameFrame;
    
    if (_statusF.status.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    
    // 时间 每次有新的时间都需要计算时间frame
    SYCStatus *status = _statusF.status;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY( _nameView.frame) + SYCStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:SYCTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + SYCStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SYCSourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    _textView.frame = _statusF.originalTextFrame;
    
    _photosView.frame = _statusF.originalPhotosFrame;
}

- (void)setUpData{
    
    SYCStatus *status = _statusF.status;
    
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    
    _vipView.image = image;
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
    
    
    // 配图
    _photosView.pic_urls = status.pic_urls;
    
    
}

@end
