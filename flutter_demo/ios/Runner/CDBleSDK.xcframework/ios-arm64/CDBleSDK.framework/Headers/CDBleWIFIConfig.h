//
//  CDBleWIFIConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBleWIFIConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *functionEnableConfig;
@property(nonatomic,strong)CDBleConfig *macAddressConfig;
@property(nonatomic,strong)CDBleConfig *moduleFirmwareVersionConfig;
//@property(nonatomic,strong)CDBleConfig *factoryConfig;
//@property(nonatomic,strong)CDBleConfig *modeConfig;
//@property(nonatomic,strong)CDBleConfig *apSSIDConfig;
//@property(nonatomic,strong)CDBleConfig *apPasswordConfig;
//@property(nonatomic,strong)CDBleConfig *apIpAddressConfig;
//@property(nonatomic,strong)CDBleConfig *apSubnetMaskConfig;
//@property(nonatomic,strong)CDBleConfig *apDHCPConfig;
//@property(nonatomic,strong)CDBleConfig *OwnedWifiSSIDConfig;
//@property(nonatomic,strong)CDBleConfig *OwnedWifiPasswordConfig;
//@property(nonatomic,strong)CDBleConfig *wifiDHCPConfig;
//@property(nonatomic,strong)CDBleConfig *moduleIpAddressConfig;
//@property(nonatomic,strong)CDBleConfig *moduleSubnetMaskConfig;
//@property(nonatomic,strong)CDBleConfig *moduleGatewayAddressConfig;
//@property(nonatomic,strong)CDBleConfig *moduleDNSAddressConfig;

@end

NS_ASSUME_NONNULL_END
