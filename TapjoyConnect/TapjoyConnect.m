//
//  TapjoyConnect.m
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.
//



#import "TapjoyConnect.h"

static TapjoyConnect * _sharedInstance=nil; //To make TapjoyConnect Singleton
static NSString * orignalRequest = TJC_SERVICE_URL;

@implementation TapjoyConnect
	
@synthesize appID = appID_;
@synthesize secretKey;		
@synthesize userID;		
@synthesize plugin;	
@synthesize currencyMultiplier;	

@synthesize callsWrapper;
@synthesize displayAdManager;
@synthesize eventTrackingManager;
@synthesize fullScreenAdManager;
@synthesize offersManager;
@synthesize dailyRewardManager;
@synthesize crossPromoManager;
@synthesize userAccountManager;
@synthesize videoManager;
@synthesize viewCommons;
@synthesize util;

#pragma mark GlobalMethods Required for Connect 
// Needed here to make connect a SINGLE FILE

- (NSMutableDictionary *) genericParameters
{
	// Device info.
	UIDevice *device = [UIDevice currentDevice];
	NSString *identifier = [device uniqueIdentifier];
	NSString *model = [device model];
	NSString *systemVersion = [device systemVersion];
	
	//NSString *device_name = [device platform];
	//NSLog(@"device name: %@", device_name);
	
	// Locale info.
	NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
	NSString *language = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];	

	// App info.
	NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
	
	NSMutableDictionary * genericDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
										 identifier, TJC_DEVICE_TAG_NAME,
										 model, TJC_DEVICE_TYPE_NAME,
										 //device_name, TJC_DEVICE_NAME,
										 systemVersion, TJC_DEVICE_OS_VERSION_NAME,
										 appID_, TJC_APP_ID_NAME,
										 bundleVersion, TJC_APP_VERSION_NAME,
										 TJC_LIBRARY_VERSION_NUMBER, TJC_CONNECT_LIBRARY_VERSION_NAME,
										 countryCode, TJC_DEVICE_COUNTRY_CODE,
										 language, TJC_DEVICE_LANGUAGE,
										 nil];
	
	return [genericDict autorelease];
	
}


static NSString *toString(id object) 
{
	return [NSString stringWithFormat: @"%@", object];
}


static NSString* urlEncode(id object) 
{
	NSString *string = toString(object);
	return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}


- (NSString*) createQueryStringFromDict:(NSDictionary*) paramDict
{
	if(!paramDict)
	{
		paramDict = [[TapjoyConnect sharedTapjoyConnect]genericParameters];
	}
	NSMutableArray *parts = [NSMutableArray array];
	for (id key in [paramDict allKeys]) 
	{
		id value = [paramDict objectForKey: key];
		NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
		[parts addObject: part];
	}
	return [parts componentsJoinedByString: @"&"];
}


- (void) connectWithParam:(NSMutableDictionary *)genericDict
{
	
	NSString *requestString1 = [NSString stringWithFormat:@"%@%@?%@",orignalRequest,@"Connect", [self createQueryStringFromDict:genericDict]];
	
	NSString *requestString = [requestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSURL * myURL = [[NSURL alloc] initWithString:requestString];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL: myURL
															 cachePolicy: NSURLRequestUseProtocolCachePolicy
														 timeoutInterval: 30];
	[myURL release];
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	connection_ = [[NSURLConnection alloc] initWithRequest: myRequest delegate: self];
	connectAttempts_++;	
}



#pragma mark delegate methods for asynchronous requests

- (void) connection:(NSURLConnection *) myConnection didReceiveResponse:(NSURLResponse *) myResponse;
{
	
}


- (void) connection:(NSURLConnection *) myConnection didReceiveData:(NSData *) myData;
{   
	if (data_) 
	{
        if (![data_ isKindOfClass: [NSMutableData class]]) 
		{
            data_ = [data_ mutableCopy];
            [data_ release];
        }
        
        [(NSMutableData *) data_ appendData: myData];
    } 
	else
	{
        data_ = [myData mutableCopy];
    }
}


- (void) connection:(NSURLConnection *) myConnection didFailWithError:(NSError *) myError;
{
	[connection_ release];
	connection_ = nil;
	
	if (connectAttempts_ >=2)
	{	
		[[NSNotificationCenter defaultCenter] postNotificationName:TJC_CONNECT_FAILED object:nil];
		return;
	}
	
	if(connectAttempts_ < 2)
	{	
		orignalRequest = TJC_SERVICE_URL_ALTERNATE;
		[_sharedInstance connectWithParam:[_sharedInstance genericParameters]];
	}
}


- (void) connectionDidFinishLoading:(NSURLConnection *) myConnection;
{
	[connection_ release];
	connection_ = nil;
	[self startParsing:data_];
}


- (void) startParsing:(NSData *) myData 
{
    NSData *xmlData = myData;//(Get XML as NSData)
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:xmlData] autorelease];
    [parser setDelegate:self];
    [parser parse];
}


- (void) parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qualifiedName 
	 attributes:(NSDictionary *)attributeDict 
{
	currentXMLElement_ = elementName;
	if ([elementName isEqualToString:@"ErrorMessage"])
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:TJC_CONNECT_FAILED object:nil];
	}
}


- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if([currentXMLElement_ isEqualToString:@"Success"] && [string isEqualToString:@"true"])
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:TJC_CONNECT_SUCCESS object:nil];
	}
}


- (void) parser:(NSXMLParser *)parser 
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qName
{
	
}



#pragma mark TapjoyConnect Initialize methods

- (id)initWithAppId:(NSString*)appId
{
		appID_ = [appId retain];
		connection_ = nil;
		timeStamp_ = 100;
		connectAttempts_ = 0;
		
	return self;
}


// Simplified Function for End User 
+ (TapjoyConnect *)requestTapjoyConnectWithAppId:(NSString*)appId
{
	if(!_sharedInstance)
	{
		_sharedInstance = [[super allocWithZone:NULL] initWithAppId:appId];
	}
	
	// 7.0.0 update: Call connect here to simplify the method call.
	[_sharedInstance connectWithParam:[_sharedInstance genericParameters]];
	
	return _sharedInstance;
}


+ (TapjoyConnect *) sharedTapjoyConnect;
{
	return _sharedInstance;
}


- (void)connect
{
	// 7.0.0 update: This method is deprecated. It no longer does anything.
	//[self connectWithParam:[self genericParameters]];
}




#pragma mark TapjoyConnect Singleton Required Methods

- (void) dealloc 
{
	[_sharedInstance release];
	[super dealloc];
}


+ (id) alloc
{
	return [[self sharedTapjoyConnect] retain];
}


+ (id) allocWithZone:(NSZone *)zone
{
	return [[self sharedTapjoyConnect] retain];
}


- (id) copyWithZone:(NSZone *)zone
{
	return self;
}


- (id) retain
{
	return self;
}


- (void)release
{
	//do nothing, for Pure Singleton
}


- (NSUInteger) retainCount
{
	//denotes an object that cannot be released
	return NSUIntegerMax;
}


- (id) autorelease
{
	return self;
}

@end


