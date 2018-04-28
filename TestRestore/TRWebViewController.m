//
//  TRWebViewController.m
//  TestRestore
//
//  Created by Scarlett Che on 2018/4/27.
//  Copyright © 2018年 Scarlett Che. All rights reserved.
//

#import "TRWebViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"

@interface TRWebViewController () <UIWebViewDelegate, UIViewControllerRestoration>
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, assign) BOOL  restored;
@end

@implementation TRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.restorationClass = [self class];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.restored) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        [self.webView loadRequest:request];
    } else {
        self.restored = NO;
        [self.webView reload];
    }
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    self.restored = YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TRWebViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TRWebViewController"];
    vc.restorationClass = [TRWebViewController class];
    return vc;
}
@end
