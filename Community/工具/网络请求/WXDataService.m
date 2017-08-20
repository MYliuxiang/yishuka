//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-3-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "WXDataService.h"

@implementation WXDataService

- (BOOL)isConnected {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

//-(void)Reachability {
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"%@",[NSThread currentThread]);
//        switch (status) {
//            case AFNetworkReachabilityStatusNotReachable:
//            {
//                NSLog(@"无网络");
//                self.isNotReachable = NO;
//            }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            {
//                NSLog(@"有网络");
//                //isuse = @"有网络";
//                 self.isNotReachable = YES;
//            }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//            {
//                NSLog(@"有网络wifi");
//                 self.isNotReachable = YES;
//            }
//                break;
//            default:
//                break;
//        }
//    }];
//}
+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     isHUD:(BOOL)ishud
                               finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock
{
    
    if (ishud) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];

    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    RequestType1 type;
    if ([httpMethod isEqualToString:@"GET"])
    {
        type = RequestGetType1;
    }else{
        type = RequestPostType1;
    
    }
    switch (type) {
        case RequestGetType1:
        {
            
            [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }

                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Error: %@", [error localizedDescription]);

                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {

                    errorBlock(error);
                }

            }];
            

        }
            break;
        case RequestPostType1:
        {
            
            [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }

            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {

                    errorBlock(error);
                }
            }];
            
        }
            break;
        default:
            break;
    }

    return manager;


}

+ (AFHTTPSessionManager *)postMP3:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(FinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:fileData name: fileName:[NSString stringWithFormat:@"uploadfile%d",i] mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:fileData name:@"recoder" fileName:@"recoder.mp3" mimeType:@"mp3"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (finishBlock != nil) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finishBlock(result);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (errorBlock != nil) {
            
            errorBlock(error);
        }

    }];
    
    return manager;

    
    
}

+ (AFHTTPSessionManager *)postMP4:(NSString *)url
                           params:(NSDictionary *)params
                         fileData:(NSData *)fileData
                      finishBlock:(FinishBlock)finishBlock
                       errorBlock:(ErrorBlock)errorBlock
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //        [formData appendPartWithFileData:fileData name: fileName:[NSString stringWithFormat:@"uploadfile%d",i] mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:fileData name:@"filename" fileName:@"recoder.mp4" mimeType:@"mp4"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (finishBlock != nil) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finishBlock(result);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (errorBlock != nil) {
            
            errorBlock(error);
        }
        
    }];
    
    return manager;
    
    
    
}




+ (AFHTTPSessionManager *)postImage:(NSString *)url
                             params:(NSDictionary *)params
                           fileData:(NSData *)fileData
                        finishBlock:(FinishBlock)finishBlock
                         errorBlock:(ErrorBlock)errorBlock
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    [formData appendPartWithFileData:fileData name:@"filename" fileName:@"my.png" mimeType:@"image/jpeg"];
//        [formData appendPartWithFileData:fileData name:@"recoder" fileName:@"recoder.mp3" mimeType:@"mp3"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (finishBlock != nil) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            finishBlock(result);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if (errorBlock != nil) {
            
            errorBlock(error);
        }
        
    }];
    
    return manager;
    



}



+ (AFHTTPSessionManager *)syncrequestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                                httpMethod:(NSString *)httpMethod
                               finishBlock:(FinishBlock)finishBlock
                                errorBlock:(ErrorBlock)errorBlock
{
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    RequestType1 type;
    if ([httpMethod isEqualToString:@"GET"])
    {
        type = RequestGetType1;
    }else{
        type = RequestPostType1;
        
    }
    switch (type) {
        case RequestGetType1:
        {
            
            [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
                
            }];
            
            
        }
            break;
        case RequestPostType1:
        {
            
            [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (finishBlock != nil) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    finishBlock(result);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if (errorBlock != nil) {
                    
                    errorBlock(error);
                }
            }];
            
        }
            break;
        default:
            break;
    }
    

    return manager;
    
    
}


+ (NSURLSessionUploadTask *)updateURL:(NSString *)urlstring
                               params:(NSDictionary *)params   //文本参数
                            imageArry:(NSArray *)imageArry    //图片参数: {@"key":NSData}
                          finishBlock:(FinishBlock)finishBlock
                           errorBlock:(ErrorBlock)errorBlock {
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //应该使用NSURLSessionUploadTask,此处使用的NSURLSessionDataTask为父类
    NSURLSessionDataTask *uploadTask = [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //在此block中添加上传的图片数据
        for(int i=0;i<imageArry.count;i++){
            if ([imageArry[i] isKindOfClass:[UIImage class]]) {
                UIImage  * img=imageArry[i];
                
                NSData  * feedbackImg =UIImageJPEGRepresentation(img, 0.01);
                [formData appendPartWithFileData:feedbackImg name:[NSString stringWithFormat:@"%d_feedbackPhoto",i] fileName:[NSString stringWithFormat:@"%d_feedbackPhoto.jpg",i] mimeType:@"image/jpeg"];
                
            }else if([imageArry[i] isKindOfClass:[NSData class]]){
                
//                [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                    [formData appendPartWithFileData:fileData name:@"filename" fileName:@"my.png" mimeType:@"image/jpeg"];

                
                NSData *videoData = [imageArry objectAtIndex:i];
                [formData appendPartWithFileData:videoData name:@"filename" fileName:@"video1.mp4" mimeType:@"mp4"];
            }
        }
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        finishBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        errorBlock(error);
        
    }];
    
    //上传进度的监听
    //将_progressView 与 任务关联起来， _progressView 显示此任务的进度
//    [pross setProgressWithUploadProgressOfTask:(NSURLSessionUploadTask *)uploadTask animated:YES];
    
    return (NSURLSessionUploadTask*)uploadTask;
    
}




@end
