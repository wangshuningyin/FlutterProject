//
//  APNParamsModel.h
//  Runner
//
//  Created by NingSpeals on 2022/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APNParamsModel : NSObject
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

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
