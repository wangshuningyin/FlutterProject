//
//  CDBleBaseChargeData.h
//  LZAPI
//
//  Created by LELE on 2018/11/21.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDBleBaseChargeData : NSObject
/**
 *  流水号
 */
@property(nonatomic,copy)NSString* serialNumber;
/**
 *  充电电量(度) kw*h
 */
@property(nonatomic,copy)NSString* elecQuantity;

/**
 *  充电电压(V)
 */
@property(nonatomic,copy)NSString* voltage;

/**
 *  充电电流(A)
 */
@property(nonatomic,assign)NSString* electric;
/**
 *  充电时长(s)
 */
@property(nonatomic,assign)UInt64 duration;

@end
