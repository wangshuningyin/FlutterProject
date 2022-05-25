//
//  CDBleManager.h
//  BluethToolDemo
//
//  Created by LELE on 17/5/27.
//  Copyright © 2017年 rect. All rights reserved.
//
/******************************************************************************************
*******************************************************************************************
**                                                                                       **
**               ****  ********                ****      ********        **     ***      **
**              *****  *********             **    **    *********       **    **        **
**             **      **       **          **      **   **       **     **   **         **
**           **        **         **         **          **         **   **  **          **
**          **         **          **         ***        **          **  ** **           **
**          **         **          **            ***     **          **  ** **           **
**           **        **         **               ***   **         **   **  **          **
**            **       **       **         **       **   **       **     **   **         **
**              *****  *********            *********    *********       **    **        **
**               ****  ********               ******     ********        **     ***      **
**                                                                                       **
*******************************************************************************************
******************************************************************************************/
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CDBleOcppConfigParamsModel.h"
#import "CDBleAPNParamsModel.h"
#import "CDBleSmartMeterModel.h"
#import "CDBleCardsWhiteListParamsModel.h"
#import "CDBleModbusModel.h"
#import "CDBleDataModel.h"

/**
 *  蓝牙状态的开启与关闭通知中心发出的通知名称和 key 值
 */
typedef void(^CDBleManagerErrorBlock)(NSInteger errorCode,NSString* _Nullable errorMsg);

typedef NS_ENUM(NSInteger,ConfigInfoType){
    ConfigInfoTypeWrite  =   1000 ,
    ConfigInfoTypeRead   =   1001
};

typedef NS_ENUM(NSInteger,ConfigNetworkMode){
    ConfigNetworkModeNormal  =    0 , //恢复出厂设置模式
    ConfigNetworkModeLAN     =    1 ,
    ConfigNetworkModeWIFI    =    2 ,
    ConfigNetworkMode4G      =    3 ,
    ConfigNetworkModeMix     =    4    // 混合模式  lan > wifi > 4g  自动检测
};

static NSString* _Nullable  const CentralManagerDidUpdateStateNotification = @"CentralManagerDidUpdateStateNotification";

@class CDBleDataModel,CDBleManager;

@protocol CDBleManagerDelegate <NSObject>

@optional
/*! @brief 蓝牙开启与关闭状态变化的代理
 * @param state 状态枚举值
 */
- (void)cdbleManagerCenterState:(CBManagerState)state;

/*！@brief 搜索外设
 *  每搜索到一个外设此代理都会调用
 *  @param peripheral 发现的外设
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdbleManager didDiscoverPeripheral:(CBPeripheral*_Nullable)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *_Nullable)RSSI;

/*！@brief 已经连接到外设
 *  @param peripheral 已连接的外设
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdbleManager didConnectPeripheral:(nullable CBPeripheral*)peripheral;

/*！@brief 连接到外设失败
 *  @param error 失败原因
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdbleManager didFailToConnectPeripheral:(nullable CBPeripheral*)peripheral error:(nullable NSError*)error;

/*！@brief 外设断开连接
 *  @param peripheral 断开的外设
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdbleManager didDisconnectPeripheral:(nullable CBPeripheral*)peripheral error:(nullable NSError*)error;

/*！@brief 外设响应的数据更新
 *  @param cdBleManager    中心设备管理者
 *  @param CDBleDataModel  解析外设响应的数据模型
 *  @param error           错误信息
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdBleManager didUpdateValueForCharacteristicValue:(CDBleDataModel* _Nullable )dataModel error:(nullable NSError *)error;

// 响应的原始数据
- (void)didupdateOriginData:(NSData*_Nullable)originData;


- (void)sendDataLog:(NSData* _Nullable)sendData;


/**
 *  向外设写入数据的代理
 */
- (void)cdbleManager:(CDBleManager*_Nullable)cdbleManager didWriteValueForCharacteristic:(nullable CBCharacteristic *)characteristic error:(nullable NSError *)error;

@end

@interface CDBleManager : NSObject

@property(nonatomic,copy)CDBleManagerErrorBlock _Nullable errorBlock;

@property(nonatomic,weak) id  <CDBleManagerDelegate> _Nullable delegate;

// 蓝牙的开启状态 4 off  5 on
@property(nonatomic,assign)CBManagerState state;

/**
 *  已经连接的外设,连接成功之后有值
 */
@property(nonatomic,strong,readonly)CBPeripheral* _Nullable connectedPheral;

/**
 *  写特征
 */
@property(nonatomic,strong)CBCharacteristic* _Nullable writeCharacteristic;

/**
 * 读特征
 */
