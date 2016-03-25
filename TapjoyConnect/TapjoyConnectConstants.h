// Copyright (C) 2011-2012 by Tapjoy Inc.
//
// This file is part of the Tapjoy SDK.
//
// By using the Tapjoy SDK in your software, you agree to the terms of the Tapjoy SDK License Agreement.
//
// The Tapjoy SDK is bound by the Tapjoy SDK License Agreement and can be found here: https://www.tapjoy.com/sdk/license



#define TJC_CONNECT_SUCCESS				@"TJC_Connect_Success"
#define TJC_CONNECT_FAILED				@"TJC_Connect_Failed"
#define TJC_CONNECT_SDK
#define TJC_SDK_TYPE_VALUE				@"connect"


// The keys for the options dictionary when calling requestTapjoyConnect.
#define TJC_OPTION_USER_ID						@"TJC_OPTION_USER_ID"
#define TJC_OPTION_ENABLE_LOGGING				@"TJC_OPTION_ENABLE_LOGGING"

//by rsj
#define TJC_SERVICE_URL						@"http://ws.tapjoyads.com/"
#define TJC_SERVICE_URL_ALTERNATE			@"http://ws1.tapjoyads.com/"
#define TJC_DEVICE_TAG_NAME					@"udid"			/*!< The unique device identifier. */
#define TJC_DEVICE_NAME						@"device_name"	/*!< This is the specific device name ("iPhone1,1", "iPod1,1"...) */
#define TJC_DEVICE_TYPE_NAME				@"device_type"	/*!< The model name of the device. This is less descriptive than the device name. */
#define TJC_DEVICE_OS_VERSION_NAME			@"os_version"	/*!< The device system version. */
#define TJC_DEVICE_COUNTRY_CODE				@"country_code"	/*!< The country code is retrieved from the locale object, from user data (not device). */
#define TJC_DEVICE_LANGUAGE					@"language_code"/*!< The language is retrieved from the locale object, from user data (not device). */
#define TJC_APP_ID_NAME						@"app_id"		/*!< The application id is set by the developer, and is a unique id provided by Tapjoy. */
#define TJC_APP_VERSION_NAME				@"app_version"	/*!< The application version is retrieved from the application plist file, from the bundle version. */
#define TJC_CONNECT_LIBRARY_VERSION_NAME	@"library_version"	/*!< The library version is the SDK version number. */
// ---------------
