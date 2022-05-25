//
//  CDBleCardsWhiteListParamsModel.h
//  CDBleSDK
//
//  Created by LELE on 2020/11/23.
//  Copyright © 2020 rect. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CDBleCardsWhiteListCmdType){
    CDBleCardsWhiteListCmdTypeRead      =    1 ,
    CDBleCardsWhiteListCmdTypeWrite     =    2 ,
    CDBleCardsWhiteListCmdTypeRemove    =    3 ,
    CDBleCardsWhiteListCmdTypeReset     =    4
};
@interface CDBleCardsWhiteListParamsModel : NSObject
@property(nonatomic,assign)CDBleCardsWhiteListCmdType cmdType;
// cmdType Read 时 cardCount 为卡数量 ， 为其它类型时 cardCount = 0 失败 ; cardCount = 1  成功
@property(nonatomic,assign)NSInteger cardCount;
@property(nonatomic,strong)NSArray *cardList;
@end

NS_ASSUME_NONNULL_END
