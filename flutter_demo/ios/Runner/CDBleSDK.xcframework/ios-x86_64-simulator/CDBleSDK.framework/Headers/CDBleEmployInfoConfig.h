//
//  CDBleEmployInfoConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleBaseConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface CDBleEmployInfoConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *connectorTypeConfig;
@property(nonatomic,strong)CDBleConfig *rateChargingCurrentConfig;
@property(nonatomic,strong)CDBleConfig *phaseChargePointConfig;
@property(nonatomic,strong)CDBleConfig *numberSocketOutletsConfig;
@end

NS_ASSUME_NONNULL_END
