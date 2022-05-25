//
//  CDBleOcppConfigParamsModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/4/19.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleOcppConfigParamsModel : NSObject
// 0 立即启动  1 暂不启动
@property(nonatomic,assign)NSInteger servreEnable;

@property(nonatomic,assign)NSInteger domainLen;
// 域名
@property(nonatomic,copy)NSString *domain;
// 端口
@property(nonatomic,copy)NSString *port;
// 1 ocpp  2 chargedot
@property(nonatomic,assign)NSInteger protocalType;

// eg: 1 ocpp15j  2 ocpp15s ....
@property(nonatomic,copy)NSString *protocalVersion;
// 密钥长度
@property(nonatomic,assign)NSInteger cerLen;
// 密钥
@property(nonatomic,copy)NSString *securityKey;

// 0 未启动  1 启动
@property(nonatomic,assign)NSInteger TLS_Enable;

@property(nonatomic,assign)NSInteger rootCerNumber;

@property(nonatomic,assign)NSInteger rootCerLen;
// 分段下载字节数组大小
@property(nonatomic,assign)NSInteger downloadSize;
// 证书文件信息
@property(nonatomic,strong)NSData *cerInfoData;
// 是否是默认连接  0x00 默认服务器域名  0x01 连接第三方服务器域名
@property(nonatomic,assign)NSInteger isConnectDefaulDomain;
// 后缀标识符长度
@property(nonatomic,assign)NSInteger domainSuffixLen;
// 后缀标识符内容
@property(nonatomic,copy)NSString *domainSuffix;

@end

NS_ASSUME_NONNULL_END
