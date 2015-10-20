//
//  NSData+DTKit.h
//  DTKit
//
//  Created by 文杰 on 15/8/30.
//  Copyright (c) 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DTKit)
#pragma mark - Encrypt and Decrypt
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (NSData *)dt_aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (NSData *)dt_aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;


#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns string decoded in UTF8.
 */
- (NSString *)dt_utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (NSString *)dt_hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (NSData *)dt_dataWithHexString:(NSString *)hexString;

/**
 Returns an NSString for base64 encoded.
 
 @warning This method has been implemented in iOS7.
 */
- (NSString *)dt_base64Encoding;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64Encoding  The encoded string.
 */
+ (NSData *)dt_dataWithBase64Encoding:(NSString *)base64Encoding;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (id)dt_jsonValueDecoded;


#pragma mark - Inflate and deflate
///=============================================================================
/// @name Inflate and deflate
///=============================================================================

/**
 Decompress data from gzip data.
 @return Inflated data.
 */
- (NSData *)dt_gzipInflate;

/**
 Comperss data to gzip in default compresssion level.
 @return Deflated data.
 */
- (NSData *)dt_gzipDeflate;

/**
 Decompress data from zlib-compressed data.
 @return Inflated data.
 */
- (NSData *)dt_zlibInflate;

/**
 Comperss data to zlib-compressed in default compresssion level.
 @return Deflated data.
 */
- (NSData *)dt_zlibDeflate;
@end
