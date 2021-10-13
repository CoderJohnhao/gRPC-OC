//
//  HomeVC.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/10/9.
//

#import "HomeVC.h"
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "SimpleVC.h"
#import "ServiceVC.h"
#import "ClientVC.h"
#import "BidirectionalSteamVC.h"

@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation HomeVC

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = @[@"简单的demo", @"单一通信", @"服务端流", @"客服端流", @"双向流"];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"gRPC-OC";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


// MARK: - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            SimpleVC *simple = [[SimpleVC alloc] init];
            [self.navigationController pushViewController:simple animated:YES];
        }
            break;
        case 2:
        {
            ServiceVC *service = [[ServiceVC alloc] init];
            [self.navigationController pushViewController:service animated:YES];
        }
            break;
        case 3:
        {
            ClientVC *client = [[ClientVC alloc] init];
            [self.navigationController pushViewController:client animated:YES];
        }
            break;
        case 4:
        {
            BidirectionalSteamVC *vc = [[BidirectionalSteamVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
}

@end
