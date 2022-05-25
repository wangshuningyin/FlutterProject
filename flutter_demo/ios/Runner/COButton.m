//
//  COButton.m
//  CarOwner
//
//  Created by LELE on 2019/5/30.
//  Copyright © 2019 rect. All rights reserved.
//

#import "COButton.h"

@implementation COButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addAction];
    }
    return self;
}

-(instancetype)init{
    if (self == [super init]) {
        [self addAction];
    }
    return self;
}

-(void)addAction{
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)action:(UIButton*)sender{
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

@end
