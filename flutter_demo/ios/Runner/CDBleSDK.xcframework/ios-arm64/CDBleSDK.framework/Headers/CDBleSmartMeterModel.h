//
//  CDBleSmartMeterModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/7/16.
//  Copyright © 2020 rect. All rights reserved.
//  smart meter model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleSmartMeterModel : NSObject
// 是否支持 smart meter  0  不支持   1  支持
@property(nonatomic,assign)NSInteger isSupportSmartMeter;
// 选择协议类型  00 RTU  01 TCP
@property(nonatomic,assign)NSInteger modbus;
// 从机地址  1 - 247
@property(nonatomic,assign)NSInteger meter;
// 通信波特率 4 位
@property(nonatomic,assign)NSInteger modbusRTU;

// 通信ip 192 168 255 1
@property(nonatomic,copy)NSString *modbusTCP;
@property(nonatomic,assign)NSUInteger modbusTCP1;
@property(nonatomic,assign)NSUInteger modbusTCP2;
@property(nonatomic,assign)NSUInteger modbusTCP3;
@property(nonatomic,assign)NSUInteger modbusTCP4;

// 通信ip 掩码 255 255 0 0
@property(nonatomic,copy)NSString *modbusTCPMask;
@property(nonatomic,assign)NSUInteger modbusTCPMask1;
@property(nonatomic,assign)NSUInteger modbusTCPMask2;
@property(nonatomic,assign)NSUInteger modbusTCPMask3;
@property(nonatomic,assign)NSUInteger modbusTCPMask4;

// 通信网关  192.168.0.1
@property(nonatomic,copy)NSString *modbusTCPGateway;
@property(nonatomic,assign)NSUInteger modbusTCPGateway1;
@property(nonatomic,assign)NSUInteger modbusTCPGateway2;
@property(nonatomic,assign)NSUInteger modbusTCPGateway3;
@property(nonatomic,assign)NSUInteger modbusTCPGateway4;

// 通信端口  500
@property(nonatomic,assign)NSInteger modbusTCPPort;

// 是否支持local load management  0 不支持  1 支持
@property(nonatomic,assign)NSInteger isSupportLocalLoadManagement;
// 总电力容量
@property(nonatomic,assign)NSInteger totalPowerCapacity;

// 调控上限 w
@property(nonatomic,assign)NSInteger controlMax;
// 调控下限 w
@property(nonatomic,assign)NSInteger controlMin;
// 是否支持 master 模式  0 不支持  1 支持
@property(nonatomic,assign)NSInteger isSupportMasterMode;
// 从机数量 max 16
@property(nonatomic,assign)NSInteger slaveCount;
// 扩展标识位 ID   0  无扩展位，后续无数据  1 扩展支持按电流调控
@property(nonatomic,assign)NSInteger extensionID;
// 扩展位长度
@property(nonatomic,assign)NSInteger extensionLen;
// 扩展位内容
/**
 * extensionID = 1 时，extension 格式 “上限,下限”
 */
@property(nonatomic,copy)NSString *extension;




@end

NS_ASSUME_NONNULL_END
