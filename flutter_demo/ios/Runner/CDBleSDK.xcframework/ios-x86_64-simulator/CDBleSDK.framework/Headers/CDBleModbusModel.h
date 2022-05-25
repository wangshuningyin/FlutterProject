//
//  CDBleModbusModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/10/19.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ModbusProtocalType){
    ModbusProtocalTypeRTU    =    0 ,
    ModbusProtocalTypeTCP    =    1
};

typedef NS_ENUM(NSInteger,ModbusModeType){
    ModbusModeTypeSlave    =    0 ,  // 从机
    ModbusModeTypeHost     =    1 ,  // 主机
    ModbusModeTypeOff      =    2    // 禁用
};

@interface CDBleModbusModel : NSObject
// modbus 模式
@property(nonatomic,assign)ModbusModeType modeType;
// 协议类型 rtu / tcp
@property(nonatomic,assign)ModbusProtocalType modbusProtocalType;
// 从机地址
@property(nonatomic,assign)NSInteger meterRTU;
// 波特率
@property(nonatomic,assign)NSInteger modbusRTU;
// 校验位
@property(nonatomic,assign)NSInteger dataVerifyBitRTU;
// 停止位
@property(nonatomic,assign)NSInteger dataStopBitRTU;
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
