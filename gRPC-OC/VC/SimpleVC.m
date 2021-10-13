//
//  SimpleVC.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/10/12.
//

#import "SimpleVC.h"
#import <Feature.pbobjc.h>
#import <Feature.pbrpc.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall.h>
#import <GRPCClient/GRPCTransport.h>

@interface SimpleVC ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation SimpleVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)sendMsg:(id)sender {
    // 使用不安全的连接
//    [GRPCProtoCall useInsecureConnectionsForHost:@"localhost:50051"];
    
    GRPCMutableCallOptions *callOptions = [[GRPCMutableCallOptions alloc] init];
    // 该调用要使用的传输。用户z可以选择GRPCTransport中定义的本地传输标识符或由非本地的ttransport实现提供。如果该选项被设置为NULL，gRPC将使用其默认的传输。
    callOptions.transport = GRPCDefaultTransportImplList.core_insecure;
    
    RouteGuide *server = [[RouteGuide alloc] initWithHost:@"localhost:50051" callOptions:callOptions];
    Point_Class *point = [[Point_Class alloc] init];
    point.latitude = 413628156;
    point.longitude = -749015468;
    __weak typeof(self) weak_self = self;
//    [server getFeatureWithRequest:point handler:^(Feature * _Nullable response, NSError * _Nullable error) {
//        weak_self.messageLabel.text = response.name;
//    }];
    
    GRPCUnaryResponseHandler *handler = [[GRPCUnaryResponseHandler alloc] initWithResponseHandler:^(Feature * response, NSError * error) {
        weak_self.messageLabel.text = response.name;
    } responseDispatchQueue:nil];
    [[server getFeatureWithMessage:point responseHandler:handler callOptions:nil] start];
}



@end
