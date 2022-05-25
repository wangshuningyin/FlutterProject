//
//  CDBleBaseConfig.h
//  CDBleSDK
//
//  Created by LELE on 2019/11/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface CDBleBaseConfig : NSObject
- (instancetype)initWithDict:(NSDictionary*)dict;
- (CDBleConfig *)getConfigWithArray:(NSArray*)configArr;
@end

NS_ASSUME_NONNULL_END
