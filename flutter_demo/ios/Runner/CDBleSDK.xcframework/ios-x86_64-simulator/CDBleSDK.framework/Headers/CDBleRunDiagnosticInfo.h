//
//  CDBleRunDiagnosticInfo.h
//  LZAPI
//
//  Created by LELE on 2018/11/20.
//  Copyright © 2018年 rect. All rights reserved.
//
/**
 *  桩运行诊断信息
 */

#import <Foundation/Foundation.h>

@interface CDBleRunDiagnosticInfo : NSObject

/**
 *  启动方式
 *  0 立即模式   1 定时模式
 */
@property(nonatomic,assign)NSInteger startMode;
/**
 * 版本号
 */
@property(nonatomic,copy)NSString* versionNum;
/**
 * 电表工作状态
 */
@property(nonatomic,copy)NSString* ammeterState;
/**
 * 开始时间
 */
@property(nonatomic,copy)NSString* startTime;
/**
 * 枪的状态  充电/空闲
 */
@property(nonatomic,copy)NSString* chargeState;
/**
 * 电压
 */
@property(nonatomic,copy)NSString* voltage;
/**
 * 电流
 */
@property(nonatomic,copy)NSString* elec;
/**
 * 错误信息
 */
@property(nonatomic,copy)NSString* errorInfo;
/**
 * 网络连接状态
 */
@property(nonatomic,copy)NSString* netConnectState;

/**
 * 屏幕工作状态
 */
@property(nonatomic,copy)NSString* screenWorkingState;

/**
 * 电子锁状态
 */
@property(nonatomic,copy)NSString* elecLockState;

@end
