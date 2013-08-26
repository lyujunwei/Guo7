//
//  TCWBAuthorizeViewController.m
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-9-7.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCWBAuthorizeViewController.h"
#import "key.h"


@implementation TCWBAuthorizeViewController

@synthesize requestURLString;
@synthesize delegate;
@synthesize returnCode, err;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad{
    [super viewDidLoad];
    
//    NSBundle *main = [NSBundle mainBundle];

    // 授权  
//    NSString *strAuth = [main localizedStringForKey:KLanguageAuth value:nil table:kTCWBTable];
//    [self.navigationItem setTitle:strAuth];
    
        self.title = @"QQ";
    

//    NSString *strCancel = [main localizedStringForKey:KLanguageCancel value:nil table:kTCWBTable];
//    UIBarButtonItem *baritemCancel = [[UIBarButtonItem alloc] initWithTitle:strCancel style:UIBarButtonItemStyleBordered target:self action:@selector(onButtonCancel)];
//    [self.navigationItem setLeftBarButtonItem:baritemCancel];
//    [baritemCancel release];
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 3, 45, 28)];
    UILabel *leftlab=[[UILabel alloc]initWithFrame:CGRectMake(14, 3, 24, 20)];
    leftlab.text=@"返回";
    leftlab.backgroundColor=[UIColor clearColor];
    [leftlab setTextColor:[UIColor whiteColor]];
    leftlab.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    [backButton addSubview:leftlab];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back@2x.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icontop-back2@2x.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(onButtonCancel) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    
    
    if (IS_IPHONE5) {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 510)];
    }else{
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    }
    [webView setDelegate:self];
    webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:requestURLString]
                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                        timeoutInterval:60.0];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(160, 200)];
    [self.view addSubview:indicatorView];
}


- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc{
    [indicatorView release];
    indicatorView = nil;
    [webView stopLoading];
	webView.delegate = nil;		
	[webView release];
	webView = nil;
    [requestURLString release];
    requestURLString = nil;
    [returnCode release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidDisappear:(BOOL)animated{
    // 返回授权结果
    if (returnCode){
        if ([delegate respondsToSelector:@selector(authorize:didSucceedWithAccessToken:)]) {
            [delegate authorize:self didSucceedWithAccessToken:self.returnCode];
        }
    }
    else {
        if (self.err == nil) {
            self.err = [NSError errorWithDomain:TCWBSDKErrorDomain 
                                           code:TCWBErrorCodeSDK 
                                       userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", TCWBSDKErrorCodeAuthorizeError] forKey:TCWBSDKErrorCodeKey]
                        ];
        }
        if([delegate respondsToSelector:@selector(authorize:didFailuredWithError:)]){
            [delegate authorize:self didFailuredWithError:self.err];
        }
    }
    [super viewDidDisappear:animated];
}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)aWebView{
	[indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView{
	[indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error{
    [indicatorView stopAnimating];
    self.err = error;
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlString = [[NSString alloc] initWithString:request.URL.absoluteString];
    NSRange range = [urlString rangeOfString:@"access_token="];
    
    if (range.location != NSNotFound){
        NSRange scope = [urlString rangeOfString:@"#"];
        NSString *code = [urlString substringFromIndex:scope.location + scope.length];
        self.returnCode = code;
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"授权成功"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//        [alertView release];
        [self dismissModalViewControllerAnimated:YES];

    }
    
    [urlString release];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissModalViewControllerAnimated:YES];
}



#pragma mark 按钮响应函数

- (void)onButtonCancel {
    
    [self dismissModalViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
