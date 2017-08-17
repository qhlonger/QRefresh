
//
//  QCircleProgressView.m
//  QRefresh
//
//  Created by lijingjing on 16/08/2017.
//  Copyright © 2017 LeoQ. All rights reserved.
//

#import "QCircleProgressView.h"


@interface QCircleProgressView ()

@end
@implementation QCircleProgressView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progress = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.progress = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor lightGrayColor]set];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    //线宽
    CGContextSetLineWidth(ctx, 3);
    //圆心位置
    CGPoint centerPoint = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    //半径
    CGFloat radius = CGRectGetWidth(rect)/4;
    //圆的起始位置
    CGFloat startA = - M_PI_2;
    //圆的终止位置
    CGFloat endA = - M_PI_2 + M_PI * 2 * _progress;
    //构建圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                        radius:radius
                                                    startAngle:startA
                                                      endAngle:endA
                                                     clockwise:YES];

    //将路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);

    CGContextStrokePath(ctx);
}


@end
