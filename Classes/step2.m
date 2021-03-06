//
//  step2.m
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import "step2.h"
#import "step2ImageView.h"
#import "Flurry.h"
#import "general.h"

@implementation step2

@synthesize dataArray;
@synthesize imageArray;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title = @"Choose Your Effect";
	self.navigationController.title = @"Effect";
	step2ImageView *theNextView = [[step2ImageView alloc]init];
	NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep2"];
	if([str isEqualToString:@"1"])
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isResetForStep2"];
		[theNextView reset];
	}
	
	
	theImageView.image = [theNextView theEffectImage];
	theImageView2.image = [theNextView theBackGroundImage];
	CGRect backFrame = [theNextView theBackGroundFrame];
///	NSLog(@"%f %f %f %f",backFrame.origin.x,backFrame.origin.x,backFrame.size.width,backFrame.size.height);
	theImageView2.frame = backFrame;
	theImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	//theImageView2.frame = [theNextView theBackGroundFrame];
	[theNextView release];
	
// dss //
//	wallPaperAppDelegate *theAppDelegate = [[UIApplication sharedApplication]delegate];
//	[theAppDelegate moveTheAdAbove1Tabbar];
// dss ^ //

#ifdef FLURRY_APPLICATION_KEY
	NSLog(@"  -  Flurry: Step2: Pick Effect");
	[Flurry logEvent:@"Step2: Pick Effect"];
