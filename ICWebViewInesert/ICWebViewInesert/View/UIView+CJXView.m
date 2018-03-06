//
//  UIView+CJXView.m
//

#import "UIView+CJXView.h"
#import <objc/runtime.h>

@implementation UIView (CJXView)

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)w{
    return self.frame.size.width;
}

- (void)setW:(CGFloat)w{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (CGFloat)h{
    return self.frame.size.height;
}

- (void)setH:(CGFloat)h{
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

- (NSNumber *)fixedWith{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFixedWith:(NSNumber *)fixedWith{
    objc_setAssociatedObject(self, @selector(fixedWith), fixedWith, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)fixedHeight{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFixedHeight:(NSNumber *)fixedHeight{
    objc_setAssociatedObject(self, @selector(fixedHeight), fixedHeight, OBJC_ASSOCIATION_RETAIN);
}

@end
