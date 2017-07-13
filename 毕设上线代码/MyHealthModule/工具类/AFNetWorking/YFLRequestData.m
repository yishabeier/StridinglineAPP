//
//  YFLRequestData.m
//  AFN
//
//  Created by cherish on 15/8/31.
//  Copyright (c) 2015年 杨飞龙 . All rights reserved.
//

#import "YFLRequestData.h"
#import "AFNetworking.h"
@implementation YFLRequestData
static AFHTTPRequestOperationManager *manager;
+ (void)requestURL:(NSString *)requestURL
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail
{
    
    
    //1.构造操作对象管理者
    manager = [AFHTTPRequestOperationManager manager];
    
    //2.设置解析格式，默认json
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    //3.请求时间设置
    manager.requestSerializer.timeoutInterval=30;
    
    //4.如果报接受类型不一致请替换一致text/html  服务器返回的数据格式
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    
   
    // 4.get请求
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
//        [manager.requestSerializer setValue:@"e693e4fa1f16456f5cd3e0951a8b1caa" forHTTPHeaderField:@"apix-key"];
        [manager GET:requestURL
          parameters:parmas
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                  NSLog(@"%ld",operation.response.statusCode);
                 if (success != nil)
                 {
                     success(responseObject);
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                 NSLog(@"%ld",operation.response.statusCode);
                 if (fail != nil) {
                     fail(error);
                 }
             }];
       
        
        // 5.post请求不带文件 和post带文件
    }else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        
        if (files == nil) {
            
   
            [manager POST:requestURL
               parameters:parmas
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
   
                      
                      if (success) {
                          
                      }
                      
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      
                      if (fail) {
                          fail(error);
                      }
                      
                  }];
            
        } else {
            
            [manager POST:requestURL
               parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                   
                   
                   for (id key in files) {
                       
                       id value = files[key];
                       
                       
                       
                       [formData appendPartWithFileData:value
                                                   name:key
                                               fileName:@"header.png"
                                               mimeType:@"image/png"];
                   }
                   
               } success:^(AFHTTPRequestOperation *operation, id responseObject) {
   
                   if (success) {
                       success(responseObject);
                   }
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   if (fail) {
                       fail(error);
                   }
                   
               }];
        }
    }
}
- (void)monitor{
    //5.判断网络状况
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            
//            NSLog(@"没有网络");
            _statusStr=@"没有网络";
            
        }else if (status == AFNetworkReachabilityStatusUnknown){
            
//            NSLog(@"未知网络");
            _statusStr=@"未知网络";
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            
//            NSLog(@"WiFi");
            _statusStr=@"WiFi";
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            
//            NSLog(@"手机网络");
            _statusStr=@"手机网络";
        }
        
    }];
   
}
+(void)cancleNetOperation{
      
     [manager.operationQueue cancelAllOperations];
}
@end
