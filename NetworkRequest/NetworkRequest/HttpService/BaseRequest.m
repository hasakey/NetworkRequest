//
//  BaseRequest.m
//  EducationPlatform
//
//  Created by 同筑科技 on 2017/5/17.
//  Copyright © 2017年 well. All rights reserved.
//

#define URL_BASE @"http://www.quanmin.tv/json/app/"
#define FILEURL_BASE @"http://www.quanmin.tv/json/app/"

#import "BaseRequest.h"
#import "SessionManager.h"

@implementation BaseRequest


-(void)requestWithParameter:(NSMutableDictionary *)parameter
{
    NSString *url = [self getUrl];
    
//    __weak typeof(self) weakSelf = self;
    
    if (parameter == nil) {
        parameter = [NSMutableDictionary dictionary];
    }
    
    NSString *requestName = [self getServiceName];
    NSLog(@" %@ request Start",requestName);
    
    [SessionManager postJSONWithMethod:url parameters:parameter success:^(id responseObject) {
        
        NSLog(@"%@ request success parameter : %@",requestName ,parameter);
    
    if ([self.httpDelegate respondsToSelector:@selector(requestResultWithData:RequestName:RequestResult:)]) {
        [self.httpDelegate requestResultWithData:responseObject RequestName:requestName RequestResult:RequestSuccess];
    }

        
    } fail:^{
        
        NSLog(@"%@ request fail",requestName);
    }];
}

#pragma warning     未完
-(void)uploadWithData:(NSMutableArray *)data
{
    NSString *url = [self getUrl];
    NSString *requestName = [self getServiceName];
    NSLog(@" %@ request Start",requestName);
    
    [SessionManager upLoadFileURL:url Data:data success:^(id responseObject) {
        
    if ([self.httpDelegate respondsToSelector:@selector(requestResultWithData:RequestName:RequestResult:)]) {
        [self.httpDelegate requestResultWithData:[responseObject valueForKey:@"Data"] RequestName:requestName RequestResult:RequestSuccess];
    }
        
        
    } fail:^{
        NSLog(@"%@ request fail",requestName);
    }];
}

#pragma mark  - Methods


#pragma mark  - 文件下载
-(void)downLoadFileURL:(NSString *)url SavePath:(NSString *)savePath{

    NSString *fileurl = [self addDownLoadFileBaseUrl:url];;
    NSString *requestName = [self getServiceName];
    NSLog(@" %@ request Start",requestName);
//    [SessionManager downLoadFileURL:fileurl savePath:savePath];
    [SessionManager downLoadFileURL:fileurl savePath:savePath success:^{
        if ([self.httpDelegate respondsToSelector:@selector(requestResultWithData:RequestName:RequestResult:)]) {
            [self.httpDelegate requestResultWithData:nil RequestName:requestName RequestResult:RequestSuccess];
        }
    } fail:^{
        if ([self.httpDelegate respondsToSelector:@selector(requestResultWithData:RequestName:RequestResult:)]) {
            [self.httpDelegate requestResultWithData:nil RequestName:requestName RequestResult:RequestFail];
        }
    }];

}


#pragma mark - 获取调用服务的接口名称
-(NSString *)getServiceName
{
    return @"";
}
     
#pragma mark - 将服务器接口
-(NSString *)getUrl
{
    return [self addBaseUrl:@""];

}

#pragma mark 拼接接口
-(NSString *)addBaseUrl:(NSString *)url
{
    return [NSString stringWithFormat:@"%@%@",URL_BASE,url];
}

#pragma mark 文件接口
-(NSString *)addFileBaseUrl:(NSString *)url
{
    return [NSString stringWithFormat:@"%@%@",FILEURL_BASE,url];
}

#pragma mark 下载文件接口
-(NSString *)addDownLoadFileBaseUrl:(NSString *)url
{
    return [NSString stringWithFormat:@"%@%@",FILEURL_BASE,url];
}

@end
