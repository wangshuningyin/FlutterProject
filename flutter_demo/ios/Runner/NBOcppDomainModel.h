//
//  NBOcppDominModel.h
//  Nebual
//
//  Created by LELE on 2020/4/18.
//  Copyright © 2020 chargedot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NBOcppDomainModel : NSObject
@property(nonatomic,copy)NSString *name;
// 域名
@property(nonatomic,copy)NSString *domain;
@property(nonatomic,copy)NSString *port;
// 协议类型 OCPP或CHARGEDOT
@property(nonatomic,copy)NSString *type;
// 协议版本(参考蓝牙协议)
@property(nonatomic,copy)NSString *version;
// 是否支持tls(1支持0不支持, 支持则需要证书，不支持则不需要证书)
@property(nonatomic,assign)NSInteger tls;
// 是否启用此连接(1开启0关闭)
@property(nonatomic,assign)NSInteger execute;
// 证书编号
@property(nonatomic,copy)NSString *code;
// 证书 id
@property(nonatomic,assign)NSInteger certId;
// url
@property(nonatomic,copy)NSString *url;
// 桩本身的密钥
@property(nonatomic,copy)NSString *securityKey;
// 是否启用密码验证默认 1启用    0关闭   若0关闭，则发给桩端密码len=0  若1启用，但密码是"",len=1
@property(nonatomic,assign)NSInteger passSupprot;
// 用户自定义连接地址
@property(nonatomic,copy)NSString *location;
// 自定义地址适配版本示例 “0.5.18,0.5.19,1.0.8+”，其中“1.0.8+”表示桩端软件 为1.0.8及往后版本都支持自定义配置。
@property(nonatomic,copy)NSString *applyVersion;
// 当前版本是否支持当前域名模型的自定义数据 Default is NO
@property(nonatomic,assign)BOOL isSupportLocationDomain;

@property(nonatomic,assign)NSInteger domainId;
// 别名
@property(nonatomic,copy)NSString *aliasNumber;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
