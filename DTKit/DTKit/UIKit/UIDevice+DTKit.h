//
//  UIDevice+YYAdd.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 13/4/3.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIDevice`.
 */
@interface UIDevice (DTKit)


#pragma mark - Device Information
///=============================================================================
/// @name Device Information
///=============================================================================

/// Device system version (e.g. 8.1)
+ (double)dt_systemVersion;

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly) BOOL dt_isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL dt_isSimulator;

/// Whether the device is jailbroken.
@property (nonatomic, readonly) BOOL dt_isJailbroken;

/// Wherher the device can make phone calls.
@property (nonatomic, readonly) BOOL dt_canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *dt_machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *dt_machineModelName;

/// The System's startup time.
@property (nonatomic, readonly) NSDate *dt_systemUptime;


#pragma mark - Network Information
///=============================================================================
/// @name Network Information
///=============================================================================

/// WIFI IP address of this device (can be nil). e.g. @"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *dt_ipAddressWIFI;

/// Cell IP address of this device (can be nil). e.g. @"10.2.2.222"
@property (nullable, nonatomic, readonly) NSString *dt_ipAddressCell;


/**
 Network traffic type:
 
 WWAN: Wireless Wide Area Network.
       For example: 3G/4G.
 
 WIFI: Wi-Fi.
 
 AWDL: Apple Wireless Direct Link (peer-to-peer connection).
       For exmaple: AirDrop, AirPlay, GameKit.
 */
typedef NS_OPTIONS(NSUInteger, DTNetworkTrafficType) {
    DTNetworkTrafficTypeWWANSent     = 1 << 0,
    DTNetworkTrafficTypeWWANReceived = 1 << 1,
    DTNetworkTrafficTypeWIFISent     = 1 << 2,
    DTNetworkTrafficTypeWIFIReceived = 1 << 3,
    DTNetworkTrafficTypeAWDLSent     = 1 << 4,
    DTNetworkTrafficTypeAWDLReceived = 1 << 5,
    
    DTNetworkTrafficTypeWWAN = DTNetworkTrafficTypeWWANSent | DTNetworkTrafficTypeWWANReceived,
    DTNetworkTrafficTypeWIFI = DTNetworkTrafficTypeWIFISent | DTNetworkTrafficTypeWIFIReceived,
    DTNetworkTrafficTypeAWDL = DTNetworkTrafficTypeAWDLSent | DTNetworkTrafficTypeAWDLReceived,
    
    DTNetworkTrafficTypeALL = DTNetworkTrafficTypeWWAN |
                              DTNetworkTrafficTypeWIFI |
                              DTNetworkTrafficTypeAWDL,
};

/**
 Get device network traffic bytes.
 
 @discussion This is a counter since the device's last boot time.
 Usage:
 
     uint64_t bytes = [[UIDevice currentDevice] getNetworkTrafficBytes:YYNetworkTrafficTypeALL];
     NSTimeInterval time = CACurrentMediaTime();
     
     uint64_t bytesPerSecond = (bytes - _lastBytes) / (time - _lastTime);
     
     _lastBytes = bytes;
     _lastTime = time;
 
 
 @param types traffic types
 @return bytes counter.
 */
- (uint64_t)dt_getNetworkTrafficBytes:(DTNetworkTrafficType)types;


#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_diskSpaceUsed;


#pragma mark - Memory Information
///=============================================================================
/// @name Memory Information
///=============================================================================

/// Total physical memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryUsed;

/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryFree;

/// Acvite memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryActive;

/// Inactive memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t dt_memoryPurgable;

#pragma mark - CPU Information
///=============================================================================
/// @name CPU Information
///=============================================================================

/// Avaliable CPU processor count.
@property (nonatomic, readonly) NSUInteger dt_cpuCount;

/// Current CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float dt_cpuUsage;

/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *dt_cpuUsagePerProcessor;

@end

NS_ASSUME_NONNULL_END
