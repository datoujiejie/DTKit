//
//  UIScrollView+YYAdd.m
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 13/4/5.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "UIScrollView+DTKit.h"
#import "DTKitMacro.h"

SYNTH_DUMMY_CLASS(UIScrollView_DTKit)


@implementation UIScrollView (DTKit)

- (void)dt_scrollToTop {
    [self dt_scrollToTopAnimated:YES];
}

- (void)dt_scrollToBottom {
    [self dt_scrollToBottomAnimated:YES];
}

- (void)dt_scrollToLeft {
    [self dt_scrollToLeftAnimated:YES];
}

- (void)dt_scrollToRight {
    [self dt_scrollToRightAnimated:YES];
}

- (void)dt_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)dt_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)dt_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)dt_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
