//
//  COInputView.h
//  CarOwner
//
//  Created by LELE on 2019/6/3.
//  Copyright © 2019 rect. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^COInputViewCloseHandle)(void);
typedef void(^COInputViewTextChangedHandle)(UITextField* textF);
NS_ASSUME_NONNULL_BEGIN

@interface COInputView : UIView
@property(nonatomic,copy)COInputViewCloseHandle closeHandle;
@property(nonatomic,copy)COInputViewTextChangedHandle textChangedhandle;
-(void)becomeFirstResponder;
-(void)resignFirstResponder;
@end

NS_ASSUME_NONNULL_END
