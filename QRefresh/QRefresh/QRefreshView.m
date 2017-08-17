//
//  QRefreshView.m
//  QRefresh
//
//  Created by lijingjing on 16/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//
#define Trigger_H 64
#import "QRefreshView.h"
#import "QCircleProgressView.h"

@interface QRefreshView ()

@property(nonatomic, weak) QCircleProgressView *progressView;
@property(nonatomic, weak) UIActivityIndicatorView *actView;

@end
@implementation QRefreshView


- (instancetype)initWithRefreshAction:(void(^)(void))action{
    self = [super init];
    if (self) {
        self.refreshAction = action;
        [self doInit];
    }
    return self;
}

- (void)doInit{
    self.status = QRefreshViewStatusNormal;
    
}
- (QCircleProgressView *)progressView{
    if (!_progressView) {
        QCircleProgressView *progressView = ({
            progressView = [[QCircleProgressView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            
            [self addSubview:progressView];
            progressView;
        });
        _progressView = progressView;
    }
    return _progressView;
}
- (UIActivityIndicatorView *)actView{
    if (!_actView) {
        UIActivityIndicatorView *actview = ({
            actview = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            
            actview.activityIndicatorViewStyle    = UIActivityIndicatorViewStyleGray;
            
            actview.hidesWhenStopped = YES;
            [self addSubview:actview];
            actview;
        });
        _actView = actview;
    }
    return _actView;
}

- (void)setTableView:(UITableView *)tableView{
    _tableView = tableView;
    
    self.frame = CGRectMake(0, -64, CGRectGetWidth(tableView.frame), 64);
    
    self.progressView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.actView.center = self.progressView.center;
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGFloat contentOffsetY = self.tableView.contentOffset.y;
    if(contentOffsetY > 40)return;
    
    
    switch (self.status) {
        case QRefreshViewStatusNormal:{
            if(self.tableView.isTracking){
                CGFloat percent = [QRefreshView getRatioWithMax:-Trigger_H min:0 mid:contentOffsetY];
                [self qRefreshView:self didUpdateStatus:self.status percent:percent];
            }
        }break;
        case QRefreshViewStatusRefreshing:{
            [self qRefreshView:self didUpdateStatus:self.status percent:1];
        }break;
        case QRefreshViewStatusEndRefresh:{
            [self qRefreshView:self didUpdateStatus:self.status percent:1];
        }break;
        case QRefreshViewStatusNeedRefresh:{
            [self qRefreshView:self didUpdateStatus:self.status percent:1];
        }break;
        default:
            break;
    }
    
    
    if (self.tableView.isTracking) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            if(contentOffsetY < 0){//当offsetY小于0
                if(self.tableView.isTracking){//如果tableview被拽着
                    if(contentOffsetY < -Trigger_H){//如果超过了触发高度
                        if (self.status == QRefreshViewStatusNormal) {//如果是待刷新状态 ? 进入刷新状态
                            self.status = QRefreshViewStatusNeedRefresh;
                        }
                    }
                }
            }
        }
    }else{
        
        switch (self.status) {
            case QRefreshViewStatusNormal:
                
                break;
            case QRefreshViewStatusNeedRefresh:
                self.status = QRefreshViewStatusRefreshing;
                [self refreshSetting];
                
                break;
            case QRefreshViewStatusRefreshing:
                break;
            case QRefreshViewStatusEndRefresh:
                self.status = QRefreshViewStatusNormal;
                [self normalSetting];
                break;
            default:
                break;
        }
    }
}

/**
 根据最大 最小 中间值 获取百分百

 @param max 最大
 @param min 最小
 @param mid 中间值
 @return 比例
 */
+ (CGFloat)getRatioWithMax:(CGFloat)max min:(CGFloat)min mid:(CGFloat)mid{
    return (mid - min) / (max - min);
}
- (void)qRefreshView:(QRefreshView *)refreshView didUpdateStatus:(QRefreshViewStatus)status percent:(CGFloat)percent{
    NSLog(@"%f",percent);
    
    switch (self.status) {
        case QRefreshViewStatusNormal:{
            self.progressView.hidden = NO;
            self.actView.alpha = 0.f;
            self.progressView.alpha = 1.f;
            if(percent<=0){
                self.progressView.progress = 0;
            }else if(percent>=1){
                self.progressView.progress = 1;
            }else{
                self.progressView.progress = percent;
            }
        }break;
        case QRefreshViewStatusRefreshing:{
            [UIView animateWithDuration:0.25 animations:^{
                self.progressView.alpha = 0.f;
                self.actView.alpha = 1.f;
            } completion:^(BOOL finished) {
                self.progressView.hidden = YES;
                self.actView.hidden = NO;
            }];
        }break;
        case QRefreshViewStatusEndRefresh:{
            [UIView animateWithDuration:0.25 animations:^{
                self.progressView.alpha = 0.f;
                self.actView.alpha = 0.f;
            } completion:^(BOOL finished) {
                [self.actView stopAnimating];
                self.progressView.hidden = YES;
                self.actView.hidden = NO;
            }];
            
        }break;
        case QRefreshViewStatusNeedRefresh:{
            if(!self.actView.isAnimating){
                [self.actView startAnimating];
                [UIView animateWithDuration:0.25 animations:^{
                    self.progressView.alpha = 0.f;
                    self.actView.alpha = 1.f;
                } completion:^(BOOL finished) {
                    self.progressView.hidden = YES;
                    self.actView.hidden = NO;
                }];
            }
        }break;
        default:
            break;
    }
    
    
}
- (void)setStatus:(QRefreshViewStatus)status{
    _status = status;
    
    switch (status) {
        case QRefreshViewStatusNormal:{
            
        }break;
        case QRefreshViewStatusNeedRefresh:{
            if(self.refreshAction)self.refreshAction();
        }break;
        case QRefreshViewStatusRefreshing:{
            
        }break;
        case QRefreshViewStatusEndRefresh:{
            
        }break;
        default:
            break;
    }
}


- (void)beiginRefreshing{
    if(self.status == QRefreshViewStatusRefreshing || self.status == QRefreshViewStatusNeedRefresh)return;
    self.status = QRefreshViewStatusNeedRefresh;
    [self refreshSetting];
}
- (void)refreshSetting{
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.tableView.contentOffset = CGPointMake(0,-64);
    }];
}
- (void)endRefreshing{
    if(self.status == QRefreshViewStatusEndRefresh || self.status == QRefreshViewStatusNormal)return;
    self.status = QRefreshViewStatusEndRefresh;
    if(!self.tableView.isTracking){
        [self normalSetting];
    }
}
- (void)normalSetting{
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}
@end
