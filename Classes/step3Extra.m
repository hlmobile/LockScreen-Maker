//
//  step3Extra.m
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 9/1/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import "step3Extra.h"
#import "wallPaperAppDelegate.h"
#import "general.h"

@implementation step3Extra
-(void)isLoadedActionTotal
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.isEffectLoaded = YES;
	appDelegate.isBackLoaded = YES;
}
-(void)setImage:(UIImage*) imageEffect withBack:(UIImage*) backgroundImage
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theBackGroundImage = backgroundImage;
	appDelegate.theEffectImage = imageEffect;
	appDelegate.theBackGroundFrame = CGRectMake(0.0, 0.0, d_width, d_height );
}
-(void)reset
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theBackGroundFrame = CGRectMake(0.0, 0.0, d_width, d_height );
	appDelegate.theBackGroundImage = [UIImage imageNamed:@"black.jpg"];
	appDelegate.theEffectImage = nil;
}
-(CGRect)getBackgroundFrame
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theBackGroundFrame;
}
-(UIImage*)getBackgroundImage
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theBackGroundImage;
}
-(UIImage*)getEffectImage
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	return appDelegate.theEffectImage;
}
-(void)setBackgroundImage
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theBackGroundImage = nil;
}
-(void)setEffectImage
{
	wallPaperAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	appDelegate.theEffectImage = nil;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
