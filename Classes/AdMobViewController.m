//
//  AdMobViewController.m
//  wallPaper
//
//  Created by David Snider on 10/23/10.
//  Copyright 2010 Midnight Magic Games. All rights reserved.
//

#import "AdMobViewController.h"
#import "wallPaperAppDelegate.h"


@implementation AdMobViewController



- (void)setUpAdMobAd
{
    CGRect adRect;
	
    adRect.size = ADMOB_SIZE_320x48;
    adRect.origin.x = 0;
    adRect.origin.y = 384;
    adContainerView = [[UIView alloc] initWithFrame:adRect];
    
    adMobView = [AdMobView requestAdOfSize:ADMOB_SIZE_320x48 withDelegate:self]; // start a new ad request
	
    [adMobView retain];      
    adContainerView.backgroundColor = [UIColor clearColor];
	
	
	NSLog(@"AdMob version = %@", [AdMobView version]);
}

// Request a new ad. If a new ad is successfully loaded, it will be animated into location.
- (void)refreshAd:(NSTimer *)timer
{
    [adMobView requestFreshAd];
}

#pragma mark -
#pragma mark AdMobDelegate methods

- (NSString *)publisherIdForAd:(AdMobView *)adView
{
#ifdef ADMOB_PUBLISHER_ID	
    return ADMOB_PUBLISHER_ID; // MAKE SURE to leave this alone so we ALWAYS use the ones set in the pch files for each target!
#else
	return nil;
#endif
}


- (UIViewController *)currentViewControllerForAd:(AdMobView *)adView
{
	return (UIViewController *) self;
}


// Sent when an ad request loaded an ad; this is a good opportunity to attach
// the ad view to the hierachy.
- (void)didReceiveAd:(AdMobView *)adView
{
    NSLog(@"AdMob: Did receive ad");
	[adContainerView addSubview:adMobView];
 
	wallPaperAppDelegate* myDelegate = (wallPaperAppDelegate *)[[UIApplication sharedApplication] delegate];
	[myDelegate.window addSubview:adContainerView];
    
	[refreshTimer invalidate];
// BOGUS -- is this necessary any more?
	refreshTimer = [NSTimer scheduledTimerWithTimeInterval:45.0f target:self selector:@selector(refreshAd:) userInfo:nil repeats:YES];
}

// Sent when an ad request failed to load an ad
- (void)didFailToReceiveAd:(AdMobView *)adView
{
    NSLog(@"AdMob: Did fail to receive ad");
    [adMobView release];
    adMobView = nil;
// BOGUS -- is this necessary any more?
	refreshTimer = [NSTimer scheduledTimerWithTimeInterval:45.0f target:self selector:@selector(refreshAd:) userInfo:nil repeats:YES];
}

#pragma mark -
#pragma mark reposition the AdMob banner

- (void) moveAdMobAbove1Tabbar {
	CGRect frame = adContainerView.frame;
	frame.origin.y = 384;
	adContainerView.frame = frame;
	adContainerView.hidden = NO;
}

- (void) moveAdMobAbove2Tabbars {
	CGRect frame = adContainerView.frame;
	frame.origin.y = 340;
	adContainerView.frame = frame;
	adContainerView.hidden = NO;
}
- (void) hideAdMob {
	adContainerView.hidden = YES;
}


#pragma mark -


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
