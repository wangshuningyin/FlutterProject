//
//  CDBleBluetoothConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBleBluetoothConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *functionEnableConfig;
@property(nonatomic,strong)CDBleConfig *macAddressConfig;
@property(nonatomic,strong)CDBleConfig *advNameConfig;
@property(nonatomic,strong)CDBleConfig *moduleFirmwareVersionConfig;
@property(nonatomic,strong)CDBleConfig *factoryConfig;
@property(nonatomic,strong)CDBleConfig *protocolVersionConfig;
@end

NS_ASSUME_NONNULL_END
