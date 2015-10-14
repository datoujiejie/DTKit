//
//  NSString+Hash.h
//  DTKit
//
//  Created by hwj on 15/10/14.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)
#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)dt_md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)dt_sha1String;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)dt_sha256String;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)dt_sha512String;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)dt_crc32String;

@end
