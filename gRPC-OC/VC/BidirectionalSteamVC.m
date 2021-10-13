//
//  BidirectionalSteamVC.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/10/13.
//

#import "BidirectionalSteamVC.h"
#import <Feature.pbobjc.h>
#import <Feature.pbrpc.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall.h>
#import <GRPCClient/GRPCTransport.h>

@interface BidirectionalSteamVC ()<GRPCProtoResponseHandler>
@property (weak, nonatomic) IBOutlet UITextView *msgLabel;

@end

@implementation BidirectionalSteamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)sendmsg:(id)sender {
    Point_Class *point1 = [[Point_Class alloc] init];
    point1.latitude = 407838351;
    point1.longitude = -746143763;
    RouteNote *note1= [[RouteNote alloc] init];
    note1.location = point1;
    note1.message = @"哈哈，这是第一条数据";
    
    Point_Class *point2 = [[Point_Class alloc] init];
    point2.latitude = 408122808;
    point2.longitude = -743999179;
    RouteNote *note2 = [[RouteNote alloc] init];
    note2.location = point2;
    note2.message = @"哈哈，这是第二条数据";
    
    Point_Class *point3 = [[Point_Class alloc] init];
    point3.latitude = 413628156;
    point3.longitude = -749015468;
    RouteNote *note3 = [[RouteNote alloc] init];
    note3.location = point3;
    note3.message = @"哈哈，这是第三条数据";
    
    Point_Class *point4 = [[Point_Class alloc] init];
    point4.latitude = 419999544;
    point4.longitude = -740371136;
    RouteNote *note4 = [[RouteNote alloc] init];
    note4.location = point4;
    note4.message = @"哈哈，这是第四条数据";
    
    GRPCMutableCallOptions *callOptions = [[GRPCMutableCallOptions alloc] init];
    // 该调用要使用的传输。用户z可以选择GRPCTransport中定义的本地传输标识符或由非本地的ttransport实现提供。如果该选项被设置为NULL，gRPC将使用其默认的传输。
    callOptions.transport = GRPCDefaultTransportImplList.core_insecure;
    
    RouteGuide *server = [[RouteGuide alloc] initWithHost:@"localhost:50051" callOptions:callOptions];
    GRPCStreamingProtoCall *call = [server routeChatWithResponseHandler:self callOptions:nil];
    [call start];
    [call writeMessage:note1];
    [call writeMessage:note2];
    [call writeMessage:note3];
    [call writeMessage:note4];
    [call finish];
}


- (void)didReceiveProtoMessage:(GPBMessage *)message {
    if (message) {
        RouteNote *note = (RouteNote*)message;
        NSLog(@"response: %@", note.message);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.msgLabel.text = [self.msgLabel.text stringByAppendingFormat:@"%@\n", note.message];
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

@synthesize dispatchQueue;

@end
