//
//  step3.m
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import "step3.h"

//#import "EmailSystemViewController.h"
#import "step3Extra.h"
#import <MessageUI/MessageUI.h>
#import "Flurry.h"
#import "general.h"
#import "HFViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation step3
@synthesize newImageFinal;
@synthesize isGridShown;
@synthesize backImage;
@synthesize effecteffectImage;
@synthesize isProcessing;
@synthesize theBackgroundList;
@synthesize theEffectList;

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;
-(UIImage*)getImage
{
///	NSLog(@"comcom12");
	//appDelegate = [[UIApplication sharedApplication]delegate];
	step3Extra *extra = [[step3Extra alloc]init];
	
	NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep2"];
	if([str isEqualToString:@"1"])
	{
		[extra setEffectImage];
	}
	str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep1"];
	if([str isEqualToString:@"1"])
	{
		
		[extra setBackgroundImage];
    }

	UIImage *containerImage = [extra getBackgroundImage];
	CGRect rect = [extra getBackgroundFrame];
	UIImage *effectImage = [extra getEffectImage];
    
	
	[extra release];
	
	float imwidth = containerImage.size.width;
	float imheight = containerImage.size.height;
	
	float frameWidth = rect.size.width;
	float frameHeight = rect.size.height;
	float frameX = rect.origin.x;
	float frameY = rect.origin.y;
	
	float xx,yy,ww,hh;
	
	xx = (0.0f - frameX) * imwidth/frameWidth;
	yy = (0.0f - frameY) * imheight/frameHeight;
	ww = d_width * imwidth/frameWidth; 
	hh = d_height * imheight/frameHeight;
	
	//float xx =  rect.       //(rect.size.width - 320)/2;
	//xx = //xx * 640 / rect.size.width;
	//float yy = //(rect.size.height - 480)/2;
	//yy = //yy  * 960 / rect.size.height;
	//NSLog(@"-------%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width,rect.size.height );
	
	//NSLog(@"----%f %f %f %f ",xx,yy,640 - xx * 2, 960 - yy * 2);
	//float ww = rect.origin.x + (rect.size.width - 640)/2;
	//float xx = rect.origin.x + (rect.size.width - 640)/2;
	
	CGRect clippedRect = CGRectMake(xx,yy, ww,hh);
    
	//CGRect clippedRect = CGRectMake(frameX, frameY, 640, 1136);
	//containerImage = [self imageByCropping:containerImage toRect:clippedRect];
	
	//UIGraphicsBeginImageContext(newSize.size);
	//[containerImage drawInRect:newSize];
	
	//CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	//CGContextClipToRect( currentContext, clippedRect);
	//containerImage = UIGraphicsGetImageFromCurrentImageContext();
	
	//pop the context to get back to the default
	//UIGraphicsEndImageContext();
///		NSLog(@"11");
	CGImageRef imageRef = CGImageCreateWithImageInRect([containerImage CGImage], clippedRect);
    containerImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
///		NSLog(@"111");
    //324rsj
	CGRect newSize = CGRectMake(0.0, 0.0, d_width*2, d_height*2);
////////////////////////////////////////////////////////
	UIGraphicsBeginImageContext(newSize.size);
	[containerImage drawInRect:newSize];
    containerImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
///////////////////////////////////////////////////////
	UIGraphicsBeginImageContext(containerImage.size);
	
	[containerImage drawAtPoint:CGPointMake(0, 0)];
	[effectImage drawAtPoint:CGPointMake(0, -yy)];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
///////////////////////////////////////////////////////
	return newImage;
}
-(IBAction)facebookPressed:(id)sender
{
		
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
		if(buttonIndex==0) {
#ifdef FLURRY_APPLICATION_KEY
			NSLog(@"  -  Flurry: Step3: Save as Wallpaper selected");
			[Flurry logEvent:@"Step3: Save as Wallpaper selected"];
#endif
			UIImageWriteToSavedPhotosAlbum(newImageFinal, nil, nil, nil);
			
			UIAlertView *theAlert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Image saved to gallery" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[theAlert show];
			[theAlert release];
// dss //
			wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
			[theAppDelegate moveTheAdAbove2Tabbars];	
// dss ^ //
		}else if(buttonIndex == 1)
		{
#ifdef FLURRY_APPLICATION_KEY
			NSLog(@"  -  Flurry: Step3: Email selected");
			[Flurry logEvent:@"Step3: Email selected"];
#endif
// dss //
			wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
            //324rsj
			[theAppDelegate hideTheAdLabel];
// dss ^ //
#
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			[picker setSubject:DEFAULT_SHARE_BY_EMAIL_MESSAGE_TITLE];
			[picker setMessageBody:DEFAULT_SHARE_BY_EMAIL_MESSAGE_CONTENT isHTML:YES];
			
			//[picker setSubject:DEFAULT_SHARE_BY_EMAIL_MESSAGE_TITLE];
			
			//[picker setMessageBody:DEFAULT_SHARE_BY_EMAIL_MESSAGE_CONTENT isHTML:YES];
			picker.navigationBar.barStyle = UIBarStyleBlack;
			
			// add the image attachment
			//NSDictionary * imageDictionary = [self getDictionaryForCurrentImage];
			//NSString *imageFileName = [NSString stringWithFormat:@"%@", [imageDictionary objectForKey:@"image"]];
			
			//[newImageFinal ]
			NSData *myData = UIImagePNGRepresentation(newImageFinal);
			[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"wallpaper.png"];
			//[picker addAttachmentData:(NSData *)attachment mimeType:<#(NSString *)mimeType#> fileName:<#(NSString *)filename#>
			[self presentModalViewController:picker animated:YES];
			[picker release];
			
			
			//EmailSystemViewController *emailSystemViewController=[[EmailSystemViewController alloc] initWithNibName:@"EmailSystemViewController" bundle:[NSBundle mainBundle]];
			//emailSystemViewController.image=newImageFinal;
			//[self.navigationController presentModalViewController:emailSystemViewController animated:YES];
			//[self.navigationController pushViewController:emailSystemViewController animated:YES];
			//[emailSystemViewController release];
		}//else if(buttonIndex == 2)
//		{
//#ifdef FLURRY_APPLICATION_KEY
//			NSLog(@"  -  Flurry: Step3: Facebook selected");
//			[Flurry logEvent:@"Step3: Facebook selected"];
//#endif
//
//// dss //
//			wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
//			//324rsj
//            [theAppDelegate hideTheAdLabel];
//// dss ^ //
//
//			//NSDictionary * imageDictionary = [self getDictionaryForCurrentImage];
//			//NSString *imageFileName = [NSString stringWithFormat:@"%@", [imageDictionary objectForKey:@"image"]];
//			// Load the image
//			//UIImage *myImage = newImageFinal;			
//			// Store the image and our other params in a dictionary
//			//NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//			//								myImage, @"picture",
//			//								//FACEBOOK_IMAGE_CAPTION, @"caption",
//			//								FACEBOOK_IMAGE_CAPTION,@"Caption",
//			//								nil];
//			
//			// Hand it off to the App Delegate    
//			//wallPaperAppDelegate *appDelegate = (wallPaperAppDelegate *)[[UIApplication sharedApplication] delegate];
//			//[appDelegate postPictureToFacebook:params];    
//			
//			//[myImage release];
//            //HFViewController *next = [[HFViewController alloc]initWithNibName:@"HFViewController" bundle:[NSBundle mainBundle]];
//            //next.imgForUpload = newImageFinal;
//            _imgForUpload = newImageFinal;
//			self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//			self.window.rootViewController = [[HFViewController alloc] initWithNibName:@"HFViewController_iPhone" bundle:nil];
//            [self.window makeKeyAndVisible];
//			
//	
//			
//			//268 357
//			//next.view.frame = CGRectMake(26, 30, 268, 357);
//			
//			//[self.view addSubview:next.view];
//			
//			//[next release];
//		}
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if ( result == MFMailComposeResultFailed )
    {
       // [FlurryAPI logError:@"share by email FAILED" message:@"" exception:nil];  
    }
    else if ( result == MFMailComposeResultSent )
    {
		//[FlurryAPI logEvent:@"Shared via email"];
    }
    
	// Get rid of the mail view    
    [self dismissModalViewControllerAnimated:YES];

// dss //
	wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
	[theAppDelegate moveTheAdAbove2Tabbars];	
// dss ^ //
}
- (IBAction) emailButtonPressed:(id)sender
{
	
	//EmailSystemViewController *emailSystemViewController=[[EmailSystemViewController alloc] initWithNibName:@"EmailSystemViewController" bundle:[NSBundle mainBundle]];
	//emailSystemViewController.image=newImageFinal;
	//[self.navigationController presentModalViewController:emailSystemViewController animated:YES];
	//[emailSystemViewController release];
	
	
		
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
///		NSLog(@"1");
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	isGridShown = NO;
	theIconImageView.image = [UIImage imageNamed:@"iconBackground.png"];
	theIconImageView.hidden = YES;
	self.title = @"Save and Share";
	self.navigationController.title  = @"Save & Share";
	
	//step2ImageView *theNextView = [[step2ImageView alloc]initWithNibName:@"step2ImageView" bundle:[NSBundle mainBundle]];


	//newImage = [self getImage];
	
	//theIconImageView.image = [UIImage imageNamed:@"iconBackground.png"];
	//thebackGroundImageView.image = newImage;
	//thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	//imageimage st = [[imageimage alloc]initWithNibName:@"imageimage" bundle:[NSBundle mainBundle]];
	//newImage = [st getImage];
    
	[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
	//if(msect >= 1000) [self randomButton_Clicked];
	UIBarButtonItem *randomButton = [[UIBarButtonItem alloc]init];//WithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(randomButton_Clicked)];
	randomButton.action = @selector(gotoFirstScreen);
	randomButton.target = self;
	randomButton.style = UIBarButtonItemStylePlain;
	randomButton.image = [UIImage imageNamed:@"refresh.png"];
	self.navigationItem.rightBarButtonItem = randomButton;
	
	//self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyle;
	
//	[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
//	appDelegate.isEffectLoaded = YES;
	//if(msect >= 1000) [self randomButton_Clicked];
	
///	NSLog(@"2");
	
	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep1"];
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep2"];
		
		step3Extra *theNextView = [[step3Extra alloc]init];
		NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep2"];
		if([str isEqualToString:@"1"])
		{
			//[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isResetForStep2"];
			[theNextView reset];
		}
		
		
		
		
		//appDelegate.isResetForStep1 = YES;
		//appDelegate.isResetForStep2 = YES;
		//[self.navigationController popViewControllerAnimated:NO];
		//self.tabBarController.
		self.tabBarController.selectedIndex = 0;
		self.tabBarController.selectedIndex = 0;
	}
}
-(void)gotoFirstScreen
{
#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Reset wallpaper pressed");
	[Flurry logEvent:@"Reset wallpaper pressed"];
#endif
	
	UIAlertView *theAlert = [[UIAlertView alloc]initWithTitle:@"Clear Your Choices" message:@"Do you want to reset your choices?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
	[theAlert show];
	[theAlert release];
}
-(void)gotoFirstScreen2
{
	[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep1"];
	[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep2"];
	
	
	
	//appDelegate.isResetForStep1 = YES;
	//appDelegate.isResetForStep2 = YES;
	//[self.navigationController popViewControllerAnimated:NO];
	//self.tabBarController.
	self.tabBarController.selectedIndex = 0;
	self.tabBarController.selectedIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
	isProcessing = NO;
	theEffectView.hidden = YES;
    [super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
	//step2ImageView *theNextView = [[step2ImageView alloc]initWithNibName:@"step2ImageView" bundle:[NSBundle mainBundle]];
	
	
	newImageFinal = [self getImage];
	
	
	thebackGroundImageView.image = newImageFinal;
	thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	//imageimage st = [[imageimage alloc]initWithNibName:@"imageimage" bundle:[NSBundle mainBundle]];
	//newImage = [st getImage];
	[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
//	[theNextView release];
	
	NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectAction"];
	if([str isEqualToString:@"1"])
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"selectAction"];
		[self actionButtonPressed:nil];
	}
	
	str = [[NSUserDefaults standardUserDefaults] stringForKey:@"selectRandom"];
	if([str isEqualToString:@"1"])
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"selectRandom"];
		[self randomButton_Clicked];
	}
	
// dss //
//	wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
//	[theAppDelegate moveTheAdAbove2Tabbars];
// dss ^ //

#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Step3: Save and Share");
	[Flurry logEvent:@"Step3: Save and Share"];
#endif
}
-(void)theSelector
{
	thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	theIconImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	theEffectView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
}
-(IBAction)diceButtonPressed:(id)sender
{
#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Grid Button pressed");
	[Flurry logEvent:@"Grid Button pressed"];
#endif
	if(isGridShown)
	{
		isGridShown = NO;
		theIconImageView.hidden = YES;
	}else {
		isGridShown = YES;		
		theIconImageView.hidden = NO;
	}
	
}

-(IBAction)actionButtonPressed:(id)sender
{
	NSMutableArray *thisArray = [[NSMutableArray alloc]init];
	[thisArray addObject:@"Email"];
	[thisArray addObject:@"Facebook"];
	//33333
//	UIActionSheet *actionSheet = [[UIActionSheet alloc]
//								 initWithTitle:nil
//								 delegate:self
//								 cancelButtonTitle:@"Cancel"
//								 destructiveButtonTitle:nil
//								 otherButtonTitles:@"Save as Lockscreen",@"Email",@"Facebo",nil];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Save as Lockscreen",@"Email",nil];
	
    //popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    //[popupQuery showInView:self.tabBarController.view];
    //[popupQuery release];
	
	//UIActionSheet *actionSheet = 
	//	[[UIActionSheet alloc] initWithTitle:"" 
	//							delegate:self 
	//				   cancelButtonTitle:@"Cancel"
	//			  destructiveButtonTitle: nil
	//				   otherButtonTitles:@"Email",@"Facebook",nil];
	
	
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	actionSheet.cancelButtonIndex=3;
	[actionSheet showInView:self.view];	
	[actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
	[actionSheet release];
}

-(void)setImage:(UIImage*) imageEffect withBack:(UIImage*) backgroundImage
{
	step3Extra *extra = [[step3Extra alloc]init];
	[extra setImage:imageEffect withBack:backgroundImage];
	[extra isLoadedActionTotal];
	[extra release];
}
-(IBAction)randomButton_Clicked
{
#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Randomize Button pressed");
	[Flurry logEvent:@"Randomize Button pressed"];
#endif
	
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	// display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	NSString *currentTime = [dateFormatter stringFromDate:today];
	[dateFormatter release];
	NSLog(@"%@",currentTime);
	//return;
	NSArray *theArray1 = [currentTime componentsSeparatedByString:@" "];
	NSArray *theArray = [[theArray1 objectAtIndex:0] componentsSeparatedByString:@":"];
	int hr = [[theArray objectAtIndex:0] intValue];
	int min = [[theArray objectAtIndex:1] intValue];
	int sec = [[theArray objectAtIndex:2] intValue];

	
///		NSLog(@"1");
	if(isProcessing) return;
	isProcessing = YES;
	NSString *Path = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"effectList"]];
	
	NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:filePath];
	int rand = random() % [tempArray count];
	NSArray *cellArray = [tempArray objectAtIndex:rand];
	
	
	
	cellArray = [cellArray objectAtIndex:1];

	int imageIndex = ((hr + min)+(hr + min + sec)*random()) % [cellArray count];
	
	NSString *imagePath = [cellArray objectAtIndex:imageIndex];

	UIImage *effectImage = [UIImage imageNamed:imagePath];
	
	effecteffectImage = effectImage;
	
	[tempArray release];
	
	filePath = [Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"backgroundList"]];
	
	tempArray = [[NSArray alloc] initWithContentsOfFile:filePath];
	rand = ((hr + min)+(hr + min + sec)*random()) % [tempArray count];
	
	if(rand == 0) rand = ((hr + min)+(hr + min + sec)*random()) % [tempArray count];
	
	cellArray = [tempArray objectAtIndex:rand];
	
	cellArray = [cellArray objectAtIndex:1];
	
	
	
	imageIndex = ((hr + min)+(hr + min + sec)*random()) % [cellArray count];
	
	imagePath = [cellArray objectAtIndex:imageIndex];
	//[cellArray release];
	UIImage *backgroundImage = [UIImage imageNamed:imagePath];
	
	[tempArray release];
	
	
	//step2ImageView *theNextView = [[step2ImageView alloc]initWithNibName:@"step2ImageView" bundle:[NSBundle mainBundle]];
	
	[self setImage:effectImage withBack:backgroundImage];
	//[self isLoadedActionTotal];
