//
//  ICWebView.m
//  ICWebViewInesert
//
//  Created by 小木 on 04/03/2018.
//  Copyright © 2018 小木. All rights reserved.
//

#import "ICWebView.h"

@implementation ICWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    _isTouched = YES;
    return [super pointInside:point withEvent:event];
}

@end
