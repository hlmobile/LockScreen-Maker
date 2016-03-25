//
//  help.m
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import "help.h"
#import "Reachability.h"

@implementation help
@synthesize isLoad;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	if(isLoad)
	{
		NSURL *url = request.URL;
		
		[[UIApplication sharedApplication] openURL:url];
		isLoad = NO;
		return NO;
	}else {
		isLoad = YES;
		return YES;
	}
	
	
}
- (BOOL) checkConnection
{
	Reachability*  internetReach = [[Reachability reachabilityForInternetConnection] retain];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	
    
    switch (netStatus)
    {
        case NotReachable:
        {
			return NO;
        }
            
			
    }
    
	return YES;
}

// dss //
- (void)viewWillAppear:(BOOL)animated {
	wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
    //324rsj
	[theAppDelegate hideTheAdLabel];

#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Help screen");
	//	[FlurryAPI logEvent:@"Help screen"];
#endif
}
// dss ^ //

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationController.title = @"Help";
	self.title = @"Help";
	isLoad = NO;
	
	
	if(![self checkConnection])
	{
		UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Network Connection Required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[theAlert show];
		[theAlert release];
		return;
	}
	NSString *Path = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"content"]];
	
	
	NSDictionary *tempArray = [[NSDictionary alloc] initWithContentsOfFile:filePath];
		
	
	NSString *connectionURL=[[NSString alloc] initWithString:[[tempArray objectForKey:@"HelpLink"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	
	

	//NSLog(connectionURL);
	
	NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:connectionURL]
						   
										   cachePolicy:NSURLRequestReturnCacheDataElseLoad
						   
									   timeoutInterval:60.0];
	[theWebView loadRequest:request];
	theWebView.delegate = self;
	[connectionURL release];
	[tempArray release];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
