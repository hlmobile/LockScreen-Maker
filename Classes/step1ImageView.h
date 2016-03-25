//
//  step1ImageView.h
//  wallPaper
//
//  Created by Tithy on 8/27/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wallPaperAppDelegate.h"

@interface step1ImageView : UIViewController <UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>{
	IBOutlet UIImageView *thebackGroundImageView;
	IBOutlet UIImageView *thebackGroundImageViewForAnimation;
	IBOutlet UIImageView *theIconImageView;
	IBOutlet UIToolbar *theToolBar;
	int section;
	NSArray *cellArray;
	int imageIndex;
	BOOL isShow;
	wallPaperAppDelegate *appDelegate;
	CGPoint prevTouchPoint;
	float prevDistance;
	NSString* pathForRes;
	UIImage *animationImage1;
	UIImage *animationImage2;
	BOOL isprocessing;
}
-(void)reset;
-(CGRect)theBackGroundFrame;
-(UIImage*)theBackGroundImage;
- (UIImage*)imageByCropping:(UIImage *)imageToCrop;
-(UIImage*)getCamImage:(UIImage*)currentImage;
-(void)isLoadedAction;
-(void)randomButton_Clicked;
-(IBAction) camAction:(id)sender;
-(IBAction) libraryAction:(id)sender;
//-(IBAction) usePhoto_Clicked:(id)sender;
@property (nonatomic,retain)UIImage *animationImage1;
@property (nonatomic,retain)UIImage *animationImage2;
@property (nonatomic,retain)NSString* pathForRes;
@property (nonatomic)CGPoint prevTouchPoint;
@property (nonatomic) float prevDistance;
@property (nonatomic,retain)NSArray *cellArray;
@property (nonatomic) int section;
@property (nonatomic) BOOL isShow;
@property (nonatomic) BOOL isprocessing;
@property (nonatomic) int imageIndex;
-(IBAction)nextButtonPressed:(id)sender; 
-(IBAction)arevButtonPressed:(id)sender; 
-(IBAction)diceButtonPressed:(id)sender; 
-(IBAction)actionButtonPressed:(id)sender; 
-(IBAction)randomButton_Clicked;
- (float)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint ;
@end
