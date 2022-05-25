//
//  CDBleErrorListLog.h
//  LZAPI
//
//  Created by LELE on 2018/11/20.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDBleErrorListLog : NSObject
/**
 *  日期 时间
 */
@property(nonatomic,copy)NSString* date;
/**
 *  错误原因
 错误代码：
 0 急停，过压，欠压，过流等原因，详细错误信息
 1 急停，过压，欠压，过流等原因恢复到正常状态，详细错误信息
 2 充电开始10S后没有电流
 3 充电开始10S后没有电流后恢复正常有电流充电
 4 系统时间被更新
 5 通过管理员卡添加用户卡及添加张数
 6 软件更新成功并重启
 7 停止充电
 8 连接网络
 9 断开网络
 */
@property(nonatomic,assign)UInt64 errorCode;

@end
