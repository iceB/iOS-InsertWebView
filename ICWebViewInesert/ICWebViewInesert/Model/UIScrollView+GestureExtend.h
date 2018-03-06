//
//  UIScrollView+GestureExtend.h
//
//  Created by 小木 on 2017/7/24.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (GestureExtend)
- (BOOL)myGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end

