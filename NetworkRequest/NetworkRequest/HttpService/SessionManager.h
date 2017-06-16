//
//  SessionManager.h
//  EducationPlatform
//
//  Created by 同筑科技 on 2017/5/15.
//  Copyright © 2017年 well. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SessionManager : AFHTTPSessionManager


/**
 post请求

 @param method url
 @param parameters 参数
 @param success 成功的block
 @param fail 失败的block
 */
+ (void)postJSONWithMethod:(NSString *)method parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;



/**
 文件上传

 @param url 上传地址
 @param Data 上传的文件
 */
+ (void)upLoadFileURL:(NSString *)url Data:(NSMutableArray *)Data success:(void (^)(id responseObject))success fail:(void (^)())fail;

/**
 下载请求

 @param url 下载地址
 @param savePath 保存地址
 */
+ (void)downLoadFileURL:(NSString *)url savePath:(NSString *)savePath success:(void (^)())success fail:(void (^)())fail;

/**
 监测网络状态
 */
+ (void)AFNetworkStatus;

@end
