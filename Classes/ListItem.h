//
//  ListItem.h
//  GoGoGirlsBaseProject
//
//  Created by vopilif on 4/13/09.
//  Copyright 2009. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ListItem : NSObject 
{
	NSString	*name;
	NSURL		*fileURL;
	UIImage		*thumb;
	NSInteger	order;
	NSInteger	rowHeightOverride;
	NSString	*secondLineText;
    NSArray     *imageURLs;
    	
	NSString	*stillsNameBase;
	NSInteger	stillsNumberBase;
	NSInteger	stillsCount;
}

@property (nonatomic, retain) NSString		*name;
@property (nonatomic, retain) NSURL			*fileURL;
@property (nonatomic, retain) UIImage		*thumb;
@property (readwrite)         NSInteger		order;
@property (readwrite)		  NSInteger		rowHeightOverride;
@property (nonatomic, retain) NSString		*secondLineText;

@property (nonatomic, retain) NSArray       *imageURLs;

@property (readwrite, retain) NSString		*stillsNameBase;
@property (readwrite, assign) NSInteger		stillsNumberBase;
@property (readwrite, assign) NSInteger		stillsCount;

- (id) initWithItemName:(NSString *)inName 
					URL:(NSString *)url 
		   andThumbnail:(NSString *)thumb;

- (id) initWithItemName:(NSString *)inName;

@end
