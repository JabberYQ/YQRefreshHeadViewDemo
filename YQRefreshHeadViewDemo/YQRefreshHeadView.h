//
//  YQRefreshHeadView.h
//  AnimationDemo
//
//  Created by 俞琦 on 2017/2/17.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQRefreshHeadView : UIView
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, strong) UIScrollView *scrollView;
- (void)addObserver;
- (void)startAnimation;
- (void)endAnimation;
@end
