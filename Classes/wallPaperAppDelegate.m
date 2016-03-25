//
//  wallPaperAppDelegate.m
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright Prolog Inc 2010. All rights reserved.
//

#import "wallPaperAppDelegate.h"
#import <AudioToolbox/AudioServices.h>
#import "Reachability.h"

#import <CommonCrypto/CommonDigest.h>

//#import "AppZingAPI.h"


#import "TapjoyConnect.h"
#import "Flurry.h"
#import "FlurryAPI.h"
#import "general.h"

#define NAG_SCREEN_TAG  100


@implementation wallPaperAppDelegate

@synthesize  isGridShown;
@synthesize window;
@synthesize vcForAdMob;
@synthesize navigationController;
@synthesize tabBarController1;
@synthesize tabBarController2;
@synthesize tabBarController;
@synthesize isBackLoaded;
@synthesize theBackGroundImagePath;
@synthesize theBackGroundImage;
@synthesize theBackGroundFrame;
@synthesize finalImage;
@synthesize theEffectImage;
@synthesize theEffectFrame;
@synthesize isEffectLoaded;
@synthesize isResetForStep1;
@synthesize isResetForStep2;
@synthesize isLoggedIn;
@synthesize	nagTextURL;
@synthesize nagITunesStoreURL;

@synthesize savedPhotoParamsDictionary;

#pragma mark -
#pragma mark Application lifecycle


#ifdef FLURRY_APPLICATION_KEY
void uncaughtExceptionHandler(NSException *exception)
{
    [Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}
#endif



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
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
    CGRect screenbound = [[UIScreen mainScreen] bounds];
    CGSize screensize = screenbound.size;
    d_width = screensize.width;
    d_height = screensize.height;
        
	if(![self checkConnection])
	{
		UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"This application requires a network connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[theAlert show];
		[theAlert release];
	}

	
// dss //
#ifdef FLURRY_APPLICATION_KEY
	NSSetUncaughtExceptionHandler( &uncaughtExceptionHandler );		// Catch errors and report 'em to Flurry
	[Flurry startSession:FLURRY_APPLICATION_KEY];
#endif
	
#ifdef TAPJOY_APP_ID
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tjcConnectSuccess:) name:TJC_CONNECT_SUCCESS object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tjcConnectFail:) name:TJC_CONNECT_FAILED object:nil];

// NOTE: This must be replaced by your App Id. It is Retrieved from the Tapjoy website, in your account.
	[TapjoyConnect requestTapjoyConnectWithAppId:TAPJOY_APP_ID];
#endif
// dss ^ //
	
/// [AppzingAPI showZing:APP_ZING_APP_ID];
	
	//self.isPlayingMovie = NO;
	isResetForStep1 = NO;
	isResetForStep2 = NO;
	[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isResetForStep1"];
	[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isResetForStep2"];
	isGridShown = NO;
	finalImage = [UIImage imageNamed:@"blank.png"];
	theBackGroundImage = [UIImage imageNamed:@"black.jpg"];
	

	// Add the navigation controller's view to the window and display.
//    tabBarController.viewControllers = [NSArray arrayWithObjects:view1Controller, view2Controller, view3Controller, view4Controller, view5Controller, nil];    
	 
	//Add tabbar to window and display
    float dever = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (dever<=4.0) {
        [window addSubview:tabBarController1.view];
    } else {
        [window addSubview:tabBarController2.view];
    }
	
    
    //324rsj
 //dss //
//#ifdef ADMOB_PUBLISHER_ID
// add a viewController for AdMob
//	vcForAdMob = [[AdMobViewController alloc] initWithNibName:nil bundle:nil];
//#endif
 //dss ^ //
	
	[window makeKeyAndVisible];

// dss //
	[vcForAdMob setUpAdMobAd];
// dss ^ //
    //324rsj
    [self performSelector:@selector(showNagView) withObject:nil afterDelay:DELAY_BEFORE_SHOWING_NAG_SCREEN];
    return YES;
}

#pragma mark -
#pragma mark -
#pragma mark TapjoyConnect Observer methods

-(void) tjcConnectSuccess:(NSNotification*)notifyObj
{
	NSLog(@"Tapjoy connect Succeeded");
}

-(void) tjcConnectFail:(NSNotification*)notifyObj
{
	NSLog(@"Tapjoy connect Failed");
}


#pragma mark -
#pragma mark -
#pragma mark AdMob

- (void) moveTheAdAbove1Tabbar {
	[vcForAdMob moveAdMobAbove1Tabbar];
}

- (void) moveTheAdAbove2Tabbars {
 	[vcForAdMob moveAdMobAbove2Tabbars];
}

- (void) hideTheAdLabel {
 	[vcForAdMob hideAdMob];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
    //324rsj
    [nagTextURL release];
    [nagITunesStoreURL release];
}


/** 
 * Called when a UIServer Dialog successfully return
 */



/////////////////////////////////////////////NAG_SCREEN/////////////////////////


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( alertView.tag == NAG_SCREEN_TAG )
    {
        // the user clicked the OK button
        if ( 1 == buttonIndex )
        {
#ifdef FLURRY_APPLICATION_KEY
            [Flurry logEvent:@"Yes on Nag"];
#endif
            [[UIApplication sharedApplication] openURL:nagITunesStoreURL];
        }
        else
        {
#ifdef FLURRY_APPLICATION_KEY
            [Flurry logEvent:@"Dismissed Nag"];
#endif
        }
    }
}



