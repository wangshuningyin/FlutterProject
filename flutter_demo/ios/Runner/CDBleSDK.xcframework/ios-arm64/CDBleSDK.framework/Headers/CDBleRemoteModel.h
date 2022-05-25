//
//  CDBleRemoteModel.h
//  CDBleSDK
//
//  Created by LELE on 2018/12/24.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDBleRemoteModel : NSObject
@property(nonatomic,assign)CGFloat remoteProgress;
/**
 *  100 成功 1校验码错误 2文件错误 3 其它失败
 */
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString* codeMsg;

@end
