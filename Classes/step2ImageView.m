    //
//  step2ImageView.m
//  wallPaper
//
//  Created by Tithy on 8/27/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import "step2ImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "Flurry.h"
#import "general.h"

@implementation step2ImageView
@synthesize section;
@synthesize cellArray;
@synthesize imageIndex;
@synthesize isShow;
@synthesize prevTouchPoint;
@synthesize pathForRes;
@synthesize isprocessing;
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
	//create a context to do our clipping in
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	//create a rect with the size we want to crop the image to
	//the X and Y here are zero so we start at the beginning of our
	//newly created context
	CGRect clippedRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
	CGContextClipToRect( currentContext, clippedRect);
	
	//create a rect equivalent to the full size of the image
	//offset the rect by the X and Y we want to start the crop
	//from in order to cut off anything before them
	CGRect drawRect = CGRectMake(rect.origin.x ,
								 rect.origin.y ,
								 imageToCrop.size.width,
								 imageToCrop.size.height);
	
	//draw the image to our clipped context using our offset rect
	CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
	
	//CGContextDrawImage(<#CGContextRef c#>, <#CGRect rect#>, <#CGImageRef image#>)
	
	//pull the image from our cropped context
	UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
	
	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	
	//Note: this is autoreleased
	return cropped;
}
-(void)reset
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theBackGroundFrame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	appDelegate.theBackGroundImage = [UIImage imageNamed:@"black.jpg"];
	appDelegate.theEffectImage = nil;
}
-(CGRect)theBackGroundFrame
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theBackGroundFrame;
}
-(UIImage*)theBackGroundImage
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theBackGroundImage;
}
-(UIImage*)theEffectImage
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theEffectImage;
}
-(UIImage*)getImage
{
///	NSLog(@"comcom");
	appDelegate = [[UIApplication sharedApplication]delegate];
	
	NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep2"];
	if([str isEqualToString:@"1"])
	{
		
		appDelegate.theEffectImage = nil;
		
		//[self.navigationController popViewControllerAnimated:NO];
	}
	str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep1"];
	if([str isEqualToString:@"1"])
	{
		
		appDelegate.theBackGroundImage = nil;
		
		//[self.navigationController popViewControllerAnimated:NO];
	}
	
	UIImage *containerImage = appDelegate.theBackGroundImage;
	
	

	
	CGRect rect = appDelegate.theBackGroundFrame;
	float imwidth = containerImage.size.width;
	float imheight = containerImage.size.height;
	
	float frameWidth = rect.size.width;
	float frameHeight = rect.size.height;
	float frameX = rect.origin.x;
	float frameY = rect.origin.y;
	
	float xx,yy,ww,hh;
	
	xx = (0.0f - frameX) * imwidth/frameWidth;
	yy = (0.0f - frameY) * imheight/frameHeight;
	ww = d_width * imwidth/frameWidth;; 
	hh = d_height  * imheight/frameHeight;
		
	//float xx =  rect.       //(rect.size.width - 320)/2;
	//xx = //xx * 640 / rect.size.width;
	//float yy = //(rect.size.height - 480)/2;
	//yy = //yy  * 960 / rect.size.height;
	//NSLog(@"-------%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width,rect.size.height );
	
	//NSLog(@"----%f %f %f %f ",xx,yy,640 - xx * 2, 960 - yy * 2);
	//float ww = rect.origin.x + (rect.size.width - 640)/2;
	//float xx = rect.origin.x + (rect.size.width - 640)/2;
	
	CGRect clippedRect = CGRectMake((float)((int)xx),(float)((int) yy), ww,hh);
	//CGRect clippedRect = CGRectMake(xx, yy, 640 - xx * 2, 960 - yy * 2);
	//containerImage = [self imageByCropping:containerImage toRect:clippedRect];
	
	//UIGraphicsBeginImageContext(newSize.size);
	//[containerImage drawInRect:newSize];
	
	//CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	//CGContextClipToRect( currentContext, clippedRect);
	//containerImage = UIGraphicsGetImageFromCurrentImageContext();
	
	//pop the context to get back to the default
	//UIGraphicsEndImageContext();
	
	CGImageRef imageRef = CGImageCreateWithImageInRect([containerImage CGImage], clippedRect);
    containerImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
	
	CGRect newSize = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	UIGraphicsBeginImageContext(newSize.size);
	[containerImage drawInRect:newSize];
	containerImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	//create a rect equivalent to the full size of the image
	//offset the rect by the X and Y we want to start the crop
	//from in order to cut off anything before them
	//CGRect drawRect = CGRectMake(rect.origin.x * -1,
	//							 rect.origin.y * -1,
	//							 640,
	//							 imageToCrop.size.height);
	
	//draw the image to our clipped context using our offset rect
	//CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
	
	//pull the image from our cropped context
	//containerImage = UIGraphicsGetImageFromCurrentImageContext();
	
	//pop the context to get back to the default
	//UIGraphicsEndImageContext();
	
	
	
	
	
	
	//newSize = CGRectMake(0, 0, 640, 960);
	//UIGraphicsBeginImageContext(newSize.size);
	//[containerImage drawInRect:newSize];
	//containerImage = UIGraphicsGetImageFromCurrentImageContext();
	//UIGraphicsEndImageContext();
	
	//NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	UIImage *effectImage = appDelegate.theEffectImage;
	
	UIGraphicsBeginImageContext(containerImage.size);
	
	[containerImage drawAtPoint:CGPointMake(0, 0)];
	[effectImage drawAtPoint:CGPointMake(0, 0)];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	appDelegate.finalImage = newImage;
	return appDelegate.finalImage;
}
-(void)setImage:(UIImage*) imageEffect withBack:(UIImage*) backgroundImage
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theBackGroundImage = backgroundImage;
	appDelegate.theEffectImage = imageEffect;
	appDelegate.theBackGroundFrame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	
}
-(IBAction)nextButtonPressed:(id)sender
{

	if([cellArray count] -1 == imageIndex) return;
	if(isprocessing) return;
	isprocessing = YES;
	imageIndex = imageIndex+1;
	
	
	theEffectImageViewForAnimation.image = [UIImage imageNamed:[cellArray objectAtIndex:imageIndex]];
	theEffectImageViewForAnimation.frame = CGRectMake(d_width, -(i_height-d_height)/2, d_width, i_height );
	
	
	CABasicAnimation *theAnimation; 
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"]; 
// dss ///	
	theAnimation.duration=ANIMATION_DURATION;
// dss ^ //	
	//theAnimation.autoreverses=YES; 
	theAnimation.fromValue=[NSNumber numberWithFloat:0]; 
	theAnimation.toValue=[NSNumber numberWithFloat:-d_width]; 
	[theEffectImageView.layer addAnimation:theAnimation forKey:@"animateLayer"];
	[theEffectImageViewForAnimation.layer addAnimation:theAnimation forKey:@"animateLayer"];
	
	[self performSelector:@selector(donext) withObject:nil afterDelay:ANIMATION_DURATION];
}
-(void)donext
{
	NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	
	//NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	//NSLog(@"%@",imagePath);
	
		
	
	theEffectImageView.image = [UIImage imageNamed:imagePath];
	appDelegate.theEffectImage = [UIImage imageNamed:imagePath];
	
	isprocessing = NO;
	//thebackGroundImageViewForAnimation.frame = CGRectMake(320.0, 0.0, d_width, d_height );
	//appDelegate.theBackGroundFrame = CGRectMake(0.0, 0.0, d_width, d_height );
	//thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
}

