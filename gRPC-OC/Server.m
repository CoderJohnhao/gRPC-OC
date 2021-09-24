//
//  Server.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/9/16.
//

#import "Server.h"
#import <GRPCClient/GRPCCall.h>

@interface Server()

@property (nonatomic, strong) GRPCCallOptions *callOptions;

@end

@implementation Server

+ (instancetype)shared {
    static Server *_server = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _server = [[Server alloc] init];
    });
    return _server;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)request:(NSString *)param complete: (void(^)(NSObject*, NSError *))complete {
    
}

@end
