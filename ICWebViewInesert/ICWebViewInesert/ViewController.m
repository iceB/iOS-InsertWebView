//
//  ViewController.m
//  ICWebViewInesert
//
//  Created by 小木 on 04/03/2018.
//  Copyright © 2018 小木. All rights reserved.
//

#import "ViewController.h"
#import "ICDetailViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_listView;
}
@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)dealloc{
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatUI];
}



- (void)creatUI{
        
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight, screenWidth, screenHeight - statusBarHeight)];
    [_listView setDelegate:self];
    [_listView setDataSource:self];
    [_listView setDelegate:self];
    [_listView setScrollEnabled:YES];
    [_listView setDecelerationRate:UIScrollViewDecelerationRateNormal];
    [_listView setBackgroundColor:[UIColor whiteColor]];
    [_listView setEstimatedRowHeight:0];
    [_listView setEstimatedSectionFooterHeight:0];
    [_listView setEstimatedSectionHeaderHeight:0];
    [_listView setClipsToBounds:YES];
    [self.view addSubview:_listView];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [cell setClipsToBounds:YES];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    cell.textLabel.text = indexPath.row == 0 ? @"手势滑动webView" : @"非拖动webView滑动";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ICDetailViewController *detailVC = [[ICDetailViewController alloc] init];
    [detailVC shouldRecognizeSimultaneously:indexPath.row == 0];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
