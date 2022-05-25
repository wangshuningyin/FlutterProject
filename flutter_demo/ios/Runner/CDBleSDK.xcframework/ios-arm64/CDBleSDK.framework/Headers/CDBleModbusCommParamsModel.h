//
//  CDBleModbusCommParamsModel.h
//  CDBleSDK
//
//  Created by LELE on 2021/7/9.
//  Copyright © 2021 rect. All rights reserved.
//  modbus 通讯参数配置

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleModbusCommParamsModel : NSObject
// 结果码 查询时使用 0 查询到配置结果  1 未查询到配置结果 后续无数据   2 不支持查询 后续无数据
@property(nonatomic,assign)NSInteger resultCode;
// modbus 使能状态 0 打开   1 关闭  2 其它未知
@property(nonatomic,assign)NSInteger modbusEnable;
// 通信类型  0 不配置  1 RTU  2  TCP
@property(nonatomic,assign)NSInteger communicationType;
// 地址
@property(nonatomic,assign)NSInteger rtuAddress;
// 波特率
@property(nonatomic,assign)NSInteger rtuBaudRate;
// 数据位
@property(nonatomic,assign)NSInteger rtuDataBits;
// 校验位
@property(nonatomic,assign)NSInteger rtuCheckBits;
// 停止位
@property(nonatomic,assign)NSInteger rtuStopBits;

// TCP

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

@end

NS_ASSUME_NONNULL_END
