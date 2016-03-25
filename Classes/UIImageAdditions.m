//
//  UIImageAdditions.m
//  Wallpaper
//
//  Created by Eric Snider on 7/15/10.
//

#import "UIImageAdditions.h"

//
// Support for @2x images -- unfortunately OS 4.0 on iPhone 4 doesn't handle this correctly so far.
//

@implementation UIImage (UIImageAdditions)

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path
{
    BOOL hasScaleEtc =  ([UIScreen instancesRespondToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0 );

    if ( hasScaleEtc )
    {
        NSString *path2x = [[path stringByDeletingLastPathComponent] 
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@", 
                                                            [[path lastPathComponent] stringByDeletingPathExtension], 
                                                            [path pathExtension]]];
// If the file exists for the @2x version then...
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] )
        {
// Load it up
            UIImage *tempImage = [[UIImage alloc] initWithContentsOfFile:path];
// Does this device (well, specifically this image) respond to this method that is ONLY on iPhone OS 4?
            BOOL thisDeviceIsAnOS4Device = ( tempImage && [tempImage respondsToSelector:@selector(initWithCGImage:scale:orientation:)]);
            [tempImage release];
            if ( thisDeviceIsAnOS4Device )
            {
                return [self initWithContentsOfFile:path2x];
            }
        }
    }
    
    return [self initWithContentsOfFile:path];
}

+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path
{
    return [[[UIImage alloc] initWithContentsOfResolutionIndependentFile:path] autorelease];
}




@end
