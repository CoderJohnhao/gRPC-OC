//
//  ClientVC.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/10/12.
//

#import "ClientVC.h"
#import <Feature.pbobjc.h>
#import <Feature.pbrpc.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall.h>
#import <GRPCClient/GRPCTransport.h>

@interface ClientVC ()
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation ClientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)sendmsg:(id)sender {
    
    Point_Class *point1 = [[Point_Class alloc] init];
    point1.latitude = 407838351;
    point1.longitude = -746143763;
    
    Point_Class *point2 = [[Point_Class alloc] init];
    point2.latitude = 408122808;
    point2.longitude = -743999179;
    
    Point_Class *point3 = [[Point_Class alloc] init];
    point3.latitude = 413628156;
    point3.longitude = -749015468;
    
    Point_Class *point4 = [[Point_Class alloc] init];
    point4.latitude = 419999544;
    point4.longitude = -740371136;
    
    GRPCMutableCallOptions *callOptions = [[GRPCMutableCallOptions alloc] init];
    // 该调用要使用的传输。用户z可以选择GRPCTransport中定义的本地传输标识符或由非本地的ttransport实现提供。如果该选项被设置为NULL，gRPC将使用其默认的传输。
    callOptions.transport = GRPCDefaultTransportImplList.core_insecure;
    
    RouteGuide *server = [[RouteGuide alloc] initWithHost:@"localhost:50051" callOptions:callOptions];
    __weak typeof(self) weak_self = self;
    GRPCUnaryResponseHandler *handler = [[GRPCUnaryResponseHandler alloc] initWithResponseHandler:^(RouteSummary * response, NSError * error) {
        if (error) {
            NSLog(@"error:%@", error.localizedDescription);
        } else {
            weak_self.msgLabel.text = [NSString stringWithFormat:@"count: %d, feature: %d, distance:%d, time:%d", response.pointCount, response.featureCount, response.distance, response.elapsedTime];
        }
    } responseDispatchQueue:nil];
    GRPCStreamingProtoCall *call = [server recordRouteWithResponseHandler:handler callOptions:nil];
    [call start];
    [call writeMessage:point1];
    [call writeMessage:point2];
    [call writeMessage:point3];
    [call writeMessage:point4];
    [call finish];
}


@end
