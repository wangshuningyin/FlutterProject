//
//  YOpenBtn.m
//  Anyo
//
//  Created by LELE on 16/12/27.
//  Copyright © 2016年 rect. All rights reserved.
//

#import "YOpenBtn.h"
#import "UIView+Extension.h"
#define kYLColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@implementation YOpenBtn
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setTitleColor:kYLColorRGBA(255, 255, 255, 0.9) forState:UIControlStateNormal];
//        self.backgroundColor = [UIColor redColor];
//        self.titleLabel.backgroundColor = [UIColor blueColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:@"打开电灯" forState:UIControlStateNormal];
        [self setTitle:@"关闭电灯" forState:UIControlStateSelected];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.yl_y = 0;
    self.imageView.yl_centerX = self.yl_width * 0.5;
    self.titleLabel.yl_y = self.imageView.yl_bottom + 10;
    self.titleLabel.yl_width = self.yl_width;
    self.titleLabel.yl_height = 12;
    self.titleLabel.yl_centerX = self.imageView.yl_centerX;
}

@end
