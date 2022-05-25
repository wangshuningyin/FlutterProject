//
//  CDBlePowerControlModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/7/8.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBlePowerControlModel : NSObject
// 设置最大输出功率
@property(nonatomic,copy)NSString *outputMaxPower;
// 输出功率
@property(nonatomic,copy)NSString *outputPower;


@end

NS_ASSUME_NONNULL_END
