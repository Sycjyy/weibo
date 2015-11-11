//
//  SYCStatusFrame.m
//  微博项目
//
//  Created by sycjyy on 15/10/21.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCStatusFrame.h"
#import "SYCStatus.h"
#import "SYCUser.h"

//
//#define SYCStatusCellMargin 10
//#define SYCNameFont [UIFont systemFontOfSize:13]
//#define SYCTimeFont [UIFont systemFontOfSize:12]
//#define SYCSourceFont CZTimeFont
//#define SYCTextFont [UIFont systemFontOfSize:15]
//#define SYCScreenW [UIScreen mainScreen].bounds.size.width


@implementation SYCStatusFrame

- (void)setStatus:(SYCStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = SYCStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + SYCStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:SYCNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + SYCStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + SYCStatusCellMargin;
    
    CGFloat textW = SYCScreenW - 2 * SYCStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:SYCTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + SYCStatusCellMargin;
    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = SYCStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + SYCStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + SYCStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = SYCScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}
#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * SYCStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * SYCStatusCellMargin;
    
    
    return CGSizeMake(w, h);
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = SYCStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithFont:SYCNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + SYCStatusCellMargin;
    
    CGFloat textW = SYCScreenW - 2 * SYCStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:SYCTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + SYCStatusCellMargin;
    // 配图
    int count = (int)_status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = SYCStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + SYCStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + SYCStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = SYCScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}
@end
