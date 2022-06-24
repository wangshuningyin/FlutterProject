//
//  NBOcppDominModel.m
//  Nebual
//
//  Created by LELE on 2020/4/18.
//  Copyright © 2020 chargedot. All rights reserved.
//

#import "NBOcppDomainModel.h"

@implementation NBOcppDomainModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        self.name = dict[@"name"];
        self.domain = dict[@"domain"] == nil ? @"" : dict[@"domain"];
        self.port = dict[@"port"];
        self.type = dict[@"type"];
        self.version = dict[@"version"];
        self.tls = [dict[@"tls"] integerValue];
        self.execute = [dict[@"execute"] integerValue];
        self.code = dict[@"code"];
        self.url = dict[@"url"];
        self.certId = [dict[@"certId"] integerValue];
        self.securityKey = dict[@"passphrase"];
        self.passSupprot = [dict[@"passSupprot"] integerValue];
        self.location = dict[@"location"] == nil ? @"" : dict[@"location"];
        self.applyVersion = dict[@"applyVersion"];
        self.domainId = [dict[@"id"] integerValue];
        self.aliasNumber = dict[@"aliasNumber"] == nil ? @"" : dict[@"aliasNumber"];
    }
    return self;
}


@end