-(IBAction)arevButtonPressed:(id)sender
{
	if(0 == imageIndex) return; 
	if(isprocessing) return;
	isprocessing = YES;
	imageIndex = imageIndex - 1;
	theEffectImageViewForAnimation.image = [UIImage imageNamed:[cellArray objectAtIndex:imageIndex]];
	theEffectImageViewForAnimation.frame = CGRectMake(-d_width, -(i_height-d_height)/2, d_width, i_height );
	
	
	CABasicAnimation *theAnimation; 
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"]; 
// dss ///	
	theAnimation.duration=ANIMATION_DURATION;
// dss ^ //	
	//theAnimation.autoreverses=YES; 
	theAnimation.fromValue=[NSNumber numberWithFloat:0]; 
	theAnimation.toValue=[NSNumber numberWithFloat:d_width]; 
	[theEffectImageView.layer addAnimation:theAnimation forKey:@"animateLayer"];
	[theEffectImageViewForAnimation.layer addAnimation:theAnimation forKey:@"animateLayer"];
	
	[self performSelector:@selector(donext) withObject:nil afterDelay:ANIMATION_DURATION];
}

-(IBAction)diceButtonPressed:(id)sender
{
#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Grid Button pressed");
	[Flurry logEvent:@"Grid Button pressed"];
#endif
	theIconImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	if(appDelegate.isGridShown)
	{
		appDelegate.isGridShown = NO;
		theIconImageView.hidden = YES;
	}else {
		theIconImageView.hidden = NO;
		appDelegate.isGridShown = YES;
	}
	
}

-(IBAction)actionButtonPressed:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"selectAction"];
	self.tabBarController.selectedIndex = 2;
	return;
	UIImage *containerImage = [UIImage imageNamed:appDelegate.theBackGroundImagePath];
	CGRect newSize = CGRectMake(0, 0, d_width, d_height );
	UIGraphicsBeginImageContext(newSize.size);
	[containerImage drawInRect:newSize];
	containerImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	UIImage *effectImage = [UIImage imageNamed:imagePath];
	
	UIGraphicsBeginImageContext(containerImage.size);
	
	[containerImage drawAtPoint:CGPointMake(0, 0)];
	[effectImage drawAtPoint:CGPointMake(0, 0)];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
	
	 UIAlertView *theAlert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Image saved to gallery" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	 [theAlert show];
	 [theAlert release];
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

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	isprocessing = NO;
	NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep2"];
	if([str isEqualToString:@"1"])
	{

		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isResetForStep2"];

		[self.navigationController popViewControllerAnimated:NO];
	}
	
	//NSString *imagePath = [cellArray objectAtIndex:0];
	//NSLog(@"%@",imagePath);
	if(appDelegate.isEffectLoaded)
		theEffectImageView.image = appDelegate.theEffectImage;
	
	//theIconImageView.image = [UIImage imageNamed:@"iconBackground.png"];
	
	//theIconImageView.hidden = !appDelegate.isGridShown;
	thebackGroundImageView.frame = appDelegate.theBackGroundFrame;
	thebackGroundImageView.image = appDelegate.theBackGroundImage;//[UIImage imageNamed:	appDelegate.theBackGroundImagePath];
	
