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
    NSLog(@"iOS: -----%@",str);
}

#pragma mark -- FLTCallBluetoothSDK
- (void)startBluetoothWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [CDBleManager shareManager].delegate = self;
    NSLog(@"iOS: -----启动蓝牙");
}
- (void)scanForPeripheralsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] scanForPeripherals];
    NSLog(@"iOS: -----搜索设备");
}

- (void)getDeviceNamesWithCompletion:(nonnull void (^)(NSArray<NSString *> * _Nullable, FlutterError * _Nullable))completion {
    NSArray *arr = self.names;
    completion(arr,nil);
//    NSLog(@"iOS----%@",arr);
}
- (void)startConnectPeripheralWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] startConnectPeripheral:self.connectPeripheral];
    NSLog(@"iOS: -----开始连接蓝牙设备");
}

- (void)stopConnectPeripheralWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] stopConnectPeripheral:self.connectPeripheral error:nil];
}

- (void)isConnectPeripheralSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* boolNum = [NSNumber numberWithBool:self.isConnectPeripheralSuccess];
    completion(boolNum,nil);
    NSLog(@"iOS: boolNum=%@ ----isConnectPeripheralSuccess = %d",boolNum,self.isConnectPeripheralSuccess);
}

- (void)getConnectDeviceNameName:(nullable NSString *)name completion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: -----sessionName: %@", name);
    for (CBPeripheral *peripheral in self.peripherals) {
        if ([name isEqualToString:peripheral.name]) {
            self.connectPeripheral = peripheral;
        }
    }
    NSLog(@"iOS: -----connectPeripheral: %@", self.connectPeripheral);
}

- (void)queryEnableConfigWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: free vending使能查询成功");
    [[CDBleManager shareManager] queryEnableConfigWithError:^(NSError * _Nullable error) {
    }];
}

- (void)enableConfigEnableConfigBinaryStr:(nullable NSString *)enableConfigBinaryStr completion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: free vending使能配置成功%@====%@",enableConfigBinaryStr,self.enableConfigBinaryStr);
    self.enableConfigBinaryStr = [self.enableConfigBinaryStr stringByReplacingCharactersInRange:NSMakeRange(2, 1) withString:enableConfigBinaryStr];
    [[CDBleManager shareManager] enableConfigWithParams:[self toArrFromStr:self.enableConfigBinaryStr] error:^(NSError * _Nullable error) {
    }];
    NSLog(@"iOS: free vending数据转化%@",[self toArrFromStr:enableConfigBinaryStr]);
}

- (void)isEnableSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* isEnableSuccess = [NSNumber numberWithBool:self.isEnableSuccess];
    completion(isEnableSuccess,nil);
    NSLog(@"iOS: self.isEnableSuccess === %d",self.isEnableSuccess);
}

- (void)getFreeVendingEnableWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* isFreeVendingEnable = [NSNumber numberWithBool:self.isFreeVendingEnable];
    completion(isFreeVendingEnable,nil);
    NSLog(@"iOS: self.isFreeVendingEnable === %d",self.isFreeVendingEnable);
}

- (void)getConfigServerEnableWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* isConfigServerEnable = [NSNumber numberWithBool:self.isConfigServerEnable];
    completion(isConfigServerEnable,nil);
    NSLog(@"iOS: self.isConfigServerEnable === %d",self.isConfigServerEnable);
}

- (void)scanQRCodeWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: 二维码扫描");
}

- (void)isDisConnectPeripheralSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* boolNum = [NSNumber numberWithBool:self.isDisConnectPeripheralSuccess];
    completion(boolNum,nil);
    NSLog(@"iOS:  boolNum=%@ ----isConnectPeripheralSuccess = %d",boolNum,self.isDisConnectPeripheralSuccess);
}

- (void)isConnectedPeripheralWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSLog(@"iOS: ==== %@", [CDBleManager shareManager].connectedPheral);
    if ([CDBleManager shareManager].connectedPheral == nil) {
        self.isConnectedPeripheral = NO;
    }else{
        self.isConnectedPeripheral = YES;
    }
    NSNumber* boolNum = [NSNumber numberWithBool:self.isConnectedPeripheral];
    completion(boolNum,nil);
    NSLog(@"iOS: 是否连接设备 boolNum=%@ ----isConnectedPeripheral = %d",boolNum,self.isConnectedPeripheral);
}

- (void)getSystemInfoListWithCompletion:(void(^)(NSArray<NSString *> *_Nullable, FlutterError *_Nullable))completion {
    NSLog(@"iOS: 设备信息%@",self.systemInfoList);
    completion(self.systemInfoList,nil);
}

- (void)queryDeviceSystemInfoWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: 查询设备信息");
    [[CDBleManager shareManager] queryDeviceSystemInfoWithError:^(NSError * _Nullable error) {
    }];
}

- (void)queryNetworkStateWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryNetworkStateWithError:^(NSError * _Nullable error) {
        
    }];
}

- (void)getNetworkingStateDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion([NSString stringWithFormat:@"%ld%ld",self.networkingStateResultType, self.networkModelCode],nil);
}

- (void)queryOCPPConfigParamsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryOCPPConfigParamsWithError:^(NSError * _Nullable error) {
        
    }];
}

- (void)getDomainSuffixWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion(self.domainSuffix,nil);
}

- (void)getDomainWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion(self.domain,nil);
}

- (void)queryDeviceConfigTypeWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryDeviceConfigType:DeviceConfigTypeQueryMacAddress error:^(NSError * _Nullable error) {
        
    }];
}

