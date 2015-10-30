//
//  ViewController.m
//  WebViewTest
//
//  Created by YOSHIDA MASAHIRO on 2015/10/30.
//  Copyright © 2015年 NHN PlayArt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];

    _webView = [WKWebView new];

    // Auto Layout の設定
    // 画面いっぱいに WKWebView を表示するようにする
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:_webView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_webView
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:_webView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_webView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.0
                                                              constant:0]
                                ]];

    // デリゲートにこのビューコントローラを設定する
    _webView.navigationDelegate = self;

    // フリップでの戻る・進むを有効にする
    _webView.allowsBackForwardNavigationGestures = YES;

    _webView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];

    // WKWebView インスタンスを画面に配置する
//    [self.view insertSubview:_webView atIndex:0];
    self.view = _webView;
//    [self.view addSubview:_webView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [_webView loadHTMLString:@"<html><body><br/><br/><br/><br/><br/>hello</body></html>" baseURL:nil];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test1" ofType:@"html" inDirectory:@"Resource"]]]];

//    [_webView loadRequest:NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("index", ofType: "html")!)!))

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WKNavigationDelegate methods

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s:%@", __FUNCTION__, error);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);

    [_webView evaluateJavaScript:@"$('#ext').attr('src','data:image/png;base64,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');" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}


@end
