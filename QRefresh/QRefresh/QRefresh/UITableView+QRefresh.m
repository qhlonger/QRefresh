//
//  UITableView+QRefresh.m
//  QRefresh
//
//  Created by lijingjing on 16/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import "UITableView+QRefresh.h"

#import <objc/runtime.h>

@implementation UITableView (QRefresh)

static NSString *UITableViewQRefreshKey = @"UITableViewQRefreshKey";

- (void)setQRefreshView:(QRefreshView *)qRefreshView{
    [self addSubview:qRefreshView];
    qRefreshView.tableView = self;
    objc_setAssociatedObject(self, &UITableViewQRefreshKey, qRefreshView, OBJC_ASSOCIATION_ASSIGN);
}
- (QRefreshView *)qRefreshView{
    return objc_getAssociatedObject(self, &UITableViewQRefreshKey);
}









@end
