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
@property(nonatomic, strong)CBPeripheral *connectPeripheral;
@property(nonatomic, strong)NSMutableArray *nameDic;
@property(nonatomic, assign)BOOL isConnectPeripheralSuccess;
@property(nonatomic, assign)BOOL isDisConnectPeripheralSuccess;
@property(nonatomic, assign)BOOL isConnectedPeripheral;
@property(nonatomic, copy )NSString *enableConfigBinaryStr;
@property(nonatomic, assign)BOOL isEnable;
@property (nonatomic, strong) UIViewController *vc;

@end

NS_ASSUME_NONNULL_END
