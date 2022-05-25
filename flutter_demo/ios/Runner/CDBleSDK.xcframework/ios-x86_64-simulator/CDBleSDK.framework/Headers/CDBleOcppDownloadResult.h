//
//  CDBleOcppDownloadResult.h
//  CDBleSDK
//
//  Created by LELE on 2020/4/20.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CDBleOcppDownloadResultState){
    CDBleOcppDownloadResultStateNone           =    0 ,
    CDBleOcppDownloadResultStateLoading        =    1 ,
    CDBleOcppDownloadResultStateFailed         =    2 ,
    CDBleOcppDownloadResultStateFieldNotRetry  =    3 , // 失败不尝试下载
    CDBleOcppDownloadResultStateSuccess        =    4
};
@interface CDBleOcppDownloadResult : NSObject

@property(nonatomic,assign)CDBleOcppDownloadResultState resultState;

@end

NS_ASSUME_NONNULL_END
