//
//  CDBleNetworkingState.h
//  CDBleSDK
//
//  Created by LELE on 2019/12/16.
//  Copyright © 2019 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleSetResult.h"

NS_ASSUME_NONNULL_BEGIN
@interface CDBleNetworkingState : CDBleSetResult
@property(nonatomic,assign)NSInteger networkModelCode;
@property(nonatomic,copy)NSString *networkModel;
@end

NS_ASSUME_NONNULL_END
