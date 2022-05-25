//
//  CDBleDeviceLogModel.h
//  CDBleSDK
//
//  Created by LELE on 2019/12/24.
//  Copyright © 2019 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleDeviceLogModel : NSObject
// 日志序列号
@property(nonatomic,assign)NSInteger serialNumber;
// 日志生成时间
@property(nonatomic,assign)NSInteger generateTime;
// 日志类型
@property(nonatomic,assign)NSInteger type;
//  ocpp 对应的日志类型
@property(nonatomic,copy)NSString *typeOcpp;
// 日志信息码
@property(nonatomic,assign)NSInteger infoCode;
// 日志信息码描述
@property(nonatomic,copy)NSString *infoCodeDestription;
// 日志信息码原始数据
@property(nonatomic,copy)NSString *infoCodeOriginDataStr;
// ocpp 日志对应信息码
@property(nonatomic,copy)NSString *infoCodeOcpp;
// 附加数据  附加数据如果为用户类型  factoryUser(工厂)  operationUser(运维)  carUser(车主)  otherUser(其它)
@property(nonatomic,copy)NSString *attachment;
// 附加数据是否是用户类型 default is no
@property(nonatomic,assign)BOOL attachmentIsUserType;
@end

NS_ASSUME_NONNULL_END
