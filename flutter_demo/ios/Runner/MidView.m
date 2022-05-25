//
//  MidView.m
//  chargeDot
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 lele. All rights reserved.
//

#import "MidView.h"

@interface MidView()
{
    CGRect _insertFrame;
}

@end

@implementation MidView

-(instancetype)initWithViewFrame:(CGRect)frame insertFrame:(CGRect)insertFrame
{
    if (self = [super initWithFrame:frame]) {
        _insertFrame = insertFrame;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat leftX = _insertFrame.origin.x;
    CGFloat topY = _insertFrame.origin.y;
    CGFloat rightX = CGRectGetMaxX(_insertFrame);
    CGFloat bottonY = CGRectGetMaxY(_insertFrame);
    
    CGFloat top = topY;
    CGFloat left = leftX;
    CGFloat right = self.frame.size.width - rightX;
    CGFloat botton = self.frame.size.height - bottonY;
    
    //上面
    UIBezierPath* p = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, top)];
    [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.5] setFill];
//    [kNavigationBarColor setFill];

    [p fill];
    
    
    //下面
    p = [UIBezierPath bezierPathWithRect:CGRectMake(0, bottonY, self.frame.size.width, botton)];
    [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.5] setFill];
//    [kNavigationBarColor setFill];
    [p fill];
    
    //左边
    p = [UIBezierPath bezierPathWithRect:CGRectMake(0, topY, left, _insertFrame.size.height)];
    [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.5] setFill];
//    [kNavigationBarColor setFill];

    [p fill];
    
    
    //右边
    p = [UIBezierPath bezierPathWithRect:CGRectMake(rightX, topY, right, _insertFrame.size.height)];
    [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.5] setFill];
//    [kNavigationBarColor setFill];

    [p fill];
}

@end
