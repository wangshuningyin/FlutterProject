//
//  PigeonService.m
//  Runner
//
//  Created by NingSpeals on 2022/2/23.
//

#import "PigeonService.h"
#import "NBOcppDomainModel.h"

#define kOcppDir @"ocppDir"

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
/**
 * 二维码扫描
 */
- (void)scanQRCodeWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: 二维码扫描");
}

#pragma mark -- FLTCallBluetoothSDK
- (void)startBluetoothWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [CDBleManager shareManager].delegate = self;
    NSLog(@"iOS: -----启动蓝牙");
}

/**
 * 扫描外设
 */
- (void)scanForPeripheralsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] scanForPeripherals];
    NSLog(@"iOS: -----搜索设备");
}

- (void)getDeviceNamesWithCompletion:(nonnull void (^)(NSArray<NSString *> * _Nullable, FlutterError * _Nullable))completion {
    NSArray *arr = self.names;
    completion(arr,nil);
    //    NSLog(@"iOS----%@",arr);
}


/*！@brief 开始连接外设
 *  @param peripheral 需要连接的外设
 */
- (void)startConnectPeripheralWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] startConnectPeripheral:self.connectPeripheral];
    NSLog(@"iOS: -----开始连接蓝牙设备");
}
- (void)isConnectPeripheralSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* boolNum = [NSNumber numberWithBool:self.isConnectPeripheralSuccess];
    completion(boolNum,nil);
    NSLog(@"iOS: boolNum=%@ ----isConnectPeripheralSuccess = %d",boolNum,self.isConnectPeripheralSuccess);
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
- (void)getConnectDeviceNameName:(nullable NSString *)name completion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: -----sessionName: %@", name);
    for (CBPeripheral *peripheral in self.peripherals) {
        if ([name isEqualToString:peripheral.name]) {
            self.connectPeripheral = peripheral;
        }
    }
    NSLog(@"iOS: -----connectPeripheral: %@", self.connectPeripheral);
}

/**
 *  断开外设
 */
- (void)stopConnectPeripheralWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] stopConnectPeripheral:self.connectPeripheral error:nil];
}
- (void)isDisConnectPeripheralSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* boolNum = [NSNumber numberWithBool:self.isDisConnectPeripheralSuccess];
    completion(boolNum,nil);
    NSLog(@"iOS:  boolNum=%@ ----isConnectPeripheralSuccess = %d",boolNum,self.isDisConnectPeripheralSuccess);
}

/**
 * 查询配置使能 DD
 */
- (void)queryEnableConfigWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: free vending使能查询成功");
    [[CDBleManager shareManager] queryEnableConfigWithError:^(NSError * _Nullable error) {
    }];
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

/**
 * 配置设置使能 DC
 * params: 只使用 1 字节,只传入 1 个字节 8 bit 数据
 */
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

/**
 *查询充电桩系统信息
 */
- (void)queryDeviceSystemInfoWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"iOS: 查询设备信息");
    [[CDBleManager shareManager] queryDeviceSystemInfoWithError:^(NSError * _Nullable error) {
    }];
}
- (void)getSystemInfoListWithCompletion:(void(^)(NSArray<NSString *> *_Nullable, FlutterError *_Nullable))completion {
    NSLog(@"iOS: 设备信息%@",self.systemInfoList);
    completion(self.systemInfoList,nil);
}

/**
 * 检查网络配置
 */
- (void)queryNetworkStateWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryNetworkStateWithError:^(NSError * _Nullable error) {
        
    }];
}
- (void)getNetworkingStateDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion([NSString stringWithFormat:@"%ld%ld",self.networkingStateResultType, self.networkModelCode],nil);
}

/**
 * 查询设备连接服务器配置信息  0XDB
 */
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

/**
 * 查询设备配置信息
 * eg:mac address
 * 0XF0
 */
- (void)queryDeviceConfigTypeWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryDeviceConfigType:DeviceConfigTypeQueryMacAddress error:^(NSError * _Nullable error) {
        
    }];
}

- (void)getDeviceConfigDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion {
    completion(self.deviceConfigStr,nil);
}



/**
 * 请求配置服务器连接参数 0XD6
 */
- (void)requestOCPPConfigParamsOcppConfigParams:(nullable NSString *)ocppConfigParams completion:(nonnull void (^)(FlutterError * _Nullable))completion {
    NSLog(@"ocppConfigParams ======= %@",ocppConfigParams);
    NSArray *array = [ocppConfigParams componentsSeparatedByString:@"#"]; //从字符A中分隔成2个元素的数组
    NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
   
    NSDictionary* data = [self dictionaryWithJsonString:array[0]];
    NBOcppDomainModel* ocppDomainModel = [[NBOcppDomainModel alloc] initWithDict:data];
    NSLog(@"ocppConfigParams ======= %@",ocppDomainModel.name);
    
    CDBleOcppConfigParamsModel *paramsModel = [[CDBleOcppConfigParamsModel alloc] init];
    paramsModel.servreEnable = 0;
    // domain 的使用当支持用户自定义则使用 location 字段
    paramsModel.domain = [self isSupportLocationOCPPWithCurrentVersion:self.currentVersion applyVersion:ocppDomainModel.applyVersion] ? ocppDomainModel.location : ocppDomainModel.domain;
    paramsModel.domainLen = paramsModel.domain.length;
    paramsModel.domainSuffix = array[1];
    paramsModel.domainSuffixLen = paramsModel.domainSuffix.length;
    
    paramsModel.port = ocppDomainModel.port;
    paramsModel.protocalType = [ocppDomainModel.type isEqualToString:@"OCPP"] ? 1 : 2;
    paramsModel.protocalVersion = ocppDomainModel.version;
    // 适配文件长度
    if (ocppDomainModel.passSupprot == 0){
        paramsModel.cerLen = 0;
    } else {
       // passphrase(securityKey)
        paramsModel.cerLen = [ocppDomainModel.securityKey isEqualToString:@""] ? 1 : ocppDomainModel.securityKey.length / 2 ;
    }
    paramsModel.securityKey = ocppDomainModel.securityKey;
    paramsModel.TLS_Enable = ocppDomainModel.tls;
    paramsModel.rootCerNumber = ocppDomainModel.code.integerValue;
    paramsModel.downloadSize = 128;
    NSData *cerInfoData = [self readOcppDataFromeFileName:ocppDomainModel.name];
    paramsModel.rootCerLen = cerInfoData.length;
    paramsModel.cerInfoData = cerInfoData;
    [[CDBleManager shareManager] requestOCPPConfigParams:paramsModel error:^(NSError * _Nullable error) {
    }];
}

- (void)isRequestOCPPConfigParamsSuccessWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSNumber* isRequestOCPPConfigParamsSuccess = [NSNumber numberWithBool:self.isRequestOCPPConfigParamsSuccess];
    completion(isRequestOCPPConfigParamsSuccess,nil);
    NSLog(@"iOS: self.isRequestOCPPConfigParamsSuccess === %d",self.isRequestOCPPConfigParamsSuccess);
}

/**
 * CE 认证配置
 * params   0 关    1 开
 0 4G 使能
 1 WIFI
 2 NFC
 3 LAN
 4 故障灯语
 5 循环自检
 6
 7
 */
- (void)ceAuthenticationWithParamsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    // @[@"4G 使能",@"WIFI 使能",@"NFC 使能",@"LAN 使能",@"故障灯语使用",@"循环自检使能"];
    NSArray* defaultBasicInfoArr = @[@(0),@(0),@(1),@(0),@(0),@(0)];
    self.basicInfoArr = [NSMutableArray arrayWithArray:defaultBasicInfoArr];
    [[CDBleManager shareManager] CEAuthenticationWithParams:self.basicInfoArr error:^(NSError * _Nullable error) {
        
    }];
}


