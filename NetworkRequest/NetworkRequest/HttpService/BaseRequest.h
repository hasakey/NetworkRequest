//
//  BaseRequest.h
//  EducationPlatform
//
//  Created by 同筑科技 on 2017/5/17.
//  Copyright © 2017年 well. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//请求结果
typedef enum : NSUInteger {
    RequestSuccess,
    RequestFail,
} RequestResult;

@class BaseRequest;

@protocol BaseRequestDelegate <NSObject>

@required

//代理方法
-(void)requestResultWithData:(id)data RequestName:(NSString *)requestName RequestResult:(RequestResult)requestResult;

@end

@interface BaseRequest : NSObject

@property (nonatomic,retain)id <BaseRequestDelegate>httpDelegate;



/**
 进行请求

 @param parameter 传入的参数
 */
-(void)requestWithParameter:(NSMutableDictionary *)parameter;


/**
 上传文件

 @param data 需要上传的文件
 */
-(void)uploadWithData:(NSMutableArray *)data;


/**
 下载文件

 @param url 接口地址
 @param savePath 储存地址
 */
-(void)downLoadFileURL:(NSString *)url SavePath:(NSString *)savePath;

/**
 获取调用服务的接口名称
 */
-(NSString *)getServiceName;

/**
 获取服务器地址
 */
-(NSString *)getUrl;

/**
 拼接接口

 @param url api接口
 @return 拼接后的接口
 */
-(NSString *)addBaseUrl:(NSString *)url;


/**
 文件服务器地址

 @param url api接口
 @return 拼接后的接口
 */
-(NSString *)addFileBaseUrl:(NSString *)url;


@end

