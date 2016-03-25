//
//  ListItem.m
//  GoGoGirlsBaseProject
//
//  Created by vopilif on 4/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ListItem.h"
#import "UIImageAdditions.h"

@interface ListItem (privateMethods)

- (NSURL *)urlForItem:(NSString *)inItem;
- (NSString *)parseOutFileName:(NSString *)inFile;
- (NSString *)parseOutFileExtension:(NSString *)inFile;
- (NSURL *)movieURLforLocalMovieNamed:(NSString *)inMovie withExtension:(NSString *)inExt;
- (BOOL)isHTTPPath:(NSString *)inItem;

@end


@implementation ListItem

@synthesize name;
@synthesize fileURL;
@synthesize thumb;
@synthesize order;
@synthesize rowHeightOverride;
@synthesize secondLineText;
@synthesize imageURLs;

@synthesize stillsNameBase;
@synthesize stillsNumberBase;
@synthesize	stillsCount;

//
// Eric has changed this so that it ALWAYS expects inThumb to be a local file path, not an http URL
//
- (id) initWithItemName:(NSString *)inName URL:(NSString *)url andThumbnail:(NSString *)inThumb
{
	self.name = inName;
	self.fileURL = [self urlForItem:url];
//    NSLog(@"[DEBUG] ListItem: InitWithItemName: %@, fileURL: %@, inThumb: %@", inName, fileURL, inThumb);
// Get our thumbnail image locally OR from the web
    if ( [self isHTTPPath:inThumb] )
    {
        NSLog(@"Eric has turned off support for http thumbnails");
    }
    else
    {
        self.thumb = IMAGE_WITH_CONTENTS_2X_SUPPORT(inThumb);
    }

//	NSLog(@"[DEBUG] fileURL: %@", self.fileURL);
	return self;
}

- (id) initWithItemName:(NSString *)inName 
{
	self.name = inName;
	return self;
}

- (BOOL)isHTTPPath:(NSString *)inItem
{
	return ( [inItem hasPrefix:@"http://"] );
}

- (NSURL *)urlForItem:(NSString *)inItem
{
	if ( [self isHTTPPath:inItem] )
	{
		//NSLog(@"Using external URL for video input");
		return [NSURL URLWithString:inItem];
	}
	else
	{
		//NSLog(@"Using internal movie file for video input");
        NSBundle *bundle = [NSBundle mainBundle];
		return [NSURL fileURLWithPath:[bundle pathForResource:inItem ofType:nil]];
	}
}

- (NSString *)parseOutFileName:(NSString *)inFile
{
	NSRange rangeforDot;
	rangeforDot = [inFile rangeOfString:@"."];
	//NSLog(@"parseOutFileName: %@", [inFile substringToIndex:rangeforDot.location]);
	return [inFile substringToIndex:rangeforDot.location];
}

- (NSString *)parseOutFileExtension:(NSString *)inFile
{
	NSRange rangeforDot;
	rangeforDot = [inFile rangeOfString:@"."];
	//NSLog(@"parseOutFileExtension: %@", [inFile substringFromIndex:rangeforDot.location+1]);
	return [inFile substringFromIndex:rangeforDot.location+1];
}


- (void)dealloc
{
    [name release];
    [fileURL release];
    [thumb release];
    [secondLineText release];
    [imageURLs release];
    [super dealloc];
}


@end
