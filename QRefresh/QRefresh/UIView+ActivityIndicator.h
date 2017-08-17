//
//  UIView+ActivityIndicator.h
//  QRefresh
//
//  Created by lijingjing on 17/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ActivityIndicator)

@property(nonatomic, strong) UIActivityIndicatorView *actIndicator;

- (void)startLoading;
- (void)stopLoading;
@end
