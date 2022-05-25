//
//  CDBleChargeHistory.h
//  LZAPI
//
//  Created by LELE on 2018/11/20.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleQueryChargerState.h"
@interface CDBleChargeHistory : CDBleQueryChargerState
@property(nonatomic,copy)NSString* startTime;
@property(nonatomic,copy)NSString* endTime;
@property(nonatomic,copy)NSString* orderNum;
/**
 * 启动方式
 */
@property(nonatomic,assign)NSInteger startingMode;
/**
 * 联网模式
 */
@property(nonatomic,assign)NSInteger nettingMode;
/**
 * 用户类型
 */
@property(nonatomic,assign)NSInteger userType;
/**
 * 用户识别码类型
 */
@property(nonatomic,assign)NSInteger userIdType;
/**
 * 用户识别码内容
 */
@property(nonatomic,copy)NSString *userIdContent;
/**
 * 结束原因
 数字，充电结束原因，与OCPP协议 StopTransaction 中Reason字段一致。
 0x00:  Other 其他原因（未知）
 0x01:  DeAuthorized 权限认证失败（未授权或认证过期）
 0x02:  EmergencyStop 急停按下
 0x03:  EVDisconnected 车端断开
 0x04:  HardReset 远程下发硬重启
 0x05:  Local 本地停止（刷卡）
 0x06:  PowerLoss （断电）
 0x07:  Reboot 本地重启
 0x08:  Remote 远程停止（平台强制停止以及APP主动停止）
 0x09:  SoftReset 平台下发软重启
 0x0A:  UnlockCommand 平台下发解锁指令
 */
@property(nonatomic,assign)NSInteger stopReason;

@end
