//
//  SessionManager.m
//  EducationPlatform
//
//  Created by 同筑科技 on 2017/5/15.
//  Copyright © 2017年 well. All rights reserved.
//

#import "SessionManager.h"
//默认超时时间20s
static int const DEFAULT_REQUEST_TIME_OUT = 120;

@implementation SessionManager


#pragma mark  - Post请求
+ (void)postJSONWithMethod:(NSString *)method parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
//    [SessionManager AFNetworkStatus];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *webURL = method;
    
    NSString *webURL_convert = [webURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //    超时时间
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSLog(@"postAddress:%@ postParameters:%@",webURL,parameters);
    
    [manager POST:webURL_convert parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印进度
        NSLog(@"%lf",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            NSLog(@"ERRORERROR--%@",error);
            fail();
        }
    }];

}


#pragma mark  - 文件下载
+ (void)downLoadFileURL:(NSString *)url savePath:(NSString *)savePath success:(void (^)())success fail:(void (^)())fail
{
    
//    [SessionManager AFNetworkStatus];
    //创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
//        NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:savePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSLog(@"%ld--%@",(long)httpResponse.statusCode,filePath);
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        id dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (httpResponse.statusCode == 200) {
            if (success) {
                success();
            }
        }else
        {
            if (fail) {
                fail();
            }
        }
       
    
        
    }];
    
    //开始启动任务
    [task resume];
    
    
    
}

#pragma mark  - 文件上传
+ (void)upLoadFileURL:(NSString *)url Data:(NSMutableArray *)Data success:(void (^)(id))success fail:(void (^)())fail{
    

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *webURL = url;
    
    NSString *webURL_convert = [webURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"地址地址地址%@",webURL_convert);
    //创建请求对象
    
    [manager POST:webURL_convert parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *Key = [userDefaults objectForKey:KEY];
//        [formData appendPartWithFormData:[Key dataUsingEncoding:NSUTF8StringEncoding] name:@"Key"];
        
        
        for (int i = 0; i<Data.count; i++) {
            NSString *filePath = [Data objectAtIndex:i];
            NSData *imageData = [NSData dataWithContentsOfFile:filePath];
            [formData appendPartWithFileData:imageData name:@"file" fileName:[filePath lastPathComponent] mimeType:@"image/jpeg"];
        }
        
        NSLog(@"formDataformDataformDataformData%@",formData);
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
//            NSLog(@"test %@",[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil]);
            success([NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail();
        }
    }];
    

    
}



#pragma mark  - 网络监测
+ (void)AFNetworkStatus{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}

@end
