//
//  UIApplication+YYAdd.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 13/4/4.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIApplication`.
 */
@interface UIApplication (DTKit)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *dt_documentsURL;
@property (nonatomic, readonly) NSString *dt_documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *dt_cachesURL;
@property (nonatomic, readonly) NSString *dt_cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *dt_libraryURL;
@property (nonatomic, readonly) NSString *dt_libraryPath;

/// Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString *dt_appBundleName;

/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nullable, nonatomic, readonly) NSString *dt_appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *dt_appVersion;

/// Application's Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString *dt_appBuildVersion;

/// Whether this app is pirated (not install from appstore).
@property (nonatomic, readonly) BOOL dt_isPirated;

/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL dt_isBeingDebugged;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float dt_cpuUsage;

/// Returns YES in App Extension.
+ (BOOL)dt_isAppExtension;

/// Same as sharedApplication, but returns nil in App Extension.
+ (nullable UIApplication *)dt_sharedExtensionApplication;

@end

NS_ASSUME_NONNULL_END
