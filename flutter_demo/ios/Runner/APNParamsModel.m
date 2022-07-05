//
//  APNParamsModel.m
//  Runner
//
//  Created by NingSpeals on 2022/6/30.
//

#import "APNParamsModel.h"

@implementation APNParamsModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        self.apnType = [dict[@"apnType"] integerValue];
        self.apnLen = [dict[@"apnLen"] integerValue];
        self.apn = dict[@"apn"];
        self.userNameLen = [dict[@"userNameLen"] integerValue];
        self.userName = dict[@"userName"];
        self.pswLen = [dict[@"pswLen"] integerValue];
        self.psw = dict[@"psw"];
        self.imei = dict[@"imei"];
        self.imsi = dict[@"imsi"];
        self.csq = [dict[@"csq"] integerValue];
    }
    return self;
}

@end
