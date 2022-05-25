//
//  CDBleSetResult.h
//  LZAPI
//
//  Created by LELE on 2018/11/20.
//  Copyright © 2018年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  设置类型操作结果
 */
typedef NS_ENUM(NSInteger,CDBleSetResultType){
    CDBleSetResultTypeSuccess =  0,  // 成功
    CDBleSetResultTypeFailue  =  1,  // 失败
    CDBleSetResultTypeOther   =  2   // 不支持或其它
};
@interface CDBleSetResult : NSObject

@property(nonatomic,assign)CDBleSetResultType resultType;
/**
 * 设置结果失败原因 成功为@""
 */
@property(nonatomic,copy)NSString *failureResion;
// 失败错误码 -- 对应协议错误码字符串
@property(nonatomic,copy)NSString *failureCode;

@end
