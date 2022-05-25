//
//  CDBleLANConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBleLANConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *functionEnableConfig;
@property(nonatomic,strong)CDBleConfig *macAddressConfig;
//@property(nonatomic,strong)CDBleConfig *DHCPConfig;
//@property(nonatomic,strong)CDBleConfig *ipAddressConfig;
//@property(nonatomic,strong)CDBleConfig *subnetMaskConfig;
//@property(nonatomic,strong)CDBleConfig *gatewayAddressConfig;
//@property(nonatomic,strong)CDBleConfig *dnsAddressConfig;

@end


NS_ASSUME_NONNULL_END
