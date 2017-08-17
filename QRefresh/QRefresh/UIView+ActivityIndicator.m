//
//  UIView+ActivityIndicator.m
//  QRefresh
//
//  Created by lijingjing on 17/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import "UIView+ActivityIndicator.h"

#import <objc/runtime.h>
@implementation UIView (ActivityIndicator)


static NSString *UIViewActivityIndicatorKey = @"UIViewActivityIndicatorKey";
- (void)setActIndicator:(UIActivityIndicatorView *)actIndicator{
    [self addSubview:actIndicator];
    objc_setAssociatedObject(self, &UIViewActivityIndicatorKey, actIndicator, OBJC_ASSOCIATION_RETAIN);
}
- (UIActivityIndicatorView *)actIndicator{
    UIActivityIndicatorView *actView = objc_getAssociatedObject(self, &UIViewActivityIndicatorKey);
    if(actView)return actView;
    
    
    actView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    actView.hidesWhenStopped = YES;
    [self addSubview:actView];
    objc_setAssociatedObject(self, &UIViewActivityIndicatorKey, actView, OBJC_ASSOCIATION_RETAIN);
    return actView;
    
}



- (void)startLoading{
    [self bringSubviewToFront:self.actIndicator];
    self.actIndicator.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    [self.actIndicator startAnimating];
    NSLog(@"%@",self.actIndicator);
}
- (void)stopLoading{
    [self.actIndicator stopAnimating];
}

@end
