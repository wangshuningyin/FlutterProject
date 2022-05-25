//
//  CDBleBasicInfoConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/10/31.
//  Copyright © 2019 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleBaseConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface CDBleBasicInfoConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig* modelNumberConfig;
@property(nonatomic,strong)CDBleConfig* chargePointNumberConfig;
@property(nonatomic,strong)CDBleConfig* productionDateConfig;
@property(nonatomic,strong)CDBleConfig* hardwareVersionConfig;
@property(nonatomic,strong)CDBleConfig* pBoardSoftwareVersionConfig;
@property(nonatomic,strong)CDBleConfig* cBoardSoftwareVersionConfig;
@property(nonatomic,strong)CDBleConfig* chargePointTypeConfig;
@property(nonatomic,strong)CDBleConfig* ratedPowerConfig;
@property(nonatomic,strong)CDBleConfig* timeSettingsConfig;
@end

NS_ASSUME_NONNULL_END