@property(nonatomic,strong)CBCharacteristic* _Nullable readCharacteristic;

/**
 * 用户信息  平台的用户id 用于用户认证的时候设置用户类型
 */
@property(nonatomic,assign)NSInteger platformUserId;

/**
 * 是否取消升级
 */
@property(nonatomic,assign)BOOL isCancelUpgrade;


+ (instancetype _Nullable )shareManager;


/**
 * 扫描外设
 */
- (void)scanForPeripherals;

/*！@brief 开始连接外设
 *  @param peripheral 需要连接的外设
 */
- (void)startConnectPeripheral:(CBPeripheral*_Nullable)peripheral;

/**
 *  断开外设
 */
- (void)stopConnectPeripheral:(CBPeripheral*_Nullable)peripheral error:(void(^_Nullable)(NSError* _Nullable error))error;

/**
 *  停止扫描外设
 */
- (void)stopScan;

#pragma mark -- 功能部分
/**
 *  开始充电
 */
- (void)startChargingWithError:(void(^_Nullable)(NSError* _Nullable error))error;

/**
 *  停止充电
 */
- (void)stopChargeWithError:(void(^_Nullable)(NSError* _Nullable error))error;

/**
 *  查询充电数据
 */
- (void)queryChargingDataWithError:(void(^_Nullable)(NSError* _Nullable error))error;


/********** 补全剩下的所有功能 ***********/

// 时间同步
- (void)synchroTimeWithError:(void (^_Nullable)(NSError * _Nullable))error;


// 预约/定时 充电
- (void)orderChargerWithStartHour:(NSInteger)startH startMinute:(NSInteger)startM endHour:(NSInteger)endH endMinute:(NSInteger)endM error:(void (^_Nullable)(NSError * _Nullable))error;

// 查询状态（查询桩的状态信息充电状态等）
- (void)queryDeviceRuningStateWithError:(void(^_Nullable)(NSError* _Nullable error))error;

// 查询充电历史记录
- (void)queryChargeHistoryListWithError:(void(^_Nullable)(NSError* _Nullable error))error;

// 查询历史错误日志
- (void)queryHistoryErrorLogListWithError:(void (^_Nullable)(NSError * _Nullable))error;

/**
 * 分页查询历史错误日志
 */
- (void)queryHistoryErrorLogListWithPage:(int)page error:(void(^_Nullable)(NSError* _Nullable error))error;

// 查询累计充电量
- (void)queryTotleElecQuantityWithError:(void(^_Nullable)(NSError* _Nullable error))error;

// 查询桩的运行诊断信息
- (void)queryRunningDiagnosticInfoWithError:(void(^_Nullable)(NSError* _Nullable error))error;

// 设置音量
- (void)setVolumeWithVolumeSize:(NSInteger)size error:(void(^_Nullable)(NSError* _Nullable error))error;


// 查询充电桩系统信息
- (void)queryDeviceSystemInfoWithError:(void(^_Nullable)(NSError* _Nullable error))error;

// 远程升级 分为 2 步，一步是 启动远程升级进行校验 第二步是 开始下发文件进行远程升级

// 启动远程升级
- (void)remoteUpdateWithData:(NSData*_Nullable)fileData checkSum:(NSString*_Nonnull)checkSum error:(void(^_Nullable)(NSError* _Nullable error))error;



- (void)sendIdentityAuthenticationWithError:(void(^_Nullable)(NSError * _Nullable e))error;


- (void)doDecEncryptHex;


/**
 *  设置充电模式  --- 立即模式
 */
- (void)setChargeModelStartModelWithError:(void(^_Nullable)(NSError* _Nullable error))error;


/**
 *  功率控制 percent 20.07.08 由百分比改为直接设置(整数)电流
 *
 */
- (void)powerControlWithPercent:(NSInteger)percent error:(void(^_Nullable)(NSError* _Nonnull error))failure;

/**
 * 充电的基础信息配置
 * 配置的 json 串
 */
- (void)configChargePointBasicInfoWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;
/**
 * 使用配置
 */
- (void)configChargePointEmployInfoWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * 电网层配置
 */
- (void)configNetworkLayerWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * 电气保护配置
 */
- (void)configElectricalProtectionWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * 网络接口配置
 */
- (void)configSocketWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;


/**
 * LAN配置
 */
- (void)configLANWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * GSM 配置
 */
- (void)configGSMWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * WIFI配置
 */
- (void)configWIFIWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * BLE配置
 */
- (void)configBLEWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * NFC配置
 */
- (void)configNFCWithType:(ConfigInfoType)type  configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * GridNetwork Config
 *
 *params:  TT,TN/IT Network/Split Phase
 *
 */
