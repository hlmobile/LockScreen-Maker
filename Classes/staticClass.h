//
//  staticClass.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/29/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wallPaperAppDelegate.h"

@interface staticClass : UIViewController {
	//UIImage *theImage;
	wallPaperAppDelegate *appDelegate;
}
-(UIImage*)getImage;
-(void)setImage:(UIImage*) image;
//@property(retain,nonatomic) UIImage *theImage;
@end