/**
 * 查询 APN 4G 模块 TCP/IP 参数
 */
- (void)queryConfigAPNParamsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryConfigAPNParamsWithError:^(NSError * _Nullable error) {
    }];
}

/**
 * 查询 ssid 配置参数
 */
- (void)queryConfigSSIDParamsWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
    [[CDBleManager shareManager] queryConfigSSIDParamsWithError:^(NSError * _Nullable error) {
        
    }];
}

- (void)getAPNParamsDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion { 
    completion(self.apnParamsData,nil);
}


- (void)getSSIDParamsDataWithCompletion:(nonnull void (^)(NSString * _Nullable, FlutterError * _Nullable))completion { 
    completion(self.ssid,nil);
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
                YRunStateModel *versionModel = systemInfoList[5];
                self.currentVersion = versionModel.content;
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
                NSLog(@"iOS: domainSuffix====%@",dataModel.ocppConfigParamsModel.domainSuffix);
                self.domain = dataModel.ocppConfigParamsModel.domain;
                self.domainSuffix = dataModel.ocppConfigParamsModel.domainSuffix;
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
            }else if (dataModel.cmdType == CDBleCmdTypeOCPPRequestConfigurationParams){
                self.isRequestOCPPConfigParamsSuccess = YES;
                NSLog(@"iOS: isRequestOCPPConfigParamsSuccess－－－－－－－－%d",self.isRequestOCPPConfigParamsSuccess);
            }else if (dataModel.cmdType == CDBleCmdTypeCEAuthentication){
                NSLog(@"CDBleCmdTypeCEAuthentication请求成功");
            }else if (dataModel.apnParamsModel){
                NSLog(@"apnParamsModel请求成功 %@",dataModel.apnParamsModel);
                self.apnParamsData = [NSString stringWithFormat:@"%ld,%@",dataModel.apnParamsModel.apnType, dataModel.apnParamsModel.imsi];
            }else if (dataModel.ssidModel){
                NSLog(@"ssidModel请求成功%@",dataModel.ssidModel);
                self.ssid = dataModel.ssidModel.ssid;
            }
        }else{
            if (dataModel.cmdType == CDBleCmdTypeCEAuthentication){
                NSLog(@"CDBleCmdTypeCEAuthentication请求失败");
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
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (BOOL)isSupportLocationOCPPWithCurrentVersion:(NSString *)currentVersion applyVersion:(NSString *)applyVersion{
    
    if (applyVersion == nil || applyVersion.length == 0 || currentVersion == nil || currentVersion.length == 0) {
        return NO;
    }
    
    BOOL isSupportLoacation = NO;
    NSArray *applyVersionArr = [applyVersion componentsSeparatedByString:@","];
    for (NSString *versionStr in applyVersionArr) {
        if ([versionStr containsString:@"+"]) {
         NSString *vs = [versionStr stringByReplacingOccurrencesOfString:@"+" withString:@""];
             if ([currentVersion compare:vs] == NSOrderedSame || [currentVersion compare:vs] == NSOrderedDescending) {
                isSupportLoacation = YES;
                break;
            }
        }
        
        if (!isSupportLoacation) {
            if ([currentVersion isEqualToString:versionStr]) {
                isSupportLoacation = YES;
                break;
            }
        }
    }
    return isSupportLoacation;
}

-(NSData*)readOcppDataFromeFileName:(NSString *)fileName
{
    NSString* document = [self getOcppServerSaveDocument];
    NSString* filePath = [document stringByAppendingPathComponent:fileName];
    return [NSData dataWithContentsOfFile:filePath];
}

-(NSString*)getOcppServerSaveDocument{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:kOcppDir];
    
    //    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:userRemoteDir];
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建文件夹失败！");
        }
        NSLog(@"创建文件夹成功，文件路径%@",path);
    }
    return path;
}

@end
