    //
//  step1ImageView.m
//  wallPaper
//
//  Created by Tithy on 8/27/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import "step1ImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "Flurry.h"
#import "general.h"

CGAffineTransform orientationTransformForImage(UIImage *image, CGSize *newSize) {
    CGImageRef img = [image CGImage];
    CGFloat width = CGImageGetWidth(img);
    CGFloat height = CGImageGetHeight(img);
    CGSize size = CGSizeMake(width, height);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGFloat origHeight = size.height;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) { /* EXIF 1 to 8 */
        case UIImageOrientationUp:
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(width, 0.0f);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0f, height);
            transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
            break;
        case UIImageOrientationLeftMirrored:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
            transform = CGAffineTransformRotate(transform, 3.0f * M_PI / 2.0f);
            break;
        case UIImageOrientationLeft:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeTranslation(0.0f, width);
            transform = CGAffineTransformRotate(transform, 3.0f * M_PI / 2.0f);
            break;
        case UIImageOrientationRightMirrored:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeScale(-1.0f, 1.0f);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0f);
            break;
        case UIImageOrientationRight:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0f);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0f);
            break;
        default:
            ;
    }
    *newSize = size;
    return transform;
}

UIImage *rotateImage(UIImage *image) {
    CGImageRef img = [image CGImage];
    CGFloat width = CGImageGetWidth(img);
    CGFloat height = CGImageGetHeight(img);
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGSize size = bounds.size;
	CGFloat scale = size.width/width;
    CGAffineTransform transform = orientationTransformForImage(image, &size);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    /* Flip */
    UIImageOrientation orientation = [image imageOrientation];
    if (orientation == UIImageOrientationRight || orientation == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scale, scale);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scale, -scale);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(context, bounds, img);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@implementation step1ImageView
