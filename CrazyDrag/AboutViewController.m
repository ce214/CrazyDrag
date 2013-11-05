//
//  AboutViewController.m
//  CrazyDrag
//
//  Created by cdz on 13-11-5.
//  Copyright (c) 2013年 ichenxiaodao. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
- (IBAction)close:(id)sender;

@end


@implementation AboutViewController

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //display a html file
    NSString *htmlFile =[[NSBundle mainBundle]pathForResource:@"CrazyDrag" ofType:@"html"]; //获取文件
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile]; //读取文件的每个字节，返回包含所有内容的对象
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]];
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
    /*display a web site
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 关闭按钮
 */
- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
