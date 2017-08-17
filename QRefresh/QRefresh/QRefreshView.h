//
//  QRefreshView.h
//  QRefresh
//
//  Created by lijingjing on 16/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRefreshView;


/**
 刷新状态

 - QRefreshViewStatusNormal: 普通
 - QRefreshViewStatusNeedRefresh: 需要刷新(已经刷新)
 - QRefreshViewStatusRefreshing: 正在刷新
 - QRefreshViewStatusEndRefresh: 结束刷新
 */
typedef NS_ENUM(NSInteger, QRefreshViewStatus) {
    QRefreshViewStatusNormal,
    QRefreshViewStatusNeedRefresh,
    QRefreshViewStatusRefreshing,
    QRefreshViewStatusEndRefresh
};




@interface QRefreshView : UIView

/**
 需要监听的 tableview
 */
@property(nonatomic, weak) UITableView *tableView;
/**
 状态
 */
@property(nonatomic, assign) QRefreshViewStatus status;
/**
 刷新回调
 */
@property(nonatomic, copy) void(^refreshAction) (void);



/**
 初始化

 @param action 刷新回调
 @return 实例
 */
- (instancetype)initWithRefreshAction:(void(^)(void))action;

/**
 开始刷新
 */
- (void)beiginRefreshing;

/**
 结束刷新
 */
- (void)endRefreshing;

/**
 子类实现这个方法用以自定义

 @param refreshView 自己
 @param status 状态
 @param percent 百分比
 */
- (void)qRefreshView:(QRefreshView *)refreshView didUpdateStatus:(QRefreshViewStatus)status percent:(CGFloat)percent;
@end
