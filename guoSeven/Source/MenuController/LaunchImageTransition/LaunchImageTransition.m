//
//  LaunchImageTransition.m
//  Created by http://github.com/iosdeveloper
//

#import "LaunchImageTransition.h"

@implementation LaunchImageTransition

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (id)initWithViewController:(UIViewController *)controller animation:(UIModalTransitionStyle)transition {
	return [self initWithViewController:controller animation:transition delay:1.0];
}

- (id)initWithViewController:(UIViewController *)controller animation:(UIModalTransitionStyle)transition delay:(NSTimeInterval)seconds {
	self = [super init];
	
	if (self) {
		NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
		NSLog(@"infoDictionary:%@",infoDictionary);
		NSString *launchImageFile = [infoDictionary objectForKey:@"UILaunchImageFile"];
		
		NSString *launchImageFileiPhone = [infoDictionary objectForKey:@"UILaunchImageFile~iphone"];
		
		if (launchImageFile != nil) {
			[self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImageFile]]];
		} else if (launchImageFileiPhone != nil) {
			[self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImageFileiPhone]]];
		} else {
            if (IS_IPHONE5) {
                [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default_1136_2x.png"]]];
            }else {
                [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default_960_2x.png"]]];
            }
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(98, 100, 126, 52)];
            img.image = [UIImage imageNamed:@"logo-big.png"];
            
            [self.view addSubview:img];
            img.center = self.view.center;
		}
		
		[controller setModalTransitionStyle:transition];
		
		[NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(timerFireMethod:) userInfo:controller repeats:NO];
	}
	
	return self;
}

- (void)timerFireMethod:(NSTimer *)theTimer {
	[self presentModalViewController:[theTimer userInfo] animated:YES];
}

@end