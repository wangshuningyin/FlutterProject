//
//  CDBleDeviceErrorModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/4/2.
//  Copyright © 2020 rect. All rights reserved.
//  设备故障模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleDeviceErrorModel : NSObject
// 故障码 十六进制 多个故障码的话拼接使用逗号分隔
@property(nonatomic,copy)NSString *faultCode;
// 故障原因（英文）多个原因的话拼接使用逗号分隔
@property(nonatomic,copy)NSString *faultReasonEN;
// 故障原因（中文）
@property(nonatomic,copy)NSString *faultReasonCN;
- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
