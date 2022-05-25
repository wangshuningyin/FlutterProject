//
//  CDBleDeviceConfigModel.h
//  CDBleSDK
//
//  Created by LELE on 2021/7/2.
//  Copyright © 2021 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,DeviceConfigType){
    DeviceConfigTypeQueryMacAddress  =    0  //查询 mac address
};

NS_ASSUME_NONNULL_BEGIN

@interface CDBleDeviceConfigModel : NSObject
@property(nonatomic,assign)DeviceConfigType configType;
// 0 查询到对应参数  1  未查询到对应参数  2 不支持该参数
@property(nonatomic,assign)NSInteger resultCode;
// 参数长度
@property(nonatomic,assign)NSInteger paramsLen;
// 参数内容
@property(nonatomic,copy)NSString *params;

@end

NS_ASSUME_NONNULL_END
