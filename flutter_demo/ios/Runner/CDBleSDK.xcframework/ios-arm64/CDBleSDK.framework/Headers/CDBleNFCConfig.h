//
//  CDBleNFCConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBleNFCConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *functionEnableConfig;
@property(nonatomic,strong)CDBleConfig *antennaPowerConfig;

@end

NS_ASSUME_NONNULL_END
