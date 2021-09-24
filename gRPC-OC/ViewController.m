//
//  ViewController.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/9/16.
//

#import "ViewController.h"
#import <Helloworld.pbrpc.h>
#import <Helloworld.pbobjc.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>

static NSString *host_port = @"0.0.0.0:5000";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GRPCCall useInsecureConnectionsForHost:host_port];
    HelloServer *server = [[HelloServer alloc] initWithHost:host_port];
    HelloRequest *reqeust = [HelloRequest message];
    reqeust.name = @"Johnhao";
    [server helloWithRequest:reqeust handler:^(HelloResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            NSLog(@"response: %@", response.result);
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}


@end