// dss //
//	wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
//	[theAppDelegate moveTheAdAbove2Tabbars];
// dss ^ //

#ifdef FLURRY_APPLICATION_KEY
	NSString *theString = [NSString stringWithFormat:@"Step2: in Effect section %d", section];
	NSLog(@"  -  Flurry: %@", theString );
	[Flurry logEvent:@"Step2: in Effect section %d"];
#endif
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSBundle *bundle = [NSBundle mainBundle]; 
	pathForRes = [bundle bundlePath];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	appDelegate.isResetForStep2 = NO;
	appDelegate = [[UIApplication sharedApplication]delegate];
	NSString *Path = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"effectList"]];
	//NSLog([NSString stringWithFormat:@"data%@.plist",appdelegate.pageNo]);
	
	NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:filePath];
	
	int msect = section;
	if(msect >= 1000) section = section - 1000;
	
	cellArray = [tempArray objectAtIndex:section];
	
	cellArray = [cellArray objectAtIndex:1];
	
	imageIndex = 0;
	NSString *imagePath = [cellArray objectAtIndex:0];
	//NSLog(@"%@",imagePath);
	theEffectImageView.image = [UIImage imageNamed:imagePath];
	appDelegate.theEffectImage = [UIImage imageNamed:imagePath];
	theIconImageView.image = [UIImage imageNamed:@"iconBackground.png"];
	
	theIconImageView.hidden = !appDelegate.isGridShown;
	thebackGroundImageView.frame = appDelegate.theBackGroundFrame;
	thebackGroundImageView.image = appDelegate.theBackGroundImage;//[UIImage imageNamed:	appDelegate.theBackGroundImagePath];

	//NSLog(@"%f %f %f %f",thebackGroundImageView.frame.origin.x,thebackGroundImageView.frame.origin.y,thebackGroundImageView.frame.size.width,thebackGroundImageView.frame.size.height);
	thebackGroundImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	theEffectImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	theIconImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	UIBarButtonItem *randomButton = [[UIBarButtonItem alloc]init];//WithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(randomButton_Clicked)];
	randomButton.action = @selector(gotoFirstScreen);
	randomButton.target = self;
	randomButton.style = UIBarButtonItemStylePlain;
	randomButton.image = [UIImage imageNamed:@"refresh.png"];
	self.navigationItem.rightBarButtonItem = randomButton;
	
	//self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyle;
	
	[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
	appDelegate.isEffectLoaded = YES;
	//if(msect >= 1000) [self randomButton_Clicked];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep1"];
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep2"];
		
		appDelegate.theEffectImage = nil;
		appDelegate.theBackGroundImage = [UIImage imageNamed:@"black.jpg"];
		
		//appDelegate.isResetForStep1 = YES;
		//appDelegate.isResetForStep2 = YES;
		//[self.navigationController popViewControllerAnimated:NO];
		//self.tabBarController.
		self.tabBarController.selectedIndex = 0;
		//self.tabBarController.selectedIndex = 0;
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
-(void)isLoadedAction
{
	appDelegate.isEffectLoaded = NO;
}
-(void)isLoadedActionTotal
{
	appDelegate.isEffectLoaded = YES;
	appDelegate.isBackLoaded = YES;
}
-(void)theSelector
{
	theEffectImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	theIconImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
}
-(IBAction)randomButton_Clicked
{
#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Randomize Button pressed");
	[Flurry logEvent:@"Randomize Button pressed"];
#endif
	[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"selectRandom"];
	self.tabBarController.selectedIndex = 2;
	//thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	//imageIndex = random() % [cellArray count];

	//NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	//NSLog(@"%@",imagePath);
	//theEffectImageView.image = [UIImage imageNamed:imagePath];
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	
    //CGPoint pt;
    NSSet *allTouches = [event allTouches];
	
	
	 if([allTouches count] == 1)
	{
		UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
	    prevTouchPoint = [touch locationInView:[self view]];
	}
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
		
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	NSSet *allTouches = [event allTouches];
	CGPoint pt;
	if([allTouches count] == 1)
	{
		UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
	    pt = [touch locationInView:[self view]];
		
		float dist = prevTouchPoint.x - pt.x;
		//NSLog(@"%f",dist);
		if(dist > 40)
		{
			[self nextButtonPressed:nil];
		}
		else if(dist < - 40){
			[self arevButtonPressed:nil];
		}
		
	}
	
}


- (void)dealloc {
	[cellArray release];
    [super dealloc];
}


@end
