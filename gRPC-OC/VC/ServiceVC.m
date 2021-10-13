//
//  ServiceVC.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/10/13.
//

#import "ServiceVC.h"
#import <Feature.pbobjc.h>
#import <Feature.pbrpc.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall.h>
#import <GRPCClient/GRPCTransport.h>

@interface ServiceVC ()<GRPCProtoResponseHandler>
@property (weak, nonatomic) IBOutlet UITextView *messageLabel;
@property (nonatomic, strong) NSMutableArray<Feature*> *dataArr;
@end

@implementation ServiceVC

@synthesize dispatchQueue;

- (NSMutableArray<Feature *> *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)sendMsg:(id)sender {
    GRPCMutableCallOptions *callOptions = [[GRPCMutableCallOptions alloc] init];
    // 该调用要使用的传输。用户z可以选择GRPCTransport中定义的本地传输标识符或由非本地的ttransport实现提供。如果该选项被设置为NULL，gRPC将使用其默认的传输。
    callOptions.transport = GRPCDefaultTransportImplList.core_insecure;
    
    RouteGuide *server = [[RouteGuide alloc] initWithHost:@"localhost:50051" callOptions:callOptions];
    Rectangle *rectangle = [[Rectangle alloc] init];
    Point_Class *point1 = [[Point_Class alloc] init];
    point1.latitude = 400000000;
    point1.longitude = -750000000;
    Point_Class *point2 = [[Point_Class alloc] init];
    point2.latitude = 420000000;
    point2.longitude = -730000000;
    rectangle.lo = point1;
    rectangle.hi = point2;
    [[server listFeaturesWithMessage:rectangle responseHandler:self callOptions:nil] start];
}

- (void)didReceiveProtoMessage:(GPBMessage *)message {
    if (message) {
        Feature *feature = (Feature*)message;
        NSLog(@"response: %@", feature.name);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.messageLabel.text = [self.messageLabel.text stringByAppendingFormat:@"%@\n", feature.name];
        });
    }
}

- (void)didCloseWithTrailingMetadata:(NSDictionary *)trailingMetadata error:(NSError *)error {
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

- (void)didWriteMessage {
    NSLog(@"didWriteMessage");
}


@end
