//
//  UIWebViewController.m
//  ICWebViewInesert
//
//  Created by 小木 on 05/03/2018.
//  Copyright © 2018 小木. All rights reserved.
//

#import "ICDetailViewController.h"
#import "UIView+CJXView.h"
#import "ICWebView.h"

static void  *kWebSizeChangeKey     = &kWebSizeChangeKey;
static void  *kTableChangeKey       = &kTableChangeKey;

@interface ICDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView     *_listView;
    ICWebView       *_webView;
    
    CGFloat          _webHeight;            //webview内容高度
    CGFloat          _webViewToTopHeight;   //webview上面section内容高度
    BOOL             _isNeedSimuTouch;      //是否打开多重手势
}
@end

@implementation ICDetailViewController

#pragma mark - LifeCycle
- (void)dealloc{
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [_listView           removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
    [self addWebViewObserve];
}


- (void)creatUI {
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    _webHeight = screenHeight;      //webview默认一屏高度
    _webViewToTopHeight = 50;       //第一个section总高度
    
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight, screenWidth, screenHeight - statusBarHeight)];
    [_listView setDelegate:self];
    [_listView setDataSource:self];
    [_listView setScrollEnabled:YES];
    [_listView setBackgroundColor:[UIColor whiteColor]];
    [_listView setEstimatedRowHeight:0];
    [_listView setEstimatedSectionFooterHeight:0];
    [_listView setEstimatedSectionHeaderHeight:0];
    [_listView setClipsToBounds:YES];
    [self.view addSubview:_listView];
    
//    NSString *urlStr = @"https://mp.weixin.qq.com/s?__biz=MjM5MzM0MDQzNw%3D%3D&mid=2652181859&idx=2&sn=6acc48aeb4774acfecff2c33442d41e4#wechat_redirect/";
    NSString *urlStr = @"https://app.myzaker.com/news/article.php?pk=5a9d632ad1f149b16400000f";
    _webView = [[ICWebView alloc] initWithFrame:CGRectMake(0, _webViewToTopHeight, screenWidth, screenHeight)];
    [_webView.scrollView setScrollEnabled:YES];
    [_webView.scrollView setDecelerationRate:UIScrollViewDecelerationRateNormal];
    [_webView.scrollView setShowsVerticalScrollIndicator:NO];
    [_webView.scrollView setBounces:NO];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [_listView addSubview:_webView];    
}

- (void)addWebViewObserve {
    [_listView           addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:kTableChangeKey];
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:kWebSizeChangeKey];
}


#pragma mark - KVO Method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIScrollView *scrollView = object;
    
    if (context == kTableChangeKey ) {
        CGFloat contentHeight = _listView.frame.size.height;
        if (scrollView.contentOffset.y >= _webHeight - contentHeight) {     //tableview offsetY 高于webViewConentHeight （在section2内滑动）
            
            _webView.scrollView.scrollEnabled = NO;
            _webView.isTouched = NO;
            [_webView setY:MAX(_webHeight - contentHeight, _webViewToTopHeight)];
            if (_webView.scrollView.contentOffset.y != _webView.scrollView.contentSize.height - _webView.frame.size.height) {
                [_webView.scrollView setContentOffset:CGPointMake(0, _webView.scrollView.contentSize.height - _webView.frame.size.height) animated:NO];
            }
        } else if (scrollView.contentOffset.y  < _webViewToTopHeight){      //tableview offsetY 在 section 0 和 webview之间
            _webView.isTouched = NO;
            if (_webView.y != _webViewToTopHeight) {
                [_webView setY:_webViewToTopHeight];
            }
            if (_webView.scrollView.contentOffset.y != 0) {
                [_webView.scrollView setContentOffset:CGPointMake(0, 0)];
            }
        } else {
            _webView.scrollView.scrollEnabled = _isNeedSimuTouch; //是否需要webview接受滑动手势
            [_webView setY:scrollView.contentOffset.y];
            if (!_webView.isTouched || !_isNeedSimuTouch) {     //如果没有触摸，将tableview惯性滚动offset赋给webview
                [_webView.scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y - _webViewToTopHeight)];
            }
        }
    } else if (context == kWebSizeChangeKey) {
        if (_webHeight != scrollView.contentSize.height) {
            _webHeight = scrollView.contentSize.height;
            [_listView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        if (_listView.contentOffset.y >= _webHeight  - 50) {
            [_webView.scrollView setContentOffset:CGPointMake(0, _webView.scrollView.contentSize.height - _webView.frame.size.height)];
        }
    }
}


#pragma mark - Method
- (void)shouldRecognizeSimultaneously:(BOOL)isNeed {
    _isNeedSimuTouch = isNeed;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 50;
            break;
        default:
            break;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 50;
        case 1:
            return _webHeight;
            break;
        case 2:
            return 50;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [cell setClipsToBounds:YES];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"section:%zd 第%zd行",indexPath.section,indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (_webView) {
        [_webView stopLoading];
    }
}

@end