- (void)getDeviceConfigDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion(self.deviceConfigStr,nil);
}

#pragma mark -- CDBleManagerDelegate
- (void)cdbleManagerCenterState:(CBManagerState)state{
    NSLog(@"iOS: 蓝牙开启与关闭状态:*****%ld",(long)state);
}
- (void)cdbleManager:(CDBleManager*_Nullable)cdbleManager didDiscoverPeripheral:(CBPeripheral*_Nullable)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *_Nullable)RSSI {
//    NSString *peripheralName = advertisementData[@"kCBAdvDataLocalName"];
    if (peripheral.name == nil) {
        return;
    }
    if (![self.peripherals containsObject:peripheral]){
        if ([peripheral.name hasPrefix:@"TAC"]) {
            NSLog(@"iOS:  ---- %@",peripheral);
            [self.peripherals addObject:peripheral];
            [self.names addObject:peripheral.name];
        }
    }
}

/// @brief 已经连接到外设
/// @param peripheral 已连接的外设
-(void)cdbleManager:(CDBleManager *)cdbleManager didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"iOS:  连接成功的蓝牙设备 = %@ ---- 是否成功isConnectPeripheralSuccess = %d",peripheral, self.isConnectPeripheralSuccess);
}

/*！@brief 外设响应的数据更新
 *  @param cdBleManager    中心设备管理者
 *  @param CDBleDataModel  解析外设响应的数据模型
 *  @param error           错误信息
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdBleManager didUpdateValueForCharacteristicValue:(CDBleDataModel* _Nullable )dataModel error:(nullable NSError *)error{
    if (dataModel.respondCode == CDBleCmdRespondCodeNotSupport) {
        NSLog(@"iOS: 设备不支持");
        return;
    }
    if (dataModel.result.resultType == CDBleSetResultTypeSuccess) {
        CDBleSetResult *result = dataModel.result;
        if (result.resultType == CDBleSetResultTypeSuccess) {
            self.isConnectPeripheralSuccess = YES;
            self.isDisConnectPeripheralSuccess = YES;
            NSLog(@"iOS: 数据请求成功");
            if (dataModel.cmdType == CDBleCmdTypeDeviceEnableConfig) { //配置free vending使能
                self.isEnableSuccess = YES;
                NSLog(@"iOS: free vending使能配置成功%d",self.isEnableSuccess);
            } else if (dataModel.cmdType == CDBleCmdTypeQueryDeviceEnable) {//查询free vending使能配置
                NSLog(@"iOS: free vending使能查询成功");
                self.enableConfigBinaryStr = dataModel.enableConfigBinaryStr;
                NSLog(@"iOS: dataModel.enableConfigBinaryStr == %@",self.enableConfigBinaryStr);
                self.isFreeVendingEnable = [[self.enableConfigBinaryStr substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
                NSLog(@"iOS: self.isFreeVendingEnable == %d",self.isFreeVendingEnable);
                self.isConfigServerEnable = [[self.enableConfigBinaryStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"];
                NSLog(@"iOS: self.isConfigServerEnable == %d",self.isConfigServerEnable);
            }else if (dataModel.systemInfoList){
                NSArray *systemInfoList = dataModel.systemInfoList;
                for (YRunStateModel * model in systemInfoList) {
                    NSDictionary *dic = [model dictionaryWithValuesForKeys:@[@"title",@"content",@"detailType"]];
                    NSLog(@"iOS: +++++++++++++%@",dic);
                    //要求转json的对象 是数组或字典 不可以是自定义的对象
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *tempStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"iOS: －－－－－－－－%@",tempStr);
                    [self.systemInfoList addObject:tempStr];
                }
                NSLog(@"iOS: 设备信息请求成功%@",self.systemInfoList);
            }else if(dataModel.ocppConfigParamsModel){
                NSLog(@"iOS: ocppConfigParamsModel====%@",dataModel.ocppConfigParamsModel.domain);
                self.domain = dataModel.ocppConfigParamsModel.domain;
                self.domainSuffix = dataModel.ocppConfigParamsModel.domainSuffix;
                [self getDomainWithCompletion:^(NSString * _Nullable str, FlutterError * _Nullable error) {
                    str = self.domain;
                }];
            }else if (dataModel.networkingState){
                CDBleNetworkingState *networkingState = dataModel.networkingState;
                self.networkingStateResultType = dataModel.networkingState.resultType;
                self.networkModelCode = networkingState.networkModelCode;
                NSLog(@"iOS: networkingStateResultType == %ld",dataModel.networkingState.resultType);
                [self getNetworkingStateDataWithCompletion:^(NSString * _Nullable str, FlutterError * _Nullable error) {
                    str = [NSString stringWithFormat:@"%ld%ld",self.networkingStateResultType, self.networkModelCode];
                }];
            }else if(dataModel.deviceConfigModel){
                self.deviceConfigStr = [NSString stringWithFormat:@"%ld,%@",dataModel.deviceConfigModel.resultCode, dataModel.deviceConfigModel.params];
                NSLog(@"iOS: deviceConfigModel－－－－－－－－%@",self.deviceConfigStr);
                [self getDeviceConfigDataWithCompletion:^(NSString * _Nullable str, FlutterError * _Nullable error) {
                    str = self.deviceConfigStr;
                }];
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
- (NSArray <NSString *>*)toArrFromStr:(NSString *)str{
    if (str == nil || str.length == 0) return [NSArray array];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (int i = 0; i < str.length; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        [tmpArr addObject:s];
    }
    return tmpArr;
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
