//
//  CDBleEletricProtectionConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBleEletricProtectionConfig : CDBleBaseConfig

@property(nonatomic,strong)CDBleConfig * groundingDetectionConfig;
@property(nonatomic,strong)CDBleConfig * relayAdhesionDetectionConfig;
@property(nonatomic,strong)CDBleConfig * improperGunLineConfig;
@property(nonatomic,strong)CDBleConfig * elockDetectionConfig;
@property(nonatomic,strong)CDBleConfig * rcdDetectionConfig;
@property(nonatomic,strong)CDBleConfig * rcdStrategyConfig;
@property(nonatomic,strong)CDBleConfig * leakageRetryTimesConfig;
@property(nonatomic,strong)CDBleConfig * thirdPartyRFIDConfig;

@end

NS_ASSUME_NONNULL_END

