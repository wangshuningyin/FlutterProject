//
//  CDBleReportState.h
//  CDBleSDK
//
//  Created by LELE on 2021/12/22.
//  Copyright © 2021 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleReportStateModel : NSObject
// 功能 id
@property(nonatomic,assign)NSInteger functionId;
// 对应状态
@property(nonatomic,copy)NSString *state;

@end

NS_ASSUME_NONNULL_END
