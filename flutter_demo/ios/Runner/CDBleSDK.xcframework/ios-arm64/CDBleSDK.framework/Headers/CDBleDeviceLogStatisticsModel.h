//
//  CDBleDeviceLogStatisticsModel.h
//  CDBleSDK
//
//  Created by LELE on 2019/12/24.
//  Copyright © 2019 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleDeviceLogStatisticsModel : NSObject
// 日志序列号最小值
@property(nonatomic,assign)NSInteger serialNumberMin;
// 日志序列号最大值
@property(nonatomic,assign)NSInteger serialNumberMax;
// 总数
@property(nonatomic,assign)NSInteger totalCnt;

@end

NS_ASSUME_NONNULL_END