@synthesize section;
@synthesize cellArray;
@synthesize imageIndex;
@synthesize isShow;
@synthesize prevTouchPoint;
@synthesize prevDistance;
@synthesize pathForRes;
@synthesize animationImage1;
@synthesize animationImage2;
@synthesize isprocessing;
- (UIImage *)cropImage:(UIImage *)image to:(CGRect)cropRect{
	//CGFloat virtualScale = cropRect.size.width / 320.0f;
	image = rotateImage(image);	
	CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    UIImage *theNewImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
	
    return theNewImage;
}
-(UIImage*)getImageFromResources:(NSString*)imageName
{
	NSArray *theArr = [imageName componentsSeparatedByString:@"."];
    NSBundle *bundle = [NSBundle mainBundle]; 
	pathForRes = [bundle bundlePath];
	NSString *imagePath = [NSBundle pathForResource:[theArr objectAtIndex:0] ofType:[theArr objectAtIndex:1] inDirectory:pathForRes];
	return [UIImage imageWithContentsOfFile:imagePath];
}
-(void)reset
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theBackGroundFrame = CGRectMake(0.0, 0.0, d_width, i_height );
	appDelegate.theBackGroundImage = [UIImage imageNamed:@"black.jpg"];
	appDelegate.theEffectImage = nil;
}
-(UIImage*)theBackGroundImage
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theBackGroundImage;
}
-(CGRect)theBackGroundFrame
{
	appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theBackGroundFrame;
}
/*

-(IBAction)nextButtonPressed:(id)sender
{
	NSLog(@"2");
	if(section == 0) return;
		//NSLog(@"Pressed");
	if([cellArray count] -1 == imageIndex) return; 
		
	
	thebackGroundImageViewForAnimation.hidden = NO;
	//thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	imageIndex = imageIndex+1;
	NSLog(@"%d",imageIndex);
	thebackGroundImageViewForAnimation.image = [self getImageFromResources:[cellArray objectAtIndex:imageIndex]];// [UIImage imageNamed:[cellArray objectAtIndex:imageIndex]];
	thebackGroundImageViewForAnimation.frame = CGRectMake(320.0, 0.0, d_width, d_height );

	
	CABasicAnimation *theAnimation; 
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"]; 
	theAnimation.duration=.5; 
	theAnimation.delegate = self;
	//theAnimation.autoreverses=YES; 
	theAnimation.fromValue=[NSNumber numberWithFloat:0]; 
	theAnimation.toValue=[NSNumber numberWithFloat:-320]; 
	//[thebackGroundImageView.layer addAnimation:theAnimation forKey:@"animateLayer"];
	[thebackGroundImageViewForAnimation.layer addAnimation:theAnimation forKey:@"animateLayer"];

	//[self performSelector:@selector(donext) withObject:nil afterDelay:.45];
	NSLog(@"22");
	//NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	
	//thebackGroundImageView.image = [UIImage imageNamed:imagePath];
	
	
	//appDelegate.theBackGroundImage = [UIImage imageNamed:imagePath];
	//appDelegate.theBackGroundImagePath = imagePath;
}



-(void)donext
{
	thebackGroundImageViewForAnimation.hidden = YES;
	NSLog(@"111");
	NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	
	
	//theEffectImageView.image = [UIImage imageNamed:imagePath];
	//appDelegate.theEffectImage = [UIImage imageNamed:imagePath];
	
	thebackGroundImageView.image = [self getImageFromResources:imagePath];// [UIImage imageNamed:imagePath];
	
	
	appDelegate.theBackGroundImage = [self getImageFromResources:imagePath];// [UIImage imageNamed:imagePath];
	appDelegate.theBackGroundImagePath = imagePath;
	
	//thebackGroundImageViewForAnimation.frame = CGRectMake(320.0, 0.0, d_width, d_height );
	//thebackGroundImageViewForAnimation.hidden = YES;
	appDelegate.theBackGroundFrame = CGRectMake(0.0, 0.0, d_width, d_height );
	//thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	NSLog(@"1111");
}
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	[self donext];
	
}
-(IBAction)arevButtonPressed:(id)sender
{
			thebackGroundImageViewForAnimation.hidden = NO;
	NSLog(@"1");
	if(section == 0) return;
	if(imageIndex == 0) return; 
	imageIndex = imageIndex - 1;
	thebackGroundImageViewForAnimation.image = [self getImageFromResources:[cellArray objectAtIndex:imageIndex]];// [UIImage imageNamed:[cellArray objectAtIndex:imageIndex]];
	thebackGroundImageViewForAnimation.frame = CGRectMake(-320.0, 0.0, d_width, d_height );
	
	
	CABasicAnimation *theAnimation; 
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"]; 
	theAnimation.duration=.5; 
	//theAnimation.autoreverses=YES;
	//[theAnimation setan
	theAnimation.delegate = self;
	theAnimation.fromValue=[NSNumber numberWithFloat:0]; 
	theAnimation.toValue=[NSNumber numberWithFloat:320]; 
	//[thebackGroundImageView.layer addAnimation:theAnimation forKey:@"animateLayer"];
	[thebackGroundImageViewForAnimation.layer addAnimation:theAnimation forKey:@"animateLayer"];
	
	//[self performSelector:@selector(donext) withObject:nil afterDelay:.45];
	NSLog(@"11");
	
}
 */
