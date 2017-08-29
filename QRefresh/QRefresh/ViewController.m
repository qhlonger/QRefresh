//
//  ViewController.m
//  QRefresh
//
//  Created by lijingjing on 16/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+QRefresh.h"
#import "QRefreshView.h"
#import "AnimatorRefreshView.h"
#import "UIView+ActivityIndicator.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
//    CGFloat w = self.view.frame.size.width/6;
//    CGFloat h = self.view.frame.size.height/10;
//    for (int i = 0; i < 10; i++) {
//        for (int j = 0; j < 6; j ++) {
//            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeSystem];
//            btn.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
//            [self.view addSubview:btn];
//            btn.frame = CGRectMake(w*j, h*i, w, h);
//            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)btnClick:(UIButton *)btn{
    [btn startLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [btn stopLoading];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];;
//        tableView.layer.borderColor = [UIColor blackColor].CGColor;
//        tableView.layer.borderWidth = 2;
//        tableView.backgroundColor = [UIColor colorWithRed:230 green:230 blue:230 alpha:1];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.clipsToBounds = YES;
        
        tableView.qRefreshView = [[QRefreshView alloc] initWithRefreshAction:^{
            __weak __typeof(self)weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableView.qRefreshView endRefreshing];
                [weakSelf.tableView reloadData];
            });
        }];
        
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 123;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell startLoading];
    
    if (indexPath.row %2 == 1) {
        [self.tableView.qRefreshView beiginRefreshing];
    }else{
        [self.tableView.qRefreshView endRefreshing];
    }
}
@end
