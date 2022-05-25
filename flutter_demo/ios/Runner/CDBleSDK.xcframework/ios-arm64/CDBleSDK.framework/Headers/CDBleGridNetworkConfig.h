//
//  CDBleGridNewworkConfig.h
//  CDBleSDK
//
//  Created by LELE on 2021/4/26.
//  Copyright © 2021 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN
@interface CDBleGridNetworkConfig : CDBleBaseConfig
// TT,TN  Splite Phase  IT
@property(nonatomic,strong)CDBleConfig *networkTypeConfig;
@property(nonatomic,strong)CDBleConfig *disablePeConfig;

@end

NS_ASSUME_NONNULL_END