-(IBAction)nextButtonPressed:(id)sender
{
	if(isprocessing) return;
	if(section == 0) return;
	//NSLog(@"Pressed");
	if([cellArray count] -1 == imageIndex) return; 
	isprocessing = YES;
	//thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	imageIndex = imageIndex+1;
		
	animationImage1 = [self getImageFromResources:[cellArray objectAtIndex:imageIndex]];
	//animationImage2 = [self getImageFromResources:[cellArray objectAtIndex:imageIndex]];
    //i_height = animationImage1.size.height/2;
    //i_width = animationImage1.size.width/2;
    thebackGroundImageViewForAnimation.hidden = NO;
	thebackGroundImageViewForAnimation.image = animationImage1;
	thebackGroundImageViewForAnimation.frame = CGRectMake(d_width, -(i_height-d_height)/2, d_width, i_height );

	CABasicAnimation *theAnimation; 
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
// dss ///	
	theAnimation.duration=ANIMATION_DURATION;
// dss ^ //	
	theAnimation.delegate = self;
	//theAnimation.autoreverses=YES; 
	theAnimation.fromValue=[NSNumber numberWithFloat:0]; 
	theAnimation.toValue=[NSNumber numberWithFloat:-d_width]; 
	[thebackGroundImageView.layer addAnimation:theAnimation forKey:@"animateLayer"];
	[thebackGroundImageViewForAnimation.layer addAnimation:theAnimation forKey:@"animateLayer"];
	
// dss ///	
	[self performSelector:@selector(donext) withObject:nil afterDelay:ANIMATION_DURATION];
// dss ^ //	
	//NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	
	//thebackGroundImageView.image = [UIImage imageNamed:imagePath];
	
	
	//appDelegate.theBackGroundImage = [UIImage imageNamed:imagePath];
	//appDelegate.theBackGroundImagePath = imagePath;

}
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{

	//NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	thebackGroundImageViewForAnimation.hidden = YES;
	
	
	
	appDelegate.theBackGroundImage = animationImage1;
	//appDelegate.theBackGroundImagePath = imagePath;
	
	thebackGroundImageViewForAnimation.frame = CGRectMake(d_width, -(i_height-d_height)/2, d_width, i_height );
	appDelegate.theBackGroundFrame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	thebackGroundImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	isprocessing = NO;
}
-(void)donext
{
	thebackGroundImageView.image = animationImage1;
}
-(IBAction)arevButtonPressed:(id)sender
{
	if(section == 0) return;
	if(imageIndex == 0) return; 
	if(isprocessing) return;
	isprocessing = YES;
	imageIndex = imageIndex - 1;
	animationImage1 = [self getImageFromResources:[cellArray objectAtIndex:imageIndex]];
	//animationImage2 = [self getImageFromResources:[cellArray objectAtIndex:imageIndex]];
	
	thebackGroundImageViewForAnimation.image = animationImage1;
	thebackGroundImageViewForAnimation.hidden = NO;
	thebackGroundImageViewForAnimation.frame = CGRectMake(-d_width, -(i_height-d_height)/2, d_width, i_height );
	
	
	CABasicAnimation *theAnimation; 
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"]; 
// dss ///	
	theAnimation.duration=ANIMATION_DURATION;
// dss ^ //	
	//theAnimation.autoreverses=YES; 
	theAnimation.delegate = self;
	theAnimation.fromValue=[NSNumber numberWithFloat:0]; 
	theAnimation.toValue=[NSNumber numberWithFloat:d_width]; 
	[thebackGroundImageView.layer addAnimation:theAnimation forKey:@"animateLayer"];
	[thebackGroundImageViewForAnimation.layer addAnimation:theAnimation forKey:@"animateLayer"];
	
// dss ///	
	[self performSelector:@selector(donext) withObject:nil afterDelay:ANIMATION_DURATION];
// dss ^ //	
}

