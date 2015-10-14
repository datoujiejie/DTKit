//
//  NSString+Hash.m
//  DTKit
//
//  Created by hwj on 15/10/14.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import "NSString+Hash.h"
#import "NSData+Hash.h"

@implementation NSString (Hash)
- (NSString *)dt_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_md5String];
}

- (NSString *)dt_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_sha1String];
}

- (NSString *)dt_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_sha256String];
}

- (NSString *)dt_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_sha512String];
}

- (NSString *)dt_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_crc32String];
}

- (NSString *)dt_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacMD5StringWithKey:key];
}

- (NSString *)dt_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacSHA1StringWithKey:key];
}

- (NSString *)dt_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacSHA256StringWithKey:key];
}

- (NSString *)dt_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacSHA512StringWithKey:key];
}

@end
