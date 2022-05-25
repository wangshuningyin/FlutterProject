//
//  CDBleMeterSlaveConnectionStateModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/7/27.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleMeterSlaveConnectionStateModel : NSObject
// 电表连接状态 NO  未连接   YES 已连接
@property(nonatomic,assign)BOOL meterConnectState;
@end

NS_ASSUME_NONNULL_END
