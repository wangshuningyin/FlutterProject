//
//  CDBleNetworkLayerConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN
/**
 * Local power
 */
@interface CDBleNetworkLayerConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *maxCurrentConfig;
@property(nonatomic,strong)CDBleConfig *acCurrentConfig;
@property(nonatomic,strong)CDBleConfig *chargingPriorityConfig;
@property(nonatomic,strong)CDBleConfig *localStandardVoltageConfig;
@property(nonatomic,strong)CDBleConfig *overVoltageConfig;
@property(nonatomic,strong)CDBleConfig *lackVoltageConfig;
@property(nonatomic,strong)CDBleConfig *overCurrent1Config;
@property(nonatomic,strong)CDBleConfig *overCurrent2Config;

@end

NS_ASSUME_NONNULL_END
