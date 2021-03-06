//
//  PigeonService.h
//  Runner
//
//  Created by NingSpeals on 2022/2/23.
//

#import <Foundation/Foundation.h>
#import <CDBleSDK/CDBleSDK.h>
#import "Pigeon.h"

NS_ASSUME_NONNULL_BEGIN

@interface PigeonService : NSObject<FLTApi, FLTCallBluetoothSDK, CDBleManagerDelegate>
// 存储所有的外设
@property(nonatomic, strong)NSMutableArray *peripherals;
@property(nonatomic, strong)NSMutableArray *names;
@property(nonatomic, strong)NSMutableArray<NSString *> *systemInfoList;
@property(nonatomic, strong)CBPeripheral *connectPeripheral;
@property(nonatomic, strong)NSMutableArray *nameDic;
@property(nonatomic, assign)BOOL isConnectPeripheralSuccess;
@property(nonatomic, assign)BOOL isDisConnectPeripheralSuccess;
@property(nonatomic, assign)BOOL isConnectedPeripheral;
@property(nonatomic, copy  )NSString *enableConfigBinaryStr;
@property(nonatomic, assign)BOOL isFreeVendingEnable;
@property(nonatomic, assign)BOOL isConfigServerEnable;
@property(nonatomic, copy  )NSString *packageCode;
@property(nonatomic, copy  )NSString *packageVersion;
@property(nonatomic, assign)NSInteger networkingStateResultType;
@property(nonatomic, assign)NSInteger networkModelCode;
@property(nonatomic, copy  )NSString *deviceConfigStr;
@property(nonatomic, copy  )NSString *domain;
@property(nonatomic, assign)BOOL isEnableSuccess;
@property(nonatomic, copy  )NSString *domainSuffix;
@property(nonatomic, copy  )NSString *currentVersion;
@property(nonatomic, assign)BOOL isRequestOCPPConfigParamsSuccess;
@property(nonatomic, strong)NSMutableArray* basicInfoArr;
@property(nonatomic, copy  )NSString *ssid;
@property(nonatomic, copy  )NSString *apnParamsData;
@property(nonatomic, assign)BOOL isCEAuthenticationSucces;
@property(nonatomic, assign)BOOL isConfigAPNWithParamsSuccess;
@property(nonatomic, assign)BOOL isConfigWIFIWithSSIDSuccess;

@end

NS_ASSUME_NONNULL_END
