//
//  UIImageAdditions.h
//  Wallpaper
//
//  Created by Eric Snider on 7/15/10.
//

#import <Foundation/Foundation.h>


@interface UIImage (UIImageAdditions)
- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;
@end
