// Autogenerated from Pigeon (v1.0.19), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "Pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}



@interface FLTApiCodecReader : FlutterStandardReader
@end
@implementation FLTApiCodecReader
@end

@interface FLTApiCodecWriter : FlutterStandardWriter
@end
@implementation FLTApiCodecWriter
@end

@interface FLTApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTApiCodecReaderWriter *readerWriter = [[FLTApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void FLTApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.Api.getPlatformVersion"
        binaryMessenger:binaryMessenger
        codec:FLTApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getPlatformVersionWithCompletion:)], @"FLTApi api (%@) doesn't respond to @selector(getPlatformVersionWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getPlatformVersionWithCompletion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface FLTCallBluetoothSDKCodecReader : FlutterStandardReader
@end
@implementation FLTCallBluetoothSDKCodecReader
@end

@interface FLTCallBluetoothSDKCodecWriter : FlutterStandardWriter
@end
@implementation FLTCallBluetoothSDKCodecWriter
@end

@interface FLTCallBluetoothSDKCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTCallBluetoothSDKCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTCallBluetoothSDKCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTCallBluetoothSDKCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTCallBluetoothSDKGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTCallBluetoothSDKCodecReaderWriter *readerWriter = [[FLTCallBluetoothSDKCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void FLTCallBluetoothSDKSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTCallBluetoothSDK> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getDeviceNames"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getDeviceNamesWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getDeviceNamesWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getDeviceNamesWithCompletion:^(NSArray<NSString *> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.startBluetooth"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(startBluetoothWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(startBluetoothWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api startBluetoothWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.scanForPeripherals"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(scanForPeripheralsWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(scanForPeripheralsWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api scanForPeripheralsWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.startConnectPeripheral"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(startConnectPeripheralWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(startConnectPeripheralWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api startConnectPeripheralWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.isConnectPeripheralSuccess"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isConnectPeripheralSuccessWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(isConnectPeripheralSuccessWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api isConnectPeripheralSuccessWithCompletion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getConnectDeviceName"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getConnectDeviceNameName:completion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getConnectDeviceNameName:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_name = args[0];
        [api getConnectDeviceNameName:arg_name completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.stopConnectPeripheral"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(stopConnectPeripheralWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(stopConnectPeripheralWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api stopConnectPeripheralWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.isDisConnectPeripheralSuccess"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isDisConnectPeripheralSuccessWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(isDisConnectPeripheralSuccessWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api isDisConnectPeripheralSuccessWithCompletion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.isConnectedPeripheral"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isConnectedPeripheralWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(isConnectedPeripheralWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api isConnectedPeripheralWithCompletion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.queryEnableConfig"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(queryEnableConfigWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(queryEnableConfigWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api queryEnableConfigWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getFreeVendingEnable"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getFreeVendingEnableWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getFreeVendingEnableWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getFreeVendingEnableWithCompletion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getConfigServerEnable"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getConfigServerEnableWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getConfigServerEnableWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getConfigServerEnableWithCompletion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.enableConfig"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(enableConfigEnableConfigBinaryStr:completion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(enableConfigEnableConfigBinaryStr:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_enableConfigBinaryStr = args[0];
        [api enableConfigEnableConfigBinaryStr:arg_enableConfigBinaryStr completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.isEnableSuccess"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isEnableSuccessWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(isEnableSuccessWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api isEnableSuccessWithCompletion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.scanQRCode"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(scanQRCodeWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(scanQRCodeWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api scanQRCodeWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.queryDeviceSystemInfo"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(queryDeviceSystemInfoWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(queryDeviceSystemInfoWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api queryDeviceSystemInfoWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getSystemInfoList"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getSystemInfoListWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getSystemInfoListWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getSystemInfoListWithCompletion:^(NSArray<NSString *> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.queryNetworkState"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(queryNetworkStateWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(queryNetworkStateWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api queryNetworkStateWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.queryDeviceConfigType"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(queryDeviceConfigTypeWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(queryDeviceConfigTypeWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api queryDeviceConfigTypeWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.queryOCPPConfigParams"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(queryOCPPConfigParamsWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(queryOCPPConfigParamsWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api queryOCPPConfigParamsWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getNetworkingStateData"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getNetworkingStateDataWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getNetworkingStateDataWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getNetworkingStateDataWithCompletion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getDeviceConfigData"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getDeviceConfigDataWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getDeviceConfigDataWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getDeviceConfigDataWithCompletion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getDomain"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getDomainWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getDomainWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getDomainWithCompletion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.CallBluetoothSDK.getDomainSuffix"
        binaryMessenger:binaryMessenger
        codec:FLTCallBluetoothSDKGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getDomainSuffixWithCompletion:)], @"FLTCallBluetoothSDK api (%@) doesn't respond to @selector(getDomainSuffixWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getDomainSuffixWithCompletion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface FLTMyApiCodecReader : FlutterStandardReader
@end
@implementation FLTMyApiCodecReader
@end

@interface FLTMyApiCodecWriter : FlutterStandardWriter
@end
@implementation FLTMyApiCodecWriter
@end

@interface FLTMyApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTMyApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTMyApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTMyApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTMyApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTMyApiCodecReaderWriter *readerWriter = [[FLTMyApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


@interface FLTMyApi ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation FLTMyApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)sessionInValidWithCompletion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.MyApi.sessionInValid"
      binaryMessenger:self.binaryMessenger
      codec:FLTMyApiGetCodec()];
  [channel sendMessage:nil reply:^(id reply) {
    completion(nil);
  }];
}
@end
