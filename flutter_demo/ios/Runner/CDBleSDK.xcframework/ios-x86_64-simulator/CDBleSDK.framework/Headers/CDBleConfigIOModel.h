//
//  CDBleConfigIOModel.h
//  CDBleSDK
//
//  Created by LELE on 2021/11/3.
//  Copyright © 2021 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleConfigIOModel : NSObject
// 0 后续数据非法  1 后续数据合法
@property(nonatomic,assign)NSInteger resultCode;
/**
 * 0 关闭所有功能
 * 1 Pause
 * 2 Free vending
 * 3 Authenticate
 */
@property(nonatomic,assign)NSInteger inFuncId;
@property(nonatomic,copy)NSString *inAddtition;
/**
 * 0 关闭所有功能
 * 1 Power relay guard
 * 2 Charging
 * 3 Active session
 * 4 Avaliable
 * 5 Error
 */
@property(nonatomic,assign)NSInteger outFuncId;
@property(nonatomic,copy)NSString *outAddtition;


@end

NS_ASSUME_NONNULL_END
