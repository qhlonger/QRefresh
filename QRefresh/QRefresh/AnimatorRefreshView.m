
//
//  AnimatorRefreshView.m
//  QRefresh
//
//  Created by lijingjing on 16/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import "AnimatorRefreshView.h"
#import <Lottie/Lottie.h>


@interface AnimatorRefreshView ()
@property(nonatomic, strong) LOTAnimationView *heartView;
@end
@implementation AnimatorRefreshView


- (LOTAnimationView *)heartView{
    if (!_heartView) {
        _heartView = [LOTAnimationView animationNamed:@"TwitterHeart"];
        _heartView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_heartView];
    }
    return _heartView;
}
- (void)layoutSubviews{
    _heartView.frame = CGRectMake(0, 0, 300, 300);
    _heartView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
}
- (void)qRefreshView:(QRefreshView *)refreshView didUpdateStatus:(QRefreshViewStatus)status percent:(CGFloat)percent{
    switch (self.status) {
        case QRefreshViewStatusNormal:{
            self.heartView.animationProgress = percent;
        }break;
        case QRefreshViewStatusRefreshing:{
            self.heartView.loopAnimation = YES;
            
        }break;
        case QRefreshViewStatusEndRefresh:{
            self.heartView.loopAnimation = NO;
            
        }break;
        case QRefreshViewStatusNeedRefresh:{
            
            self.heartView.loopAnimation = YES;
            [self.heartView play];
        }break;
        default:
            break;
    }

}
@end
