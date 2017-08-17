//
//  UITableView+QRefresh.h
//  QRefresh
//
//  Created by lijingjing on 16/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRefreshView.h"
#import "AnimatorRefreshView.h"
@interface UITableView (QRefresh)

@property(nonatomic, strong) QRefreshView *qRefreshView;

@end
