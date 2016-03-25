//
//  JKCustomAlert.m
//  CustomAlert
//
//  Created by Joris Kluivers on 4/2/09.
//  Copyright 2009 Tarento Software Solutions & Projects. All rights reserved.
//

#import "JKCustomAlert.h"


@implementation JKCustomAlert

@synthesize backgroundImage, alertText;

- (id) initWithImage:(UIImage *)image text:(NSString *)text xposition:(float)xpos yposition:(float)ypos direction:(NSString *)upordown
{
	if (self = [super init]) {
		CGSize imageSize = image.size;
		UIImage *crossImage=[UIImage imageNamed:@"cross.png"];
		if ([upordown isEqualToString:@"up"]){
			alertTextLabel = [[UITextView alloc] initWithFrame:CGRectMake(7, 30,imageSize.width-5, imageSize.height-35)];
			btnCross=[[UIButton alloc] initWithFrame:CGRectMake(imageSize.width-20, imageSize.height-20, 16, 16)];
		}
		if ([upordown isEqualToString:@"down"]) {
			alertTextLabel = [[UITextView alloc] initWithFrame:CGRectMake(7, 7,imageSize.width-5, imageSize.height-35)];
			btnCross=[[UIButton alloc] initWithFrame:CGRectMake(imageSize.width-22, 8, 16, 16)];
		}
		alertTextLabel.editable=NO;
		alertTextLabel.textColor = [UIColor whiteColor];
		alertTextLabel.backgroundColor = [UIColor clearColor];
		alertTextLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		[btnCross setBackgroundImage:crossImage forState:UIControlStateNormal];
		[btnCross addTarget:self action:@selector(crossTooltip:) forControlEvents:UIControlEventTouchUpInside];

		[self addSubview:alertTextLabel];
		[self addSubview:btnCross];
	
        self.backgroundImage = image;
		self.alertText = text;
		 CGAffineTransform myTr=CGAffineTransformMakeTranslation(xpos, ypos);
		[self setTransform:myTr];
    }
    return self;
}

-(IBAction)crossTooltip:(id)sender
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}
- (void) setAlertText:(NSString *)text {
	alertTextLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:14];
	alertTextLabel.text = text;
}

- (NSString *) alertText {
	return alertTextLabel.text;
}


- (void)drawRect:(CGRect)rect {
    //CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGSize imageSize = self.backgroundImage.size;
	//CGContextDrawImage(ctx, CGRectMake(0, 0, imageSize.width, imageSize.height), self.backgroundImage.CGImage);
	[self.backgroundImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
}

- (void) layoutSubviews {
	alertTextLabel.transform = CGAffineTransformIdentity;
	//CGSize imageSize = self.backgroundImage.size;
	[alertTextLabel sizeToFit];
	
	CGRect textRect = alertTextLabel.frame;
	textRect.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(textRect)) / 2;
	textRect.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(textRect)) / 2;
	textRect.origin.y -= 30.0;
	
	//alertTextLabel.frame = textRect;
	
	//alertTextLabel.transform = CGAffineTransformMakeRotation(- M_PI * .08);
	
}

- (void) show {
	[super show];
	
	CGSize imageSize = self.backgroundImage.size;
	self.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
}


- (void)dealloc {
    [super dealloc];
}


@end
