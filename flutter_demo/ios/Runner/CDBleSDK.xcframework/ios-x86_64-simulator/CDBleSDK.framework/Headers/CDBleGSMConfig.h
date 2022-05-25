//
//  CDBleGMSConfig.h
//  CDBleSDK
//
//  Created by LELE on 2020/6/29.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBleGSMConfig : CDBleBaseConfig
@property(nonatomic,strong)CDBleConfig *functionEnableConfig;
@property(nonatomic,strong)CDBleConfig *apnConfig;
@property(nonatomic,strong)CDBleConfig *usernameConfig;
@property(nonatomic,strong)CDBleConfig *passwordConfig;
@property(nonatomic,strong)CDBleConfig *authTypeConfig;
@property(nonatomic,strong)CDBleConfig *imeiConfig;
@property(nonatomic,strong)CDBleConfig *imsiConfig;
@property(nonatomic,strong)CDBleConfig *iccidConfig;
@property(nonatomic,strong)CDBleConfig *csqConfig;

@end

NS_ASSUME_NONNULL_END
