//
//  LTYWebViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/6.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYWebViewController.h"
#import <NJKWebViewProgress.h>

@interface LTYWebViewController()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;

@end
@implementation LTYWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     自己搞progress的时候，设置一个定时器一点点加，最好搞个动画效果，等到调用webViewDidFinishLoad的时候把定时器停掉
     _maxLoadCount = 100
     _loadingCount += 10
     if (_loadingCount == 90) [timer invalidate];
     
     _loadingCount = _maxLoadCount;
     //给外界传的是
     _loadingCount / _maxLoadCount * 1.0
     */
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = progress == 1.0;
    };
    //让控制器也能监听webview的代理
    //progress框架中把代理吞了，所以在里面又搞了webViewProxyDelegate的属性，把代理转过去就可以了

    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
    
}

#pragma mark - <UIWebViewDelegate>

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
    
}

@end