-(IBAction)diceButtonPressed:(id)sender
{
#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Grid Button pressed");
	[Flurry logEvent:@"Grid Button pressed"];
#endif
	theIconImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	if(isShow)
	{
		isShow = NO;
		appDelegate.isGridShown = NO;
		theIconImageView.hidden = YES;
	}else {
		theIconImageView.hidden = NO;
		appDelegate.isGridShown = YES;
		isShow = YES;
	}
}
-(IBAction)actionButtonPressed:(id)sender
{	
	[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"selectAction"];
	self.tabBarController.selectedIndex = 2;
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
-(void)imagePickerController:(UIImagePickerController *)picker
	   didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
	//HairCutV3AppDelegate *appDelegate = (HairCutV3AppDelegate *)[[UIApplication sharedApplication]delegate];
	[picker dismissModalViewControllerAnimated:YES];
	[picker dismissModalViewControllerAnimated:YES];
	//NSLog(@"image have been choosed");
	//[imageViewer setBackgroundImage:image forState:UIControlStateNormal];
	//[UIImage imageOrientation]
	if([image imageOrientation] == UIInterfaceOrientationPortrait)
	{
		NSLog(@"Portration");
	}else {
		NSLog(@"Landscape");
	}

	//image.size
	image = [self getCamImage:image];
	//CGRect newSize = CGRectMake(0, 0, 640.0f, 960.0f);  
	//UIGraphicsBeginImageContext(newSize.size);        
	//[image drawInRect:newSize];
	
	//UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();  
	//UIGraphicsEndImageContext();  
	
	//
	thebackGroundImageView.image = [image retain];  
	appDelegate.theBackGroundImage = image;
	appDelegate.theBackGroundFrame = thebackGroundImageView.frame;
	[image release];
	
	//
	
	
	//imageView = [[UIImageView alloc] initWithImage:image];
	//imageView.image=[image _imageScaledToSize:CGSizeMake() interpolationQuality:1];
}
-(IBAction) camAction:(id)sender
{
	if([UIImagePickerController isSourceTypeAvailable:
		UIImagePickerControllerSourceTypePhotoLibrary]){
		UIImagePickerController *picker=[[UIImagePickerController alloc] init];
		picker.delegate=self;
		picker.sourceType=UIImagePickerControllerSourceTypeCamera;
		picker.allowsImageEditing = YES;
		picker.editing=YES;
		[self presentModalViewController:picker animated:YES];		
		[picker release];
	}
}
-(IBAction) libraryAction:(id)sender
{
// dss //
	wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
    //324rsj
	[theAppDelegate hideTheAdLabel];
// dss ^ //
	if([UIImagePickerController isSourceTypeAvailable:
		UIImagePickerControllerSourceTypePhotoLibrary]){
		UIImagePickerController *picker=[[UIImagePickerController alloc] init];
		picker.delegate=self;
		picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
		picker.allowsImageEditing = YES;
		picker.editing=YES;
		[self presentModalViewController:picker animated:YES];		
		[picker release];
	}
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	isprocessing = NO;
	NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep1"];
	if([str isEqualToString:@"1"])
	{
		
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isResetForStep1"];
		
		[self.navigationController popViewControllerAnimated:NO];
	}
	
	thebackGroundImageViewForAnimation.frame = CGRectMake(d_width, -(i_height-d_height)/2, d_width, i_height );
	//NSString *imagePath = [cellArray objectAtIndex:0];
	//NSLog(@"%@",imagePath);
	if(appDelegate.isBackLoaded){
		thebackGroundImageView.image = appDelegate.theBackGroundImage;
		appDelegate.theBackGroundFrame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
		thebackGroundImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
		appDelegate.isBackLoaded = NO;
	}
	theIconImageView.image = [UIImage imageNamed:@"iconBackground.png"];
	
	//theIconImageView.hidden = !appDelegate.isGridShown;
	//thebackGroundImageView.frame = appDelegate.theBackGroundFrame;
	//thebackGroundImageView.image = appDelegate.theBackGroundImage;//[UIImage imageNamed:	appDelegate.theBackGroundImagePath];

// dss //	
	[appDelegate moveTheAdAbove2Tabbars];
// dss ^ //
	
#ifdef FLURRY_APPLICATION_KEY
	NSString *theString = [NSString stringWithFormat:@"Step1: in Background section %d", section];
	NSLog(@"  -  Flurry: %@", theString );
	[Flurry logEvent:@"at Step1: in Background section %d"];
#endif
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//NSString *imagePath;
	NSBundle *bundle = [NSBundle mainBundle]; 
	pathForRes = [bundle bundlePath];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	thebackGroundImageViewForAnimation.hidden = NO;
	appDelegate.isResetForStep1 = NO;
    //i_height = animationImage1.size.height/2;
    //i_width = animationImage1.size.width/2;
	appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theBackGroundFrame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	thebackGroundImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	theIconImageView.frame = CGRectMake(0.0, 0.0, d_width, i_height );
	if(section == 0)
	{
		[self libraryAction:nil];
		appDelegate.theBackGroundImagePath = @"no";
		
	}else {
		NSString *Path = [[NSBundle mainBundle] bundlePath];
		NSString *filePath = [Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"backgroundList"]];
		//NSLog([NSString stringWithFormat:@"data%@.plist",appdelegate.pageNo]);
		
		NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:filePath];
		int msect = section;
		if(msect >= 1000) section = section - 1000;
		cellArray = [tempArray objectAtIndex:section];
		
		cellArray = [cellArray objectAtIndex:1];
