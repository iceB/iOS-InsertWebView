//
//  UIWebViewController.h
//  ICWebViewInesert
//
//  Created by 小木 on 05/03/2018.
//  Copyright © 2018 小木. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICDetailViewController : UIViewController

/**
 手势穿透开关

 @param isNeed 是否打开
 */
- (void)shouldRecognizeSimultaneously:(BOOL)isNeed;
@end