- (void)didAcceptZing:(AppzingAPI *)appzing
{
    [Flurry logEvent:@"Zing: Clicked Yes!"];
}

- (void)didNotLoadZing:(AppzingAPI *)appzing
{
    // If a zing fails then let's try to show a nag screen
    [self performSelectorInBackground:@selector(loadNagContentInBackground) withObject:nil];
}

//notification that the zing no thanks was clicked
- (void)didNotAcceptZing:(AppzingAPI *)appzing
{

    [Flurry logEvent:@"Zing: Clicked No thanks"];

}



- (void)showNagView
{

    if ( arc4random() % 100 < PERCENT_CHANCE_OF_ZING_INSTEAD_OF_NAG )
    {
        //[AppzingAPI showZing:APP_ZING_APP_ID zingDelegate:self];
    }
    else

    {
        [self performSelectorInBackground:@selector(loadNagContentInBackground) withObject:nil];
    }
}


- (void)loadNagContentInBackground
{
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    NSStringEncoding encodingUsed;
    NSError * error;
    NSURL * nagTextFileURL = [NSURL URLWithString:NAG_FILE_URL];
	NSString * nagTextFromURL = [NSString stringWithContentsOfURL:nagTextFileURL usedEncoding:&encodingUsed error: &error];
    [self performSelectorOnMainThread:@selector(dataLoadedNowShowNagView:) withObject:nagTextFromURL waitUntilDone:YES];
    [pool release];
    
}


- (void)dataLoadedNowShowNagView:(NSString *)nagTextFromURL
{
    // Display nag alert if there's some nag text
    if ( [nagTextFromURL length] == 0 )
    {
        NSLog(@"No nag message");

        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"" message:@"No Nag Message" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", "No Thanks button on advertisement screen") otherButtonTitles:nil, nil]
                               autorelease];
        alertView.tag = NAG_SCREEN_TAG; // So we know which alert we're dealing with in the click method
        [alertView show];
        
    }
    else
    {
        NSLog(@"Show nag message");

        [Flurry logEvent:@"Show Nag Message"];

        
        // Let's split the string into two parts with "@@@" as the separator
        NSArray *strings = [nagTextFromURL componentsSeparatedByString:@"@@@"];
        if ([strings count] == 2 )
        {
            NSString * nagTextContent = [strings objectAtIndex:0];
            nagITunesStoreURL = [[NSURL alloc] initWithString:[strings objectAtIndex:1]];
            UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle:@""
                                                                 message:nagTextContent
                                                                delegate:self
                                                       cancelButtonTitle:NSLocalizedString(@"No Thanks", "No Thanks button on advertisement screen" )
                                                       otherButtonTitles:NSLocalizedString(@"OK", "OK button on advertisement screen"), nil
                                       ] autorelease];
            alertView.tag = NAG_SCREEN_TAG; // So we know which alert we're dealing with in the click method
            [alertView show];
        }
        else
        {
            NSString * messageStr = [[NSString alloc] initWithFormat:@"Wrong number of strings in nag file: %@", nagTextFromURL];
            //            NSLog( messageStr );

            [Flurry logError:@"Nag File Error" message:messageStr exception:nil];

            [messageStr release];
        }
    }
}
//----------------------------NAG Screen-----------------------------------------//



@end

