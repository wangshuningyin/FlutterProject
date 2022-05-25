//
//  CDBleChargingData.h
//  LZAPI
//
//  Created by LELE on 2018/11/21.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleBaseChargeData.h"
#import "CDBleDeviceErrorModel.h"
@interface CDBleChargingData : CDBleBaseChargeData
/**
 * 桩的状态 字符串
 * 正在充电中、未知
 0x00：空闲中   即桩当前既不在充电也没有充电
 0x01：插枪未充电
 0x02 充电等待中
 0x03 预约中
 0x04 暂停中 电流小于 6A
 0x05 充电中断中 config IO 引起
 0x06：充电中
 0x08：充电结束未拔枪
 0x0F：故障中
 */

@property(nonatomic,copy)NSString* gunStatus;

/**
 * 错误原因:空字符串时表示无错误原因
 * 过流、过压、欠压、急停按下、未知
 */
@property(nonatomic,copy)NSString* failureReason;
/**
 * 错误原因码
 */
@property(nonatomic,copy)NSString *failureReasonCode;

// 设备故障模型
@property(nonatomic,strong)CDBleDeviceErrorModel *faultModel;

/**
 * 输出相电类型  1 2 3
 */
@property(nonatomic,assign)NSInteger outputPhaseType;

@property(nonatomic,copy)NSString *voltagePhase2;

@property(nonatomic ,copy)NSString *electricPhase2;

@property(nonatomic,copy)NSString *voltagePhase3;

@property(nonatomic ,copy)NSString *electricPhase3;
// 枪线额定电流
@property(nonatomic,assign)NSInteger gunLineRatedCurrent;

@end
