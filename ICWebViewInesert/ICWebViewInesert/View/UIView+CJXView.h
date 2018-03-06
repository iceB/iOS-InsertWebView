//
//  UIView+CJXView.h
//
//

#import <UIKit/UIKit.h>

@interface UIView (CJXView)
/**
 *  快速在bounds内部设置x坐标
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  快速在bounds内部设置y坐标
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  快速设置width
 */
@property (nonatomic, assign) CGFloat w;
/**
 *  快速设置height
 */
@property (nonatomic, assign) CGFloat h;

@property (nonatomic, strong) NSNumber *fixedWith;
@property (nonatomic, strong) NSNumber *fixedHeight;

@end


