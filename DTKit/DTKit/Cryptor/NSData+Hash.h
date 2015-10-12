//
//  NSData+Hash.h
//  DTKit
//
//  Created by 文杰 on 15/10/11.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Hash)
#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)dt_md5String;

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)dt_md5Data;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)dt_sha1String;

/**
 Returns an NSData for sha1 hash.
 */
- (NSData *)dt_sha1Data;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)dt_sha256String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)dt_sha256Data;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)dt_sha512String;

/**
 Returns an NSData for sha512 hash.
 */
- (NSData *)dt_sha512Data;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSString *)dt_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSData *)dt_hmacMD5DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)dt_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSData *)dt_hmacSHA1DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSString *)dt_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSData *)dt_hmacSHA256DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSString *)dt_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSData *)dt_hmacSHA512DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)dt_crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)dt_crc32;
@end
