//
//  UIScrollView+YQRefreshHeadView.h
//  AnimationDemo
//
//  Created by 俞琦 on 2017/2/18.
//  Copyright © 2017年 俞琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQRefreshHeadView.h"

@interface UIScrollView (YQRefreshHeadView)
- (YQRefreshHeadView *)attachRefreshHeadViewWithTarget:(id)target action:(SEL)action;
@end
