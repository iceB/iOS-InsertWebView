//
//  ICWebView.h
//  ICWebViewInesert
//
//  Created by 小木 on 04/03/2018.
//  Copyright © 2018 小木. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICWebView : UIWebView<UIGestureRecognizerDelegate>
@property (nonatomic,assign) BOOL isTouched;

@end
