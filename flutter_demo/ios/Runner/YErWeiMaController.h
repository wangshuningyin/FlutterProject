//
//  YErWeiMaController.h
//  Anyo
//
//  Created by LELE on 16/12/27.
//  Copyright © 2016年 rect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErweimaBaseController.h"
typedef enum{
    YErWeiMaControllerType_Nor        =    0,
    YErWeiMaControllerType_HP9        =    1,
    YErWeiMaControllerType_BindPie    =    2
}YErWeiMaControllerType;
typedef  void(^YErWeiMaControllerScanResultBlock)(NSString* scanResult,NSString* try_occupy_by,BOOL is_private);
@interface YErWeiMaController: ErweimaBaseController
@property(nonatomic,copy)YErWeiMaControllerScanResultBlock scanBlock;
@property(nonatomic,assign)YErWeiMaControllerType erweimaVcType;
@property(nonatomic,copy)NSString* orderNum; // 订单号
@end
