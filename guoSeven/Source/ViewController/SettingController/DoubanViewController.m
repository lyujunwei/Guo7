//
//  DoubanViewController.m
//  guoSeven
//
//  Created by David on 13-1-29.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "DoubanViewController.h"
#import "DOUAPIEngine.h"

#import "common.h"



@interface NSString (ParseCategory)
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue;
@end

@implementation NSString (ParseCategory)

- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue {
    // Explode based on outter glue
    NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
    NSArray *secondExplode;
    
    // Explode based on inner glue
    NSInteger count = [firstExplode count];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode =
        [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
        if ([secondExplode count] == 2) {
            [returnDictionary setObject:[secondExplode objectAtIndex:1]
                                 forKey:[secondExplode objectAtIndex:0]];
        }
    }
    return returnDictionary;
}

@end



@interface DoubanViewController ()
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSURL *requestURL;
@end

@implementation DoubanViewController
@synthesize webView = webView_;
@synthesize requestURL = requestURL_;
@synthesize delegate;


- (id)initWithRequestURL:(NSURL *)aURL {
    self = [super init];
    if (self) {
        self.requestURL = aURL;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)backToPreVC:(id)sender{
    [delegate DoubanFail];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    [backButton addTarget:self action:@selector(backToPreVC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"豆瓣";
    webView_ = [[UIWebView alloc] initWithFrame:CGRectMake(0,
                                                           0,
                                                           self.view.bounds.size.width,
                                                           self.view.bounds.size.height - 44)];
    webView_.scalesPageToFit = YES;
    webView_.delegate = self;
    
    NSString *str = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=code", kDouBanKey, kDouBanRedirectUrl];
    
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView_ loadRequest:request];
    [self.view addSubview:webView_];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *urlObj =  [request URL];
    NSString *url = [urlObj absoluteString];
    
    
    if ([url hasPrefix:kDouBanRedirectUrl]) {
        
        NSString* query = [urlObj query];
        NSMutableDictionary *parsedQuery = [query explodeToDictionaryInnerGlue:@"="
                                                                    outterGlue:@"&"];
        
        //access_denied
        NSString *error = [parsedQuery objectForKey:@"error"];
        if (error) {
            return NO;
        }
        
        //access_accept
        NSString *code = [parsedQuery objectForKey:@"code"];
        DOUOAuthService *service = [DOUOAuthService sharedInstance];
        service.authorizationURL = kTokenUrl;
        service.delegate = self;
        service.clientId = kDouBanKey;
        service.clientSecret = kDouBanPrivateKey;
        service.callbackURL = kDouBanRedirectUrl;
        service.authorizationCode = code;
        
        [service validateAuthorizationCode];
        
        return NO;
    }
    
    return YES;
}


- (void)OAuthClient:(DOUOAuthService *)client didAcquireSuccessDictionary:(NSDictionary *)dic {
    NSLog(@"success!");
    [delegate DoubanSuccess];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)OAuthClient:(DOUOAuthService *)client didFailWithError:(NSError *)error {
    NSLog(@"Fail!");
    [delegate DoubanFail];
}




@end
