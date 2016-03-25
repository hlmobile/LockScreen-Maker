//
//  imageimage.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/29/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wallPaperAppDelegate.h"

@interface imageimage : UIViewController {

	wallPaperAppDelegate *appDelegate;
}
-(UIImage*)getImage;
-(void)setImage:(UIImage*) image;

@end
