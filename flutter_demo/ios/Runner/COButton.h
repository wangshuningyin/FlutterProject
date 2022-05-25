//
//  COButton.h
//  CarOwner
//
//  Created by LELE on 2019/5/30.
//  Copyright © 2019 rect. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^COButtonActionBlock)(UIButton*  _Nullable sender);
NS_ASSUME_NONNULL_BEGIN

@interface COButton : UIButton
@property(nonatomic,copy)COButtonActionBlock actionBlock;
@end

NS_ASSUME_NONNULL_END
