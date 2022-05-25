//
//  CDBleDataModel.h
//  LZAPI
//
//  Created by LELE on 2018/11/19.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleSetResult.h"
#import "CDBleChargingData.h"
#import "CDBleRemoteModel.h"
#import "YRunStateModel.h"
#import "CDBleErrorListLog.h"
#import "CDBleTotleElecQuantityModel.h"
#import "CDBleRunDiagnosticInfo.h"
#import "CDBleChargeHistory.h"
#import "CDBleBasicInfoConfig.h"
#import "CDBleEmployInfoConfig.h"
#import "CDBleNetworkLayerConfig.h"
#import "CDBleEletricProtectionConfig.h"
#import "CDBleSocketConfig.h"
#import "CDBleLANConfig.h"
#import "CDBleWIFIConfig.h"
#import "CDBleGSMConfig.h"
#import "CDBleBluetoothConfig.h"
#import "CDBleNFCConfig.h"
#import "CDBleNetworkingState.h"
#import "CDBleDeviceLogStatisticsModel.h"
#import "CDBleDeviceLogModel.h"
#import "CDBleOcppConfigStateModel.h"
#import "CDBleOcppDownloadResult.h"
#import "CDBleOcppConfigParamsModel.h"
#import "CDBleAPNParamsModel.h"
#import "CDBleSSIDModel.h"
#import "CDBlePowerControlModel.h"
#import "CDBleSmartMeterModel.h"
#import "CDBleCardMode.h"
#import "CDBleMeterSlaveConnectionStateModel.h"
#import "CDBleCardsWhiteListParamsModel.h"
#import "CDBleModbusModel.h"
#import "CDBleScheduleModel.h"
#import "CDBleGridNetworkConfig.h"
#import "CDBleDeviceConfigModel.h"
#import "CDBleMeterConfigParamsModel.h"
#import "CDBleModbusCommParamsModel.h"
#import "CDBleConfigIOModel.h"
#import "CDBleReportStateModel.h"