- (void)configGridNetworkWithType:(ConfigInfoType)type configInfo:(NSString*_Nullable)configInfo error:(void(^_Nullable)(NSError* _Nullable error))failure;

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
- (void)CEAuthenticationWithParams:(NSArray*_Nullable)params error:(void(^_Nullable)(NSError* _Nullable error))failure;

/**
 * WIFI SSID 下发 配置
 */
- (void)configWIFIWithSSID:(NSString *_Nullable)ssid psw:(NSString *_Nullable)psw error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 检查网络配置
 */
- (void)queryNetworkStateWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 强制解锁
 */
- (void)forceUnlockElectronicLockWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 设置联网模式
 * LAN (0x01) WIFI (0x02) 4G (0x03) mix(0x04)  默认设置（0x00）
 */
- (void)setNetworkModeWithMode:(ConfigNetworkMode)networkMode error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询设备日志统计信息
 */
- (void)queryDeviceLogStatisticsError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 获取设备日志
 * startSerialNumber: 请求的开始序列号
 * len: 每次请求的长度  default 10
 */
- (void)queryDeviceLogRequestStartSerialNumber:(NSInteger)startSerialNumber requestLength:(NSInteger)len error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 启动加卡模式
 */
- (void)startAddCardModeDuration:(NSInteger)duration error:(void(^_Nullable)(NSError * _Nullable error))failure;


/**
 * 漏电总使能开关
 * enable  1  disabled 0
 */
- (void)leakageDisabled:(BOOL)enable configType:(ConfigInfoType)configType Error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 获取设备的 key
 */
- (void)load3DESKeyError:(void(^_Nullable)(NSError * _Nullable error))failure;

/*********   OCPP SERVER CONFIG  ***********/

/**
 * 请求配置服务器连接参数 0XD6
 */
- (void)requestOCPPConfigParams:(CDBleOcppConfigParamsModel *_Nullable)paramsModel error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询服务器配置状态 0XD8
 */
- (void)queryOCPPConfigStateWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询设备连接服务器配置信息  0XDB
 */
- (void)queryOCPPConfigParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;


/**
 * 配置设置使能 DC
 * params: 只使用 1 字节,只传入 1 个字节 8 bit 数据
 */
- (void)enableConfigWithParams:(NSArray *_Nullable)params error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询配置使能 DD
 */
- (void)queryEnableConfigWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * APN 配置 4G模块TCP/IP参数
 * 0xDE
 */
- (void)configAPNWithParams:(CDBleAPNParamsModel *_Nullable)apnParamsModel error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询 APN 4G 模块 TCP/IP 参数
 */
- (void)queryConfigAPNParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询 ssid 配置参数
 */
- (void)queryConfigSSIDParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询功率控制  设置功率和最大输出功率
 */
- (void)queryConfigPowerControlWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询 smart metter
 */
- (void)querySmartMeterConfigParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 配置 smart metter
 */
- (void)configSmartMeterWithParams:(CDBleSmartMeterModel *_Nullable)samrtMeterModel error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询本地添加卡卡号
 */
- (void)queryLocalDeviceCardListWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 0xE5 查询电表和从机连接状态
 */
- (void)queryMeterSlaveConnectionStatusWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 0xCA 卡列表白名单配置
 */
- (void)configCardsWhiteListWithParams:(CDBleCardsWhiteListParamsModel *_Nullable)cardsWhiteListParamsModel error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询 modbus
 */
- (void)queryModbusConfigParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 配置 modbus
 */
- (void)configModbusWithParams:(CDBleModbusModel *_Nullable)modbusModel error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询预约充电时间
 * 0XE6
 */
- (void)queryScheduleWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询设备配置信息
 * eg:mac address
 * 0XF0
 */
- (void)queryDeviceConfigType:(DeviceConfigType)type error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 电表基础配置 0xF1
 */
- (void)configMeterParamsWithMeterConfigParamsModel:(CDBleMeterConfigParamsModel *_Nullable)meterConfigParamsModel error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * 查询电表基础配置 0xF2
 */
- (void)queryMeterParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * Modbus 通讯参数配置 0xF3
 */
- (void)configModbusCommunicationParams:(CDBleModbusCommParamsModel *_Nullable)modbusCommParamsModel  error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * Modbus 通讯参数查询 0xF4
 */
- (void)queryConfigModbusCommunicationParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * Config IO 配置IO 数据 0xF5
 */
- (void)configIOParams:(CDBleConfigIOModel *_Nullable)configIOModel error:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 * Config IO 查询IO 数据 0xF6
 */
- (void)queryConfigIOParamsWithError:(void(^_Nullable)(NSError * _Nullable error))failure;



- (void)testData;

@end
