//
//  Server.h
//  gRPC-OC
//
//  Created by Johnhao on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import <GRPCClient/GRPCCall.h>
#import <Helloworld.pbrpc.h>
#import <Helloworld.pbobjc.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerManager : NSObject

+ (instancetype)shared;
/// 传字符串
/// @param param 字符串参数
/// @param complete 请求结果回调
- (void)requestText:(NSString *)param complete:(void(^)(NSObject*, NSError *))complete;
/// 传字二进制Data
/// @param data Data参数
/// @param complete 请求结果回调
- (void)requestData:(NSData *)data complete:(void(^)(NSObject*, NSError *))complete;
- (void)uploadImage:(NSData *)img name:(NSString *)name type:(NSString *)type complete:(void(^)(NSData*, NSString *msg, NSError *))complete;
@end

NS_ASSUME_NONNULL_END
