//
//  YQRefreshHeadView.m
//  AnimationDemo
//
//  Created by 俞琦 on 2017/2/17.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#define refreshHeadViewH 60

#import "YQRefreshHeadView.h"

@interface YQRefreshHeadView ()
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
@property (nonatomic, strong) CAShapeLayer *topLayer;
@end

@implementation YQRefreshHeadView

- (CAShapeLayer *)bottomLayer
{
    if (_bottomLayer == nil) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _bottomLayer.lineCap = kCALineCapRound;
        _bottomLayer.lineJoin = kCALineJoinRound;
        _bottomLayer.lineWidth = 2;
        _bottomLayer.frame = CGRectMake(self.bounds.size.height*0.2, self.bounds.size.height*0.2, self.bounds.size.height*0.6, self.bounds.size.height*0.6);
        _bottomLayer.path = [UIBezierPath bezierPathWithOvalInRect:_bottomLayer.bounds].CGPath;
    }
    return _bottomLayer;
}

- (CAShapeLayer *)topLayer
{
    if (!_topLayer) {
        _topLayer = [CAShapeLayer layer];
        _topLayer.fillColor = [UIColor clearColor].CGColor;
        _topLayer.strokeColor = [UIColor colorWithRed:0.0431 green:0.7569 blue:0.9412 alpha:1.0].CGColor;
        _topLayer.lineCap = kCALineCapRound;
        _topLayer.lineJoin = kCALineJoinRound;
        _topLayer.lineWidth = 2;
        _topLayer.frame = self.bottomLayer.frame;
        _topLayer.path = [UIBezierPath bezierPathWithOvalInRect:_topLayer.bounds].CGPath;
        [_topLayer setValue:@(-M_PI_2) forKeyPath:@"transform.rotation.z"];
        _topLayer.strokeEnd = 0;
    }
    return _topLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initViews];
        
    }
    return self;
}

- (void)initViews
{
    [self.layer addSublayer:self.bottomLayer];
    [self.layer addSublayer:self.topLayer];
}

- (void)addObserver
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UIScrollView *scrollView = object;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > -30) {
        return;
    }
    // 向下拖拽时计算圆弧的结束值
    CGFloat dragProgress = MIN(fabs(offsetY+30)/50, 1);
    NSLog(@"%f", dragProgress);
    CGFloat strokeEnd = dragProgress;
    self.topLayer.strokeEnd = strokeEnd;
    
    // 满足刷新条件
    if (!scrollView.isDragging && fabs(offsetY+30)/50>1) {
        [scrollView setContentOffset:CGPointMake(0, -80) animated:NO];
        [self startAnimation];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.action];
#pragma clang diagnostic pop
    }
}

- (void)startAnimation
{
    self.topLayer.strokeEnd = 0.2;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2 *0.72);
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = HUGE;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.topLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)endAnimation
{
    [self.topLayer removeAllAnimations];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
@end
