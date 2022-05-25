//
//  CDBleConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/10/31.
//  Copyright © 2019 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBleConfig : NSObject
/**
 * 权限等级
 */
@property(nonatomic,assign)NSInteger authorityLevel;

/**
 * 内容
 */
@property(nonatomic,assign)NSString* configContent;

/**
 * 内容是否需要转为 NSInterger
 * default is NO
 */
@property(nonatomic,assign)BOOL isTransformInteger;

@end

NS_ASSUME_NONNULL_END
