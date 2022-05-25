//
//  CDBleScheduleModel.h
//  CDBleSDK
//
//  Created by LELE on 2021/1/8.
//  Copyright © 2021 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CDBleScheduleType){
    CDBleScheduleTypeOff     =     0 ,
    CDBleScheduleTypeOn      =     1
};
@interface CDBleScheduleModel : NSObject
@property(nonatomic,assign)CDBleScheduleType scheduleType;
@property(nonatomic,copy)NSString *startedAt;
@property(nonatomic,copy)NSString *finishedAt;

@end

NS_ASSUME_NONNULL_END