typedef NS_ENUM(NSInteger,CDBleCmdType){
    CDBleCmdTypeNore                                =    0, // 普通的
    CDBleCmdTypeSynchroTime                         =    1,
    CDBleCmdTypeQuerySystemInfo                     =    2,
    CDBleCmdTypeSetVolume                           =    3,
    CDBleCmdTypeSetChargingOrderTime                =    4, // 预约充电
    CDBleCmdTypeCharging                            =    5,
    CDBleCmdTypeQueryState                          =    6,
    CDBleCmdTypeStopCharge                          =    7,
    CDBleCmdTypeQueryChargingHistory                =    8,
    CDBleCmdTypeQueryTotalChargingCapacity          =    9,
    CDBleCmdTypeStartRemoteUpgrade                  =    10, // 启动远程升级
    CDBleCmdTypeRequestUpgradePackage               =    11, // 请求下发升级包
    CDBleCmdTypeUpgradeSuccess                      =    12,
    CDBleCmdTypeChargeOperationDiagnosisInfo        =    13, // 桩运行诊断信息
    CDBleCmdTypeQueryChargingData                   =    14,
    CDBleCmdTypeQueryHistoryErrorLog                =    15,
    CDBleCmdTypeIdentityAuthentication              =    16, // 身份认证
    CDBleCmdTypePowerControl                        =    17, // 功率控制
    CDBleCmdTypeCEAuthentication                    =    18, // CE 认证
    CDBleCmdTypeConfigBasicInfo                     =    19, // 配置基础信息 配置类
    CDBleCmdTypeConfigEmployInfo                    =    20, // 配置使用信息 配置类
    CDBleCmdTypeConfigNetworkLayer                  =    21, // 配置电网层 配置类
    CDBleCmdTypeConfigElectricalProtection          =    22, // 配置电气保护 配置类
    CDBleCmdTypeConfigSocket                        =    23, // 配置网络接口 配置类
    CDBleCmdTypeConfigLAN                           =    24, // 配置LAN 配置类
    CDBleCmdTypeConfigWIFI                          =    25, // 配置WIFI 配置类
    CDBleCmdTypeConfigBLE                           =    26, // 配置BLE 配置类
    CDBleCmdTypeConfigNFC                           =    27,  // 配置NFC 配置类
    CDBleCmdTypeConfigBluetoothWIFI                 =    28,  // 直接配置WIFI
    CDBleCmdTypeNetworkingState                     =    29,  // 获取网络连接状态
    CDBleCmdTypeCompulsoryUnlocking                 =    30,   // 强制解锁
    CDBleCmdTypeSetNetworkMode                      =    31,   // 设置联网模式
    CDBleCmdTypeQueryDeviceLogStatistics            =    32,   // 获取日志统计信息
    CDBleCmdTypeQueryDeviceLog                      =    33,   // 查询设备日志
    CDBleCmdTypeAddCardMode                         =    34,   // 开始加卡模式
    CDBleCmdTypeLeakageDisabled                     =    35,    // 漏电总使能控制
    CDBleCmdTypeOCPPRequestConfigurationParams      =    36,    // 请求配置文件参数
    CDBleCmdTypeOCPPConfigurationStateNoti          =    37,    // 配置状态通知
    CDBleCmdTypeOCPPQueryConfigurationState         =    38,    // 查询配置状态
    CDBleCmdTypeOCPPRequestDownloadParams           =    39,    // 请求下载配置文件
    CDBleCmdTypeOCPPRequestDownloadStateNoti        =    40,    // 配置文件下载结果通知
    CDBleCmdTypeOCPPRequestServerConfigParams       =    41,    // 查询服务器配置参数（设备当前连接的服务器地址等）
    CDBleCmdTypeDeviceEnableConfig                  =    42,    // 配置使能控制
    CDBleCmdTypeQueryDeviceEnable                   =    43,    // 查询使能配置
    CDBleCmdTypeConfigAPN                           =    44,    // APN 配置 4G模块TCP/IP参数
    CDBleCmdTypeQueryConfigAPN                      =    45,    // APN 配置参数查询
    CDBleCmdTypeConfigGSM                           =    46,    // 配置 GSM 配置类
    CDBleCmdTypeQueryConfigSSID                     =    47,    // 查询 SSID 配置
    CDBleCmdTypeQueryPowerControl                   =    48,    // 查询 功率控制的设置功率和最大输出功率
    CDBleCmdTypeQuerySmartMeterParams               =    49,    // 查询 smrt meter 配置
    CDBleCmdTypeConfigSmartMeter                    =    50,    // 配置 smart meter
    CDBleCmdTypeQueryLocalDeviceCardList            =    51,    // 查询本地添加设备卡列表
    CDBleCmdTypeQueryMeterSlaveConnectionState      =    52,    // 查询电表从机连接状态
    CDBleCmdTypeConfigCardsWhiteList                =    53,    // 配置卡的白名单（删除RFID卡）
    CDBleCmdTypeQueryModbusParams                   =    54,    // 查询 modbus 配置参数
    CDBleCmdTypeConfigModbusParams                  =    55,    // 配置 modbus 配置参数
    CDBleCmdTypeQuerySchedule                       =    56,    // 查询预约定时时间
    CDBleCmdTypeConfigGridNetwork                   =    57,    // 配置 GridNetwork
    CDBleCmdTypeQueryDeviceConfig                   =    58,    // 查询设备配置信息 eg:mac address
    CDBleCmdTypeConfigMeterParams                   =    59,    // 配置电表参数 0xF1
    CDBleCmdTypeQueryMeterParams                    =    60,    // 查询电表配置参数 0xF2
    CDBleCmdTypeConfigModbusCommParams              =    61,    // 配置Modbus通讯参数 0xF3
    CDBleCmdTypeQueryModbusCommParams               =    62,    // 查询Modbus通讯参数 0xF4
    CDBleCmdTypeConfigIOParams                      =    63,    // 查询Modbus通讯参数 0xF5
    CDBleCmdTypeQueryConfigIOParams                 =    64,    // 查询Modbus通讯参数 0xF6
    CDBleCmdTypeReportDeviceState                   =    65,    // 上报设备状态 0xF7




    CDBleCmdType3DESKey                             =    100    // 获取key
};

typedef NS_ENUM(NSInteger,CDBleCmdRespondCode){
    CDBleCmdRespondCodeNone          =       0  ,   // 指令码响应正常
    CDBleCmdRespondCodeNotSupport    =       14 ,   // 指令不支持
    CDBleCmdRespondCodeTokenOutTime  =       16     // token 失效超时
};

/**
 *  蓝牙解析的数据模型
 */
@interface CDBleDataModel : NSObject
/**
 * 指令响应码类型
 */
@property(nonatomic,assign)CDBleCmdRespondCode respondCode;

/**
 * 设置类型操作（开始充电，结束充电）返回的结果
 */
@property(nonatomic,strong)CDBleSetResult* result;

/**
 * 充电中信息
 */
@property(nonatomic,strong)CDBleChargingData* chargingData;

/**
 * 获取系统信息列表（信息的头部包含在文件列表中）
 */
@property(nonatomic,strong)NSArray* systemInfoList;

/**
 * 充电历史记录中列表
 */
@property(nonatomic,strong)NSArray<CDBleChargeHistory*>* chargeHistoryList;

/**
 * 获取错误日志列表
 */
@property(nonatomic,strong)NSArray<CDBleErrorListLog*>* historyErrorInfoList;

