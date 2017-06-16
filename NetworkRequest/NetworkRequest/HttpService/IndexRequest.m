//
//  IndexRequest.m
//  NetworkRequest
//
//  Created by 同筑科技 on 2017/6/16.
//  Copyright © 2017年 well. All rights reserved.
//

#import "IndexRequest.h"

@implementation IndexRequest

#pragma mark - 获取调用服务的接口名称
-(NSString *)getServiceName
{
    return @"index";
    
}

#pragma mark - url地址
-(NSString *)getUrl
{
    return [self addBaseUrl:@"index/recommend/list-iphone.json?1497580515"];
}

@end