#endif
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	theTableView.backgroundColor = [UIColor clearColor];
	NSString *Path = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"effectList"]];
	//NSLog([NSString stringWithFormat:@"data%@.plist",appdelegate.pageNo]);
	
	NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:filePath];
	NSMutableArray *onno = [[NSMutableArray alloc] init];
	imageArray = [[NSMutableArray alloc] init];
	for(int i = 0; i < [tempArray count];i++)
	{
		NSArray *temp2  = [tempArray objectAtIndex:i];
		NSString *stringData = [[NSString alloc]init];
		stringData = [NSString stringWithFormat:@"%@",[temp2 objectAtIndex:0]];//,[temp2 objectAtIndex:2]];
		
		NSString *imagePathFromResource = [temp2 objectAtIndex:2];
		NSArray *imArray = [imagePathFromResource componentsSeparatedByString:@"."];
		
		NSString *imagePath;
		NSBundle *bundle = [NSBundle mainBundle]; 
		NSString *path = [bundle bundlePath];
		imagePath = [NSBundle 
					 pathForResource:[imArray objectAtIndex:0] 
					 ofType:[imArray objectAtIndex:1] 
					 inDirectory:path];
		
		UIImage *containerImage = [UIImage imageWithContentsOfFile:imagePath];
		
		//CGRect newSize = CGRectMake(0.0, 0.0, 48.0, 48.0);
		//UIGraphicsBeginImageContext(newSize.size);
		//[containerImage drawInRect:newSize];
		//containerImage = UIGraphicsGetImageFromCurrentImageContext();
		//UIGraphicsEndImageContext();
		[imageArray addObject:containerImage];
		
		
		
		[onno addObject:stringData];
		//[temp2 release];
		[stringData release];
	}
	[tempArray release];
	//[dataArray retain];
	
	dataArray = [[NSMutableArray alloc] initWithArray:onno];
	//if([dataArray retainCount] < 1)
	//[dataArray retain];
	//self.title = @"Pick Back Ground";
	//UIBarButtonItem *randomButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(randomButton_Clicked)];
	//self.navigationItem.rightBarButtonItem = randomButton;
	
	
	//self.title = @"Pick Back Ground";
	//UIBarButtonItem *randomButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(randomButton_Clicked)];
	//self.navigationItem.rightBarButtonItem = randomButton;
	
	UIBarButtonItem *randomButton = [[UIBarButtonItem alloc]init];//WithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(randomButton_Clicked)];
	randomButton.action = @selector(gotoFirstScreen);
	randomButton.target = self;
	randomButton.style = UIBarButtonItemStylePlain;
	randomButton.image = [UIImage imageNamed:@"refresh.png"];
	self.navigationItem.rightBarButtonItem = randomButton;
	
	//[self performSelector:@selector(theSelector) withObject:self afterDelay:.1];
}
-(void)theSelector
{
	theImageView.frame = CGRectMake(0.0, 0.0, d_width, d_height );
	theImageView2.frame = CGRectMake(0.0, 0.0, d_width, d_height );
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep1"];
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isResetForStep2"];
		
		step2ImageView *theNextView = [[step2ImageView alloc]init];
		NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"isResetForStep2"];
		if([str isEqualToString:@"1"])
		{
			[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isResetForStep2"];
			[theNextView reset];
		}
		
		
		theImageView.image = [theNextView theEffectImage];
		theImageView2.image = [theNextView theBackGroundImage];
		theImageView2.frame = [theNextView theBackGroundFrame];
		
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


-(void)randomButton_Clicked
{
	
	
	step2ImageView *theNextView = [[step2ImageView alloc]initWithNibName:@"step2ImageView" bundle:[NSBundle mainBundle]];
	theNextView.section = random() % [dataArray count] + 1000;
	while(theNextView.section == 0) theNextView.section = random() % [dataArray count] + 1000;
	[self.navigationController pushViewController:theNextView animated:YES];
	[theNextView release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return [dataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	//NSLog(@"%d",[tempArray count]);
	return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
	//NSLog([NSString stringWithFormat:@"%d %d",indexPath.section,indexPath.row]);
    static NSString *CellIdentifier = @"Cell";     	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	//indexPathTemp = indexPath;
	
	if (cell == nil) {
		cell = [self tableviewCellWithReuseIdentifier: CellIdentifier withIndexPath:indexPath];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}    
	[cell setBackgroundColor:[UIColor colorWithRed:.17 green:.32 blue:.42 alpha:1]];
	[self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	int section = indexPath.section;
    step2ImageView *theNextView;
	//if(section == 0)
	//{
		//select photo from library
		
	//}else
	{
        if (d_height ==568) {
            theNextView = [[step2ImageView alloc]initWithNibName:@"step2ImageView@2x" bundle:[NSBundle mainBundle]];
        } else {
            theNextView = [[step2ImageView alloc]initWithNibName:@"step2ImageView" bundle:[NSBundle mainBundle]];
        }
		theNextView.section = section;
		[theNextView isLoadedAction];
		
		self.title = @"Back";
		self.navigationController.title = @"Effect";
		
		[self.navigationController pushViewController:theNextView animated:YES];
		
		[theNextView release];
	}
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return YES;
}
/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) 
 { 
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) 
 {
 
 }   
 }
 */

/*
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
 {
 
 }
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60.0f;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//return 0;
//	return 0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{


//	return 0;
//}
/*
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath { 
 return YES;18
 }
 */

#pragma mark table methods custom
- (UITableViewCell *)tableviewCellWithReuseIdentifier:(NSString *)identifier withIndexPath:(NSIndexPath *)indexPath
{
	//NSLog(@"%d - %d",indexPath.row,indexPath.section);
	UILabel *label;
	UIImageView *imageView;
	
	
	CGRect rect;	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:rect reuseIdentifier:identifier] autorelease];
	//NSIndexPath *indexPath = indexPathTemp;
	//NSLog([NSString stringWithFormat:@"index path %d %d",indexPath.section,indexPath.row]);
	
	
	
	rect=CGRectMake(70, 0, 200, 60);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = 1;
	label.font = [UIFont boldSystemFontOfSize:17];
	label.backgroundColor = [UIColor clearColor];
	//label.textAlignment = UITextAlignmentRight;		
	[cell.contentView addSubview:label];
	label.textColor = [UIColor whiteColor];
	label.highlightedTextColor = [UIColor whiteColor];
	[label release];
	
	rect=CGRectMake(5, 5, 50, 50);
	imageView = [[UIImageView alloc] initWithFrame:rect];
	imageView.tag = 2;
	[cell.contentView addSubview:imageView];
	[imageView release];
	
	
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
	
	NSArray *cellArray = [(NSString*)[dataArray objectAtIndex:indexPath.section] 
						  componentsSeparatedByString:@"<>"];
	
	UILabel *label;
	
	label = (UILabel *)[cell viewWithTag:1];
	label.text = [cellArray objectAtIndex:0];
	
	//NSLog(@"hello        %@",[cellArray objectAtIndex:0]);
	
	UIImageView *imageView;
	
	imageView = (UIImageView *) [cell viewWithTag:2];
	imageView.image = (UIImage*)[imageArray objectAtIndex:indexPath.section];
	//cellArray = [cellArray objectAtIndex:1];
	//NSLog(@"%@",cellArray);
	//NSString *imagePath = [cellArray objectAtIndex:1];
	//NSString *imagePath;
	//NSBundle *bundle = [NSBundle mainBundle]; 
	//NSString *path = [bundle bundlePath];
	//imagePath = [NSBundle pathForResource:[cellArray objectAtIndex:1] ofType:@"png" inDirectory:path];
	
	//imageView.image = (UIImage*)[imageArray objectAtIndex:indexPath.section];// imageWithContentsOfFile:[];
	
	//while ([cellArray retainCount] != 0) {
	//	[cellArray release];
	//}
	//[cellArray release];
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"cloud1" ofType:@".png"];
	//imageView.image =[UIImage imageWithContentsOfFile:path];
	//NSLog(@"%@",imagePath);	
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
