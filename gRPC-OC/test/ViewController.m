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
#import "ServerManager.h"

static NSString *host_port = @"0.0.0.0:5000";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)strBtnClick:(id)sender {
    
    NSString *msg = self.textField.text;
    if (msg.length == 0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [[ServerManager shared] requestText:msg complete:^(NSObject * result, NSError * error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSString *res = (NSString *)result;
        NSLog(@"result: %@", res);
        weakSelf.messageLabel.text = res;
    }];
    
}

- (IBAction)dataBtnClick:(id)sender {
    NSString *msg = self.textField.text;
    if (msg.length == 0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [[ServerManager shared] requestData:data complete:^(NSObject * result, NSError * error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSString *res = (NSString *)result;
        NSLog(@"result: %@", res);
        weakSelf.messageLabel.text = res;
    }];
}

- (IBAction)imageBtnClick:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"1"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    __weak typeof(self) weakSelf = self;
    [[ServerManager shared] uploadImage:data name:@"1.png" type:@"PNG" complete:^(NSData * data, NSString * msg, NSError * error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSLog(@"msg: %@", msg);
        weakSelf.messageLabel.text = msg;
        UIImage *image = [UIImage imageWithData:data];
        weakSelf.imageView.image = image;
    }];
}

@end
