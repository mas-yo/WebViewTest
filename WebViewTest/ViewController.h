//
//  ViewController.h
//  WebViewTest
//
//  Created by YOSHIDA MASAHIRO on 2015/10/30.
//  Copyright © 2015年 NHN PlayArt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController <WKNavigationDelegate>
{
    WKWebView* _webView;
}

@end

