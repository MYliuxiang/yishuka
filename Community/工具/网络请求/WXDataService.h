//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-3-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

typedef void(^FinishBlock) (id result);
typedef void(^ErrorBlock) (NSError *error);
typedef NS_ENUM(NSInteger, RequestType1) {
    RequestPostType1,
    RequestGetType1
};
@interface WXDataService : NSObject
@property (nonatomic, assign, getter=isConnected) BOOL connected;/**<网络是否连接*/
@property (nonatomic,assign)BOOL isNotReachable;
@property (nonatomic,assign)BOOL isHUD;

/**
*  请求通过回调
*
*  @param url          上传文件的 url 地址
*  @param paramsDict   参数字典
*  @param httpMethod   请求类型
*  @param finishBlock  成功
*  @param errorBlock   失败
*   
*/
+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     isHUD:(BOOL)ishud
                               finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)postMP3:(NSString *)url
                            params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                            finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)postImage:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(FinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock;



+ (NSURLSessionUploadTask *)updateURL:(NSString *)urlstring
                               params:(NSDictionary *)params   //文本参数
                            imageArry:(NSArray *)imageArry    //图片参数: {@"key":NSData}
                          finishBlock:(FinishBlock)finishBlock
                           errorBlock:(ErrorBlock)errorBlock;

+ (AFHTTPSessionManager *)postMP4:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(FinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock;


@end
