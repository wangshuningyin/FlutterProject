//
//  CDBleCardMode.h
//  CDBleSDK
//
//  Created by LELE on 2020/7/22.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBleSetResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface CDBleCardMode : NSObject
@property(nonatomic,strong)CDBleSetResult *result;
@property(nonatomic,copy)NSString *cardNum;
@end

NS_ASSUME_NONNULL_END
