//
//  PigeonService.m
//  Runner
//
//  Created by NingSpeals on 2022/2/23.
//

#import "PigeonService.h"

@implementation PigeonService

- (NSMutableArray *)peripherals {
    if (_peripherals == nil) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}

- (NSMutableArray *)names {
    if (_names == nil) {
        _names = [NSMutableArray array];
    }
    return _names;
}

#pragma mark -- FLTApi
- (void)getPlatformVersionWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    NSString *str = [[UIDevice currentDevice] systemVersion];
    NSString *result = [NSString stringWithFormat:@"%@--%@",@"IOS", str];
    completion(result,nil);
    NSLog(@"iOS-----%@",str);
}

#pragma mark -- FLTCallBluetoothSDK
- (void)startBluetoothWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [CDBleManager shareManager].delegate = self;
    NSLog(@"iOS-----启动蓝牙");
}
- (void)scanForPeripheralsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] scanForPeripherals];
    NSLog(@"iOS-----搜索设备");
}

- (void)getDeviceNamesWithCompletion:(nonnull void (^)(NSArray<NSString *> * _Nullable, FlutterError * _Nullable))completion {
    NSArray *arr = self.names;
    completion(arr,nil);
//    NSLog(@"iOS----%@",arr);
}
- (void)startConnectPeripheralWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] startConnectPeripheral:self.connectPeripheral];
    NSLog(@"iOS2-----开始连接蓝牙设备");
}

- (void)stopConnectPeripheralWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] stopConnectPeripheral:self.connectPeripheral error:nil];
}

- (void)isConnectPeripheralSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* boolNum = [NSNumber numberWithBool:self.isConnectPeripheralSuccess];
    completion(boolNum,nil);
    NSLog(@"iOS4 boolNum=%@ ----isConnectPeripheralSuccess = %d",boolNum,self.isConnectPeripheralSuccess);
}

- (void)getConnectDeviceNameName:(nullable NSString *)name completion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS1-----sessionName: %@", name);
    for (CBPeripheral *peripheral in self.peripherals) {
        if ([name isEqualToString:peripheral.name]) {
            self.connectPeripheral = peripheral;
        }
    }
    NSLog(@"iOS1-----connectPeripheral: %@", self.connectPeripheral);
}

- (void)queryEnableConfigWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS------free vending使能查询成功");
    [[CDBleManager shareManager] queryEnableConfigWithError:^(NSError * _Nullable error) {
    }];
}

- (void)enableConfigWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS------free vending使能配置成功");
    [[CDBleManager shareManager] enableConfigWithParams:nil error:^(NSError * _Nullable error) {
       
    }];
}

/**
 * 查询配置使能 DD
 */
- (void)queryEnableConfigRFID{
    [[CDBleManager shareManager] queryEnableConfigWithError:^(NSError * _Nullable error) {
    }];
}
/**
 * 配置设置使能 DC
 * params: 只使用 1 字节,只传入 1 个字节 8 bit 数据
 */
-(void)enableConfig{
    [[CDBleManager shareManager] enableConfigWithParams:nil error:^(NSError * _Nullable error) {
       
    }];
}

- (void)getEnableWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* isEnable = [NSNumber numberWithBool:self.isEnable];
    completion(isEnable,nil);
}

- (void)scanQRCodeWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"二维码扫描");
}

- (void)isDisConnectPeripheralSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* boolNum = [NSNumber numberWithBool:self.isDisConnectPeripheralSuccess];
    completion(boolNum,nil);
    NSLog(@"iOS4 boolNum=%@ ----isConnectPeripheralSuccess = %d",boolNum,self.isDisConnectPeripheralSuccess);
}



#pragma mark -- CDBleManagerDelegate
- (void)cdbleManagerCenterState:(CBManagerState)state{
    NSLog(@"蓝牙开启与关闭状态:*****%ld",(long)state);
}
- (void)cdbleManager:(CDBleManager*_Nullable)cdbleManager didDiscoverPeripheral:(CBPeripheral*_Nullable)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *_Nullable)RSSI {
//    NSString *peripheralName = advertisementData[@"kCBAdvDataLocalName"];
    if (peripheral.name == nil) {
        return;
    }
    if (![self.peripherals containsObject:peripheral]){
        if ([peripheral.name hasPrefix:@"TAC"]) {
            NSLog(@"iOS ---- %@",peripheral);
            [self.peripherals addObject:peripheral];
            [self.names addObject:peripheral.name];
        }
    }
}

/// @brief 已经连接到外设
/// @param peripheral 已连接的外设
-(void)cdbleManager:(CDBleManager *)cdbleManager didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"iOS3 连接成功的蓝牙设备 = %@ ---- 是否成功isConnectPeripheralSuccess = %d",peripheral, self.isConnectPeripheralSuccess);
}

/*！@brief 外设响应的数据更新
 *  @param cdBleManager    中心设备管理者
 *  @param CDBleDataModel  解析外设响应的数据模型
 *  @param error           错误信息
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdBleManager didUpdateValueForCharacteristicValue:(CDBleDataModel* _Nullable )dataModel error:(nullable NSError *)error{
    if (dataModel.respondCode == CDBleCmdRespondCodeNotSupport) {
        NSLog(@"设备不支持");
        return;
    }
    if (dataModel.result.resultType == CDBleSetResultTypeSuccess) {
        CDBleSetResult *result = dataModel.result;
        if (result.resultType == CDBleSetResultTypeSuccess) {
            self.isConnectPeripheralSuccess = YES;
            self.isDisConnectPeripheralSuccess = YES;
            NSLog(@"数据请求成功");
        }
        if (dataModel.cmdType == CDBleCmdTypeDeviceEnableConfig) { //配置free vending使能
            NSLog(@"free vending使能配置成功");
        } else if (dataModel.cmdType == CDBleCmdTypeQueryDeviceEnable) {//查询free vending使能配置
            NSLog(@"free vending使能查询成功");
            self.enableConfigBinaryStr = dataModel.enableConfigBinaryStr;
            NSLog(@"%@",self.enableConfigBinaryStr);
            self.isEnable = [[self.enableConfigBinaryStr substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
        }
    }
}



#pragma mark -- tools
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
