//
//  CDBleQueryChargerState.h
//  LZAPI
//
//  Created by LELE on 2018/11/20.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleBaseChargeData.h"
@interface CDBleQueryChargerState : CDBleBaseChargeData
/**
 *  枪的状态
 */
@property(nonatomic,copy)NSString* gunStatus;

/**
 *  错误原因
 */
@property(nonatomic,copy)NSString* failureReason;

@end
