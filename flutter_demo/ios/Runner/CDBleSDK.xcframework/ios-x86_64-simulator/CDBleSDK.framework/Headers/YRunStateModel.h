//
//  YRunStateModel.h
//  ddkz
//
//  Created by LELE on 17/10/13.
//  Copyright © 2017年 rect. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,YRunStateDetailType){
   YRunStateDetailTypeNor    =          0 ,
   YRunStateDetailTypePlain  =          1 ,
   YRunStateDetailTypeError  =          2 ,
};
@interface YRunStateModel : NSObject
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* content;
@property(nonatomic,assign)YRunStateDetailType detailType;
@end
