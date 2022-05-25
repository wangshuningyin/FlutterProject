//
//  COInputView.m
//  CarOwner
//
//  Created by LELE on 2019/6/3.
//  Copyright © 2019 rect. All rights reserved.
//

#import "COInputView.h"
#import "UIView+Extension.h"
#import "COButton.h"
#define kYLColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface COInputView()
@property(nonatomic,weak)UITextField* textF;
@end
@implementation COInputView
-(instancetype)init{
    if (self == [super init]) {
        [self setUp];
        [self buildUI];
    }
    return self;
}

-(void)setUp{
    self.frame = CGRectMake(0, 0,200, 376);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;
}

-(void)buildUI{
    
    UIImageView* iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"charge_input_place.png"]];
    iconImgView.yl_centerX = self.yl_width * 0.5;
    iconImgView.yl_y = 64;
    [self addSubview:iconImgView];
    
    COButton* closeItem = [[COButton alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
    [closeItem setImage:[UIImage imageNamed:@"charge_close.png"] forState:UIControlStateNormal];
    closeItem.yl_right = self.yl_width;
    [self addSubview:closeItem];
    closeItem.actionBlock = ^(UIButton *sender) {
        if (self.closeHandle) {
            self.closeHandle();
        }
    };
    
    UIView* inputView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.yl_width - 40, 70)];
    [self addSubview:inputView];
    inputView.layer.cornerRadius = 27;
    inputView.layer.masksToBounds = YES;
    inputView.layer.borderWidth = 1;
    inputView.layer.borderColor = kYLColor(110,58,255).CGColor;
    inputView.yl_bottom = self.yl_height - 50;
    
    UITextField* textF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, inputView.yl_width -80, inputView.yl_height)];
    textF.placeholder = @"请输入桩号后六位，解锁充电桩";
    textF.font = [UIFont systemFontOfSize:14];
    textF.textColor = kYLColor(110,58,255);
    [inputView addSubview:textF];
    [textF addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    textF.keyboardType = UIKeyboardTypePhonePad;
    [textF becomeFirstResponder];
}

-(void)textFieldTextChanged:(UITextField*)textF{
    if (self.textChangedhandle) {
        self.textChangedhandle(textF);
    }
}

-(void)becomeFirstResponder{
    [self.textF becomeFirstResponder];
}

-(void)resignFirstResponder{
    [self.textF resignFirstResponder];
}


@end