///		NSLog(@"%@",cellArray);
		imageIndex = 0;
		NSString *imagePath = [cellArray objectAtIndex:0];
		//NSLog(@"%@",imagePath);
		thebackGroundImageView.image = [self getImageFromResources:imagePath];//[UIImage imageNamed:imagePath];
		theIconImageView.image =[self getImageFromResources:@"iconBackground.png"];//  [UIImage imageNamed:@"iconBackground.png"];
		isShow = NO;
		appDelegate.isGridShown = NO;
		theIconImageView.hidden = YES;
		appDelegate.theBackGroundImagePath = imagePath;
		appDelegate.theBackGroundImage = [self getImageFromResources:imagePath];
		
		if(msect >= 1000) [self randomButton_Clicked];
	}

	thebackGroundImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
	//UIBarButtonItem *randomButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(randomButton_Clicked)];
	//self.navigationItem.rightBarButtonItem = randomButton;
	appDelegate.isBackLoaded = YES;
	[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
	
	UIBarButtonItem *randomButton = [[UIBarButtonItem alloc]init];//WithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(randomButton_Clicked)];
	randomButton.action = @selector(gotoFirstScreen);
	randomButton.target = self;
	randomButton.style = UIBarButtonItemStylePlain;
	randomButton.image = [UIImage imageNamed:@"refresh.png"];
	self.navigationItem.rightBarButtonItem = randomButton;
	
	//self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyle;
	
	//[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
	//appDelegate.isEffectLoaded = YES;
	//if(msect >= 1000) [self randomButton_Clicked];
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep1"];
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep2"];
		
		[self.navigationController popViewControllerAnimated:NO];
		
		appDelegate.theEffectImage = nil;
		appDelegate.theBackGroundImage = [UIImage imageNamed:@"black.jpg"];
		
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
	
	[self.navigationController popViewControllerAnimated:NO];
	
	//appDelegate.isResetForStep1 = YES;
	//appDelegate.isResetForStep2 = YES;
	//[self.navigationController popViewControllerAnimated:NO];
	//self.tabBarController.
	//self.tabBarController.selectedIndex = 0;
	//self.tabBarController.selectedIndex = 0;
}

