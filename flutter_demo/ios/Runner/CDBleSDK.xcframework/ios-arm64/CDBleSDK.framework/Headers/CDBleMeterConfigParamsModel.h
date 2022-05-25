//
//  CDBleMeterConfigParamsModel.h
//  CDBleSDK
//
//  Created by LELE on 2021/7/8.
//  Copyright © 2021 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleMeterConfigParamsModel : NSObject
// 结果码 查询时使用 0 查询到配置结果  1 未查询到配置结果 后续无数据   2 不支持电表配置 后续无数据 
@property(nonatomic,assign)NSInteger resultCode;
// 配置类型 1 标准配置  2 自定义配置
@property(nonatomic,assign)NSInteger configType;

@property(nonatomic,assign)NSInteger mfLen;
@property(nonatomic,copy)NSString *mf;
@property(nonatomic,assign)NSInteger pnLen;
@property(nonatomic,copy)NSString *pn;
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

@property(nonatomic,assign)NSInteger meterConfigLen;

/**** 电表参数内容 ****/
// 3  4
@property(nonatomic,assign)NSInteger readCmd;
// 1 3
@property(nonatomic,assign)NSInteger phaseNumber;
// 电压
@property(nonatomic,assign)NSInteger vDataType;
// 电压测量精度 0 表示 1   1 表示 0.1  2 表示 0.01  3 表示 0.001
@property(nonatomic,assign)NSInteger vREGAccuracy;
// 电压单位 0 mv  1 v  2 kv
@property(nonatomic,assign)NSInteger vREGUnit;
// L1 寄存器地址
@property(nonatomic,assign)NSInteger vL1N;
// L2 寄存器地址
@property(nonatomic,assign)NSInteger vL2N;
// L3 寄存器地址
@property(nonatomic,assign)NSInteger vL3N;


// 电流
@property(nonatomic,assign)NSInteger cDataType;
// 电流测量精度，0表示1，1表示0.1，2表示0.01，3表示0.001
@property(nonatomic,assign)NSInteger cREGAccuracy;
// 电流单位，0表示mA，1表示A，2表示kA
@property(nonatomic,assign)NSInteger cREGUnit;
// L1电流寄存器地址
@property(nonatomic,assign)NSInteger cL1;
// L2电流寄存器地址
@property(nonatomic,assign)NSInteger cL2;
// L3电流寄存器地址
@property(nonatomic,assign)NSInteger cL3;


// 功率
@property(nonatomic,assign)NSInteger pDataType;
// 功率测量精度，0表示1，1表示0.1，2表示0.01，3表示0.001
@property(nonatomic,assign)NSInteger pREGAccuracy;
// 功率单位，0表示W，1表示kW
@property(nonatomic,assign)NSInteger pREGUnit;
// 总功率寄存器地址
@property(nonatomic,assign)NSInteger pTotal;
// L1功率寄存器地址
@property(nonatomic,assign)NSInteger pL1;
// L2功率寄存器地址
@property(nonatomic,assign)NSInteger pL2;
// L3功率寄存器地址
@property(nonatomic,assign)NSInteger pL3;


// 表示下表定义
@property(nonatomic,assign)NSInteger eDataType;
// 电量测量精度，0表示1，1表示0.1，2表示0.01，3表示0.001
@property(nonatomic,assign)NSInteger eREGAccuracy;
// 电量单位，0表示Wh，1表示kWh
@property(nonatomic,assign)NSInteger eREGUnit;
// 总电量寄存器地址
@property(nonatomic,assign)NSInteger eTotal;


@end

NS_ASSUME_NONNULL_END
