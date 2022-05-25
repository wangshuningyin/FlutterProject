//
//  ErweimaBaseController.h
//  CarOwner
//
//  Created by LELE on 2019/9/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface ErweimaBaseController : UIViewController
@property(nonatomic,strong)COButton* backItem;
-(void)setUpNav;
-(void)buildUI;
@end

NS_ASSUME_NONNULL_END
