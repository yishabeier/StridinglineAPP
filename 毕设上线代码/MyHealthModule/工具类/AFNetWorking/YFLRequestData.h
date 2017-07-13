//
//  YFLRequestData.h
//  AFN
//
//  Created by cherish on 15/8/31.
//  Copyright (c) 2015年 杨飞龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperationManager;
@interface YFLRequestData : NSObject{
   
}

@property(strong,nonatomic)__block NSString *statusStr;
/**
 *  数据请求
 *
 *  @param urlstring URL
 *  @param method    get or Post
 *  @param parmas    请求参数
 *  @param files     请求文件(图片)
 *  @param success   请求成功的block
 *  @param fail      请求失败的block
 */


+ (void)requestURL:(NSString *)requestURL
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail;
- (void)monitor;
+(void)cancleNetOperation;
@end