///	NSLog(@"11");
	newImageFinal = [self getImage];
	//[newImage retain];
///	NSLog(@"12");
	
	//UIImage *im1  = [UIImage imageNamed:@"camouflage_07.png"];
	//UIImage *im2  = [UIImage imageNamed:@"cute_03.png"];
	//UIImage *im3  = [UIImage imageNamed:@"fire_02.png"];
	//UIImage *im4  = [UIImage imageNamed:@"Grunge_35.png"];
	//UIImage *im5  = [UIImage imageNamed:@"love_05.png"];
	//UIImage *im6  = [UIImage imageNamed:@"metal_05.png"];
	
	
	backImage = backgroundImage;
	//gifView.
	//thebackGroundImageView.animationImages = [[NSArray alloc] initWithObjects: 
	//						   im1,backgroundImage,im2,im3,backgroundImage,im4,im5,im6,backgroundImage,nil];
	
	//thebackGroundImageView.animationDuration = 1;
	// repeat the annimation forever
	//thebackGroundImageView.animationRepeatCount = 100000;
	// start animating
	//[thebackGroundImageView startAnimating];
	
	
	
	
	thebackGroundImageView.image = newImageFinal;
	isProcessing = NO;
	//[self performSelector:@selector(theSelectorAnimation1) withObject:self afterDelay:1];
		//imageimage st = [[imageimage alloc]initWithNibName:@"imageimage" bundle:[NSBundle mainBundle]];
	//newImage = [st getImage];
	[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
	//[cellArray release];
	//[theNextView release];
///		NSLog(@"2");

}
-(void)theSelectorAnimation1
{
	NSLog(@"theSelectorAnimation1");
	[thebackGroundImageView stopAnimating];
	thebackGroundImageView.image = backImage;
	
	//cute_03.pngfire_02.pngGrunge_35.pnglove_05.pngmetal_05.pngspace_03.pngtechno_07.png
	
	UIImage *im1  = [UIImage imageNamed:@"effect_cute_02.png"];
	UIImage *im2  = [UIImage imageNamed:@"effect_edge_01.png"];
	UIImage *im3  = [UIImage imageNamed:@"effect_outerglow_09.png"];
	UIImage *im4  = [UIImage imageNamed:@"effect_love_11.png"];
	UIImage *im5  = [UIImage imageNamed:@"effect_outerglow_10.png"];
	UIImage *im6  = [UIImage imageNamed:@"effect_water_08.png"];
		
	
	theEffectView.hidden = NO;
	//gifView.
	theEffectView.animationImages = [[NSArray alloc] initWithObjects: 
											  im1,im2,effecteffectImage,im3,im4,effecteffectImage,im5,im6,effecteffectImage,nil];
	
	theEffectView.animationDuration = 2;
	// repeat the annimation forever
	//theEffectView.animationRepeatCount = 100000;
	// start animating
	[theEffectView startAnimating];
	[self performSelector:@selector(theSelectorAnimation2) withObject:self afterDelay:2];
	NSLog(@"theSelectorAnimation1");
}
-(void)theSelectorAnimation2
{
	NSLog(@"theSelectorAnimation2");
	[theEffectView stopAnimating];
	
	theIconImageView.image = [UIImage imageNamed:@"iconBackground.png"];
	thebackGroundImageView.image = newImageFinal;
	thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	
	theEffectView.hidden = YES;
	NSLog(@"theSelectorAnimation2");
	[newImageFinal release];
	isProcessing = NO;
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


//------------------------FACEBOOK_API_KEY-----------------
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object
    [FBSession.activeSession close];
}

- (void)applicationDidBecomeActive:(UIApplication *)application	{
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
}


@end
