//
//  CDBleAFNParams.h
//  CDBleSDK
//
//  Created by LELE on 2020/5/18.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleAPNParamsModel : NSObject
// 设置 APN 类型  0x00 清除    0x01 重设   0x00 下后续字节为空
@property(nonatomic,assign)NSInteger apnType;
@property(nonatomic,assign)NSInteger apnLen;
@property(nonatomic,copy)NSString *apn;
@property(nonatomic,assign)NSInteger userNameLen;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,assign)NSInteger pswLen;
@property(nonatomic,copy)NSString *psw;
/****  兼容接收数据模型  ****/
// 国际移动设备身份
@property(nonatomic,copy)NSString *imei;
// 国际移动用户身份
@property(nonatomic,copy)NSString *imsi;
// 信号质量
@property(nonatomic,assign)NSInteger csq;

@end

NS_ASSUME_NONNULL_END
