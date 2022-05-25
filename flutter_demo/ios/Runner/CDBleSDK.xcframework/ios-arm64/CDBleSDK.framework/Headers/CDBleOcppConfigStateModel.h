//
//  CDBleOcppConfigStateModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/4/20.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CDBleOcppConfigState){
    CDBleOcppConfigStateConfiguration                   =     1  ,
    CDBleOcppConfigStateSecretkeyAuthentication         =     2  ,
    CDBleOcppConfigStateSecretkeyAuthenticationFailed   =     3  ,
    CDBleOcppConfigStateSecretkeyAuthenticationSuccess  =     4  ,
    CDBleOcppConfigStateCerDownloading                  =     5  ,
    CDBleOcppConfigStateCerDownloadSuccess              =     6  ,
    CDBleOcppConfigStateCerDownloadFiled                =     7  ,
    CDBleOcppConfigStateConfigurationSuccess            =     8  ,
    CDBleOcppConfigStateConfigurationFailed             =     9  ,
    CDBleOcppConfigStateNone                            =     10
};

@interface CDBleOcppConfigStateModel : NSObject
@property(nonatomic,assign)CDBleOcppConfigState configState;
@end

NS_ASSUME_NONNULL_END
