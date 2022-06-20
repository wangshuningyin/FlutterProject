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

- (NSMutableArray *)systemInfoList {
    if (_systemInfoList == nil) {
        _systemInfoList = [NSMutableArray array];
    }
    return _systemInfoList;
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

- (void)isConnectedPeripheralWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSLog(@"%@", [CDBleManager shareManager].connectedPheral);
    if ([CDBleManager shareManager].connectedPheral == nil) {
        self.isConnectedPeripheral = NO;
    }else{
        self.isConnectedPeripheral = YES;
    }
    NSNumber* boolNum = [NSNumber numberWithBool:self.isConnectedPeripheral];
    completion(boolNum,nil);
    NSLog(@"是否连接设备 boolNum=%@ ----isConnectedPeripheral = %d",boolNum,self.isConnectedPeripheral);
}

- (void)getSystemInfoListWithCompletion:(void(^)(NSArray<NSString *> *_Nullable, FlutterError *_Nullable))completion {
    NSLog(@"设备信息%@",self.systemInfoList);
    completion(self.systemInfoList,nil);
}

- (void)queryDeviceSystemInfoWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"查询设备信息");
    [[CDBleManager shareManager] queryDeviceSystemInfoWithError:^(NSError * _Nullable error) {
    }];
}

- (void)queryNetworkStateWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryNetworkStateWithError:^(NSError * _Nullable error) {
        
    }];
}


- (void)queryOCPPConfigParamsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryOCPPConfigParamsWithError:^(NSError * _Nullable error) {
        
    }];
}

- (void)getDeviceConfigDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion(self.deviceConfigStr,nil);
}


- (void)getNetworkingStateDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion([NSString stringWithFormat:@"%ld%ld",self.networkingStateResultType, self.networkModelCode],nil);
}

- (void)getOCPPConfigParamsWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion(self.domain,nil);
}


- (void)queryDeviceConfigTypeWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryDeviceConfigType:DeviceConfigTypeQueryMacAddress error:^(NSError * _Nullable error) {
        
    }];
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
            if (dataModel.cmdType == CDBleCmdTypeDeviceEnableConfig) { //配置free vending使能
                NSLog(@"free vending使能配置成功");
            } else if (dataModel.cmdType == CDBleCmdTypeQueryDeviceEnable) {//查询free vending使能配置
                NSLog(@"free vending使能查询成功");
                self.enableConfigBinaryStr = dataModel.enableConfigBinaryStr;
                NSLog(@"%@",self.enableConfigBinaryStr);
                self.isEnable = [[self.enableConfigBinaryStr substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
            }else if (dataModel.systemInfoList){
                NSArray *systemInfoList = dataModel.systemInfoList;
                for (YRunStateModel * model in systemInfoList) {
                    NSDictionary *dic = [model dictionaryWithValuesForKeys:@[@"title",@"content",@"detailType"]];
                    NSLog(@"+++++++++++++%@",dic);
                    //要求转json的对象 是数组或字典 不可以是自定义的对象
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *tempStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"－－－－－－－－%@",tempStr);
                    [self.systemInfoList addObject:tempStr];
                }
                NSLog(@"设备信息请求成功%@",self.systemInfoList);
            }else if (dataModel.networkingState){
                CDBleNetworkingState *networkingState = dataModel.networkingState;
                self.networkingStateResultType = dataModel.networkingState.resultType;
                self.networkModelCode = networkingState.networkModelCode;
                NSLog(@"resultType == %ld",dataModel.networkingState.resultType);
            }else if(dataModel.deviceConfigModel){
                self.deviceConfigStr = [NSString stringWithFormat:@"%ld,%@",dataModel.deviceConfigModel.resultCode, dataModel.deviceConfigModel.params];
                NSLog(@"－－－－－－－－%@",self.deviceConfigStr);
            }else if(dataModel.ocppConfigParamsModel){
                NSLog(@"%@",dataModel.ocppConfigParamsModel.domain);
                self.domain = dataModel.ocppConfigParamsModel.domain;
            }
        }
    }
}

#pragma mark -- tools
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSString*) convertObjectToJson:(NSObject*) object
{
    NSError *writeError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return result;
}


/**
 * 查询配置使能 DD
 * - (void)queryEnableConfigRFID{
 [[CDBleManager shareManager] queryEnableConfigWithError:^(NSError * _Nullable error) {
 }];
}
 */

/**
 * 配置设置使能 DC
 * params: 只使用 1 字节,只传入 1 个字节 8 bit 数据
 * -(void)enableConfig{
 [[CDBleManager shareManager] enableConfigWithParams:nil error:^(NSError * _Nullable error) {

 }];
}
 */

// 获取系统信息
//-(void)queryDeviceSystemInfo{
//    [[CDBleManager shareManager] queryDeviceSystemInfoWithError:^(NSError * _Nullable error) {
//    }];
//}

//- (void)queryInternetConnectModel{
//    [[CDBleManager shareManager] queryNetworkStateWithError:^(NSError * _Nullable error) {
//
//    }];
//}
//
//- (void)loadDevceServerConfigInfo{
//    [[CDBleManager shareManager] queryOCPPConfigParamsWithError:^(NSError * _Nullable error) {
//
//    }];
//}
@end
