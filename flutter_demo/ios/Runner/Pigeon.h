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
- (void)queryEnableConfigWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)getEnableWithCompletion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)enableConfigWithCompletion:(void(^)(FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)scanQRCodeWithCompletion:(void(^)(FlutterError *_Nullable))completion;
@end

extern void FLTCallBluetoothSDKSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTCallBluetoothSDK> *_Nullable api);

/// The codec used by FLTMyApi.
NSObject<FlutterMessageCodec> *FLTMyApiGetCodec(void);

@interface FLTMyApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)sessionInValidWithCompletion:(void(^)(NSError *_Nullable))completion;
@end
NS_ASSUME_NONNULL_END