-(void)isLoadedAction
{
	appDelegate.isBackLoaded = NO;
}
-(void)theSelector
{
	thebackGroundImageView.frame = CGRectMake(0.0, -(i_height-d_height)/2, d_width, i_height );
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
	
	//	if(section == 0) return;
	//thebackGroundImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	//imageIndex = random() % [cellArray count];
	//NSString *imagePath = [cellArray objectAtIndex:imageIndex];
	//NSLog(@"%@",imagePath);
	//thebackGroundImageView.image = [UIImage imageNamed:imagePath];
	//appDelegate.theBackGroundImage = [UIImage imageNamed:imagePath];
	//appDelegate.theBackGroundImagePath = imagePath;
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
	[cellArray release];
	[super dealloc];
}
- (float)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
	
	NSLog(@"%f %f %f %f",fromPoint.x,fromPoint.y,toPoint.x,toPoint.y);
	float x = toPoint.x - fromPoint.x;
	float y = toPoint.y - fromPoint.y;
	
	return sqrt(x * x + y * y);
}
- (UIImage*)imageByCropping:(UIImage *)imageToCrop 
{
	CGRect rect = CGRectMake((float)((int)0), (float)((int)0), (float)((int)160), (float)((int)240));

	UIImage *ccc = [self cropImage:imageToCrop to:rect];
	NSLog(@"%f %f ",ccc.size.width, ccc.size.height);
	return ccc;
	//create a context to do our clipping in
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	//create a rect with the size we want to crop the image to
	//the X and Y here are zero so we start at the beginning of our
	//newly created context
	CGRect clippedRect = CGRectMake(0, -(i_height-d_height)/2, rect.size.width, rect.size.height);
	CGContextClipToRect( currentContext, clippedRect);
	
	//create a rect equivalent to the full size of the image
	//offset the rect by the X and Y we want to start the crop
	//from in order to cut off anything before them
	CGRect drawRect = CGRectMake(rect.origin.x * -1,
								 rect.origin.y * -1,
								 imageToCrop.size.width,
								 imageToCrop.size.height);
	
	//draw the image to our clipped context using our offset rect
	CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
	
	//pull the image from our cropped context
	UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
	
	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	
	//Note: this is autoreleased
	return cropped;
}
-(UIImage*)getCamImage:(UIImage*)currentImage
{
	UIImage *containerImage = currentImage;
	
	
	containerImage = rotateImage(containerImage);	
	float width = containerImage.size.width;
	float height = containerImage.size.height;
	
	float ratio = height / width;
	float reqRatio = 3.0 / 2.0;
	float nextHeight = d_height ;
	float nextWidth = nextHeight * width / height;
	
	thebackGroundImageView.frame = CGRectMake(0, -(i_height-d_height)/2, nextWidth, nextHeight);
	
	return containerImage;
	
	
	//////////////
	/////
	//////////////
	
	//float width = containerImage.size.width;
	//float height = containerImage.size.height;
	NSLog(@"%f %f ",containerImage.size.width, containerImage.size.height);
	//float ratio = height / width;
	//float reqRatio = 3.0 / 2.0;
	float x = 0.0;
	float y = 0.0;
	
	NSLog(@"%f %f",ratio,reqRatio);
	if(ratio > reqRatio)
	{
		//
	
		//float vwidth = width;
		float vheight = width * 1.5;
		
		x = 0; y = (height - vheight ) / 2;
		height = vheight;
	}
	
	else
	{
		float vwidth = height / 1.5;
		//float vheight = height;
		
		y = 0; x = (width - vwidth ) / 2;
		width = vwidth;
	}
	
	NSLog(@"%f %f %f %f ",x, y, width, height);
	//CGRect clippedRect = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
	CGRect clippedRect = CGRectMake((float)((int)x), (float)((int)y), (float)((int)width), (float)((int)height));
	//NSLog(@"%f %f %f %f ",clippedRect.origin.x, clippedRect.origin.y, clippedRect.size.width,clippedRect.size.height);

	CGImageRef imageRef = CGImageCreateWithImageInRect([containerImage CGImage], clippedRect);
    UIImage *theNewImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
	
	NSLog(@"%f %f ",theNewImage.size.width, theNewImage.size.height);
	//thebackGroundImageView.image = theNewImage;
	
	CGRect newSize = CGRectMake(0, -(i_height-d_height)/2, d_width, i_height );
	UIGraphicsBeginImageContext(newSize.size);
	[theNewImage drawInRect:newSize];
	theNewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return theNewImage;
	
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	
    //CGPoint pt;
    NSSet *allTouches = [event allTouches];
	
	
	if([allTouches count] == 2)
	{
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
		float initialDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:[self view]]
													 toPoint:[touch2 locationInView:[self view]]];
		prevDistance = initialDistance;
		NSLog(@"touch 1 %f",prevDistance);
	}	
	else if([allTouches count] == 1)
	{
		UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
	    prevTouchPoint = [touch locationInView:[self view]];
	}
			
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//CGPoint pt;
	CGPoint pt;
	//UITouch *touchObj = [touches anyObject];
    NSSet *allTouches = [event allTouches];
	if([allTouches count] == 2)
	{
		NSLog(@"touch 2 %f",prevDistance);
		//if(prevDistance < 10) return;
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
		
		float currentDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:[self view]]
													   toPoint:[touch2 locationInView:[self view]]];
		//NSLog(@"----------%f %f",currentDistance,prevDistance);
		if(prevDistance < 3.0)
		{
			prevDistance = currentDistance;
		}
		NSLog(@"touch 22 %f",prevDistance);
		float newPrev= currentDistance;
		currentDistance = currentDistance - prevDistance;
		//NSLog(@"----%f %f",currentDistance,prevDistance);
		currentDistance =  currentDistance/ prevDistance;
		prevDistance = newPrev;
		//NSLog(@"%f",currentDistance);
		CGRect thebackGroundFrame = thebackGroundImageView.frame;
		
		float xxxx = thebackGroundFrame.origin.x - thebackGroundFrame.size.width * currentDistance / 2;
		//float yyyy =  thebackGroundFrame.origin.y - thebackGroundFrame.size.height * currentDistance / 2;
		float wdth = thebackGroundFrame.size.width + thebackGroundFrame.size.width * currentDistance;
		float hght = thebackGroundFrame.size.height + thebackGroundFrame.size.height * currentDistance;
		
		
		
		
		
		CGRect zoomedFrame = CGRectMake(xxxx,-(i_height-d_height)/2,wdth,hght);
		
		
	
		
		
		thebackGroundImageView.frame = zoomedFrame;
		appDelegate.theBackGroundFrame = thebackGroundImageView.frame;
		
		//NSLog(@"%f %f %f %f",thebackGroundImageView.frame.origin.x,thebackGroundImageView.frame.origin.y,thebackGroundImageView.frame.size.width,thebackGroundImageView.frame.size.height);
		
	}else if([allTouches count] == 1)
	{
		if(section == 0) 
		{
			UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			pt = [touch locationInView:[self view]];
			
			float distx = pt.x - prevTouchPoint.x;
			float disty = pt.y - prevTouchPoint.y;
			
			CGRect thebackGroundFrame = thebackGroundImageView.frame;
			float xxxx = thebackGroundFrame.origin.x + distx;
			//float yyyy = thebackGroundFrame.origin.y + disty;
			float wdth = thebackGroundFrame.size.width;
			float hght = thebackGroundFrame.size.height;
			
			
			//thebackGroundImageView.frame.origin.x = 
			//					thebackGroundImageView.frame.origin.x + ;
			
			
			
			
			CGRect translatedFrame =CGRectMake(xxxx,-(i_height-d_height)/2,wdth,hght);
			thebackGroundImageView.frame = translatedFrame;
			
			
			
			prevTouchPoint = pt;
			
		}else {
			UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			pt = [touch locationInView:[self view]];
			
			float dist = prevTouchPoint.x - pt.x;
			//NSLog(@"%f",dist);
			if(dist > 40)
			{
				//[self nextButtonPressed:nil];
			}
			else if(dist < - 40){
				//[self arevButtonPressed:nil];
			}
		}

		
		
	}	
	
			
			
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	CGRect thebackGroundFrame = thebackGroundImageView.frame;
	float xxxx = thebackGroundFrame.origin.x;
	float yyyy = thebackGroundFrame.origin.y;
	float wdth = thebackGroundFrame.size.width;
	float hght = thebackGroundFrame.size.height;
	
	
	if(hght < d_height )
	{
		wdth = wdth * (d_height  / hght);
		hght = d_height ;
	}
	
	
	//thebackGroundImageView.frame.origin.x = 
	//					thebackGroundImageView.frame.origin.x + ;
	
	if(xxxx  > 0) 
		xxxx = 0;
	
	if(xxxx  < -(wdth - d_width)) 
		xxxx = -(wdth - d_width);
	
	if(yyyy  > 0) 
		yyyy = 0;
	
	if(yyyy  < -(hght - d_height )) 
		yyyy = -(hght - d_height );
	
	
	CGRect translatedFrame =CGRectMake((float)((int)xxxx),-(i_height-d_height)/2,(float)((int)wdth),(float)((int)hght));
	thebackGroundImageView.frame = translatedFrame;
	appDelegate.theBackGroundFrame = translatedFrame;
	thebackGroundImageView.image = appDelegate.theBackGroundImage;
	
	
	
	prevDistance = 0;
	if(section == 0) return;
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



@end