/**
 *  文件升级
 */
@property(nonatomic,strong)CDBleRemoteModel* remoteModel;

/**
 * 获取总的电量
 */
@property(nonatomic,strong)CDBleTotleElecQuantityModel* totleElecQtModel;

/**
 * 桩的运行诊断信息（运行状态）
 */
@property(nonatomic,strong)CDBleRunDiagnosticInfo* runDiagnosticInfo;

/**
 * 读的 基本信息配置
 */
@property(nonatomic,strong)CDBleBasicInfoConfig* basicInfoConfig;

/**
 * 使用配置
 */
@property(nonatomic,strong)CDBleEmployInfoConfig* employConfig;

/**
 * 电网层配置
 */
@property(nonatomic,strong)CDBleNetworkLayerConfig* networkLayerConfig;

/**
 * 电气保护配置
 */
@property(nonatomic,strong)CDBleEletricProtectionConfig* elecProtectionConfig;

/**
 * 网络接口配置
 */
@property(nonatomic,strong)CDBleSocketConfig* socketConfig;

/**
 * LAN配置
 */
@property(nonatomic,strong)CDBleLANConfig* lanConfig;

/**
 * WIFI配置
 */
@property(nonatomic,strong)CDBleWIFIConfig* wifiConfig;

/**
 * GSM 配置
 */
@property(nonatomic,strong)CDBleGSMConfig *gsmConfig;

/**
 * BLE配置
 */
@property(nonatomic,strong)CDBleBluetoothConfig* bluetoothConfig;

/**
 * NFC配置
 */
@property(nonatomic,strong)CDBleNFCConfig* nfcConfig;

/**
 * GridNetwork 配置
 */
@property(nonatomic,strong)CDBleGridNetworkConfig *gridNetworkConfig;

/**
 * 检查联网状态
 */
@property(nonatomic,strong)CDBleNetworkingState *networkingState;

/**
 * 设备日志统计信息
 */
@property(nonatomic,strong)CDBleDeviceLogStatisticsModel *deviceLogStatisticsMode;

/**
 *  设备日志信息列表
 */
@property(nonatomic,strong)NSArray <CDBleDeviceLogModel *>* deviceLogs;

/**
 * OCPP 配置结果状态
 */
@property(nonatomic,strong)CDBleOcppConfigStateModel *ocppConfigStateModel;

/**
 * OCPP 证书下载状态
 */
@property(nonatomic,strong)CDBleOcppDownloadResult *ocppDownloadResultState;

/**
 * 充电桩服务配置信息
 */
@property(nonatomic,strong)CDBleOcppConfigParamsModel *ocppConfigParamsModel;

/**
 * 充电桩的使能配置 二进制串 两个字节 16 bit
 */
@property(nonatomic,copy)NSString * enableConfigBinaryStr;

/**
 * AFN 配置参数模型
 */
@property(nonatomic,strong)CDBleAPNParamsModel *apnParamsModel;

/**
 * SSID 配置参数
 */
@property(nonatomic,strong)CDBleSSIDModel *ssidModel;

/**
 * 功率控制
 */
@property(nonatomic,strong)CDBlePowerControlModel *powerControlModel;

/**
 * smart meter
 */
@property(nonatomic,strong)CDBleSmartMeterModel *smartMeterModel;

/**
 * 本地添加的卡列表
 */
@property(nonatomic,strong)NSArray *cardList;

/**
 * 查询加卡模式添加的卡号
 */
@property(nonatomic,strong)CDBleCardMode *cardMode;

/**
 * 电表 从机连接状态
 */
@property(nonatomic,strong)CDBleMeterSlaveConnectionStateModel *meterSlaveStateModel;

/**
 * 卡列表白名单配置
 */
@property(nonatomic,strong)CDBleCardsWhiteListParamsModel *cardsWhiteListParamsModel;

@property(nonatomic,strong)CDBleModbusModel *modbusModel;

/**
 * 预约定时时间
 */
@property(nonatomic,strong)CDBleScheduleModel *scheduleModel;


/**
 * 配置参数
 */
@property(nonatomic,strong)CDBleDeviceConfigModel *deviceConfigModel;

/**
 * 配置电表基础配置
 */
@property(nonatomic,strong)CDBleMeterConfigParamsModel *meterConfigParamsModel;

/**
 * Modbus 通讯配置
 */
@property(nonatomic,strong)CDBleModbusCommParamsModel *modbusCommParamsModel;

/**
 * config IO
 */
@property(nonatomic,strong)CDBleConfigIOModel *configIOModel;

/**
 * Report State
 */
@property(nonatomic,strong)CDBleReportStateModel *reportStateModel;

/**
 *  操作类型
 */
@property(nonatomic,assign)CDBleCmdType cmdType;


@end
