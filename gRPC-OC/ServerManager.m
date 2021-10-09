//
//  Server.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/9/16.
//

#import "ServerManager.h"


static NSString *host_port = @"0.0.0.0:5000";

@interface ServerManager()

@property (nonatomic, strong) GRPCCallOptions *callOptions;

@property (nonatomic, strong) HelloServer * server;
@end

@implementation ServerManager

+ (instancetype)shared {
    static ServerManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ServerManager alloc] init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [GRPCProtoCall useInsecureConnectionsForHost:host_port];
        self.server = [[HelloServer alloc] initWithHost: host_port];
    }
    return self;
}


/// 传字符串
/// @param param 字符串参数
/// @param complete 请求结果回调
- (void)requestText:(NSString *)param complete:(void(^)(NSObject*, NSError *))complete {
    HelloRequest *reqeust = [HelloRequest message];
    reqeust.name = param;
    [self.server helloWithRequest:reqeust handler:^(HelloResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            NSLog(@"response: %@", response.result);
            complete(response.result, nil);
        } else {
            NSLog(@"error: %@", error.localizedDescription);
            complete(nil, error);
        }
    }];
}

/// 传字二进制Data
/// @param data Data参数
/// @param complete 请求结果回调
- (void)requestData:(NSData *)data complete:(void(^)(NSObject*, NSError *))complete {
    TestRequest *request = [TestRequest message];
    request.param = data;
    [self.server testWithRequest:request handler:^(HelloResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            NSLog(@"response: %@", response.result);
            complete(response.result, nil);
        } else {
            NSLog(@"error: %@", error.localizedDescription);
            complete(nil, error);
        }
    }];
}

- (void)uploadImage:(NSData *)img name:(NSString *)name type:(NSString *)type complete:(void(^)(NSData*, NSString *msg, NSError *))complete {
    UploadRequest *request = [UploadRequest message];
    request.name = name;
    request.type = type;
    request.data_p = img;
    [self.server uploadWithRequest:request handler:^(UploadResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            NSLog(@"response: %@", response.name);
            complete(response.data, response.name, nil);
        } else {
            NSLog(@"error: %@", error.localizedDescription);
            complete(nil, name, error);
        }
    }];
}

@end
