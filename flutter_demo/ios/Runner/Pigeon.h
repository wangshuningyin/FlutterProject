// Autogenerated from Pigeon (v1.0.19), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN


/// The codec used by FLTApi.
NSObject<FlutterMessageCodec> *FLTApiGetCodec(void);

@protocol FLTApi
/// @return `nil` only when `error != nil`.
- (void)getPlatformVersionWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
@end

extern void FLTApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTApi> *_Nullable api);

/// The codec used by FLTCallBluetoothSDK.
NSObject<FlutterMessageCodec> *FLTCallBluetoothSDKGetCodec(void);

@protocol FLTCallBluetoothSDK
/// @return `nil` only when `error != nil`.
- (void)getDeviceNamesWithCompletion:(void(^)(NSArray<NSString *> *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)startBluetoothWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)scanForPeripheralsWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)startConnectPeripheralWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isConnectPeripheralSuccessWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getConnectDeviceNameName:(nullable NSString *)name completion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)stopConnectPeripheralWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isDisConnectPeripheralSuccessWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isConnectedPeripheralWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)queryEnableConfigWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getFreeVendingEnableWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getConfigServerEnableWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)enableConfigEnableConfigBinaryStr:(nullable NSString *)enableConfigBinaryStr completion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isEnableSuccessWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)scanQRCodeWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)queryDeviceSystemInfoWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getSystemInfoListWithCompletion:(void(^)(NSArray<NSString *> *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)queryNetworkStateWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)queryDeviceConfigTypeWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)queryOCPPConfigParamsWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getNetworkingStateDataWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getDeviceConfigDataWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getDomainWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getDomainSuffixWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)requestOCPPConfigParamsOcppConfigParams:(nullable NSString *)ocppConfigParams completion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isRequestOCPPConfigParamsSuccessWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)queryConfigSSIDParamsWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getSSIDParamsDataWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)queryConfigAPNParamsWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getAPNParamsDataWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)ceAuthenticationWithParamsAuthenticationParams:(nullable NSString *)authenticationParams completion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isCEAuthenticationWithParamsSuccessWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)configAPNWithParamsApnParams:(nullable NSString *)apnParams completion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isConfigAPNWithParamsSuccessWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)configWIFIWithSSIDSsid:(nullable NSString *)ssid psw:(nullable NSString *)psw completion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)isConfigWIFIWithSSIDSuccessWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
@end

extern void FLTCallBluetoothSDKSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTCallBluetoothSDK> *_Nullable api);

/// The codec used by FLTMyApi.
NSObject<FlutterMessageCodec> *FLTMyApiGetCodec(void);

@interface FLTMyApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)sessionInValidWithCompletion:(void(^)(NSError *_Nullable))completion;
@end
NS_ASSUME_NONNULL_END
