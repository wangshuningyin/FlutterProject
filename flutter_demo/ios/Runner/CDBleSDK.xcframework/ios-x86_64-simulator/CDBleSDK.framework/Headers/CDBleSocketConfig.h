//
//  CDBleSocketConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBleSocketConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *socketAEnableConfig;
@property(nonatomic,strong)CDBleConfig *serverAIPAddressConfig;
@property(nonatomic,strong)CDBleConfig *serverAPortConfig;
@property(nonatomic,strong)CDBleConfig *serverAProtocolConfig;
@property(nonatomic,strong)CDBleConfig *protocolAVersionConfig;
@property(nonatomic,strong)CDBleConfig *encryptedAConfig;
//@property(nonatomic,strong)CDBleConfig *socketBEnableConfig;
//@property(nonatomic,strong)CDBleConfig *serverBIPAddressConfig;
//@property(nonatomic,strong)CDBleConfig *serverBPortConfig;
//@property(nonatomic,strong)CDBleConfig *serverBProtocolConfig;
//@property(nonatomic,strong)CDBleConfig *protocolBVersionConfig;
//@property(nonatomic,strong)CDBleConfig *encryptedBConfig;

@end

NS_ASSUME_NONNULL_END
