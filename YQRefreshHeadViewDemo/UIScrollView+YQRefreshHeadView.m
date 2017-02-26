//
//  UIScrollView+YQRefreshHeadView.m
//  AnimationDemo
//
//  Created by 俞琦 on 2017/2/18.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import "UIScrollView+YQRefreshHeadView.h"

@implementation UIScrollView (YQRefreshHeadView)
- (YQRefreshHeadView *)attachRefreshHeadViewWithTarget:(id)target action:(SEL)action
{
    YQRefreshHeadView *headView = [[YQRefreshHeadView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 50)/2, -50, 50, 50)];
    headView.target = target;
    headView.action = action;
    headView.scrollView = self;
    [headView addObserver];
    [self addSubview:headView];
    return headView;
}


@end
