//
//  UIScrollView+GestureExtend.m
//
//  Created by 小木 on 2017/7/24.
//

#import "UIScrollView+GestureExtend.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ICWebView.h"


@implementation UIScrollView (GestureExtend)

+ (void)load{
    if ([self instancesRespondToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)),class_getInstanceMethod(self, @selector(myGestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)));
        
    }
}

- (BOOL)myGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([self.superview isKindOfClass:[ICWebView class]]) {
        return YES;
    } else {
        return [self myGestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}


@end

