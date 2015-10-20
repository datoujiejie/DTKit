//
//  NSString+CommonCryptor.m
//  DTKit
//
//  Created by 文杰 on 15/10/11.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import "NSString+DTCommonCryptor.h"
#import "NSData+DTCommonCryptor.h"
#import "NSData+DTKit.h"
#import "NSString+DTKit.h"
#import "NSString+DTHash.h"

#define kDTKitDefaultKey  @"pa55w0rd"

@implementation NSString (DTCommonCryptor)

- (NSString *)dt_AESEncryptedString {
    NSString *key = [kDTKitDefaultKey dt_sha256String];
    NSString *iv = [kDTKitDefaultKey dt_md5String];
    return [self dt_AESEncryptedDataUsingKey:key
                                          iv:iv
                                       error:nil];
}

- (NSString *)dt_AESDecryptedString {
    NSString *key = [kDTKitDefaultKey dt_sha256String];
    NSString *iv = [kDTKitDefaultKey dt_md5String];
    return [self dt_AESDecryptedDataUsingKey:key
                                          iv:iv
                                       error:nil];
}

- (NSString *)dt_AESEncryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *sourceData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [sourceData dt_AESEncryptedDataUsingKey:key
                                                               iv:iv
                                                            error:error];
    return [encryptData dt_base64Encoding];
}

- (NSString *)dt_AESDecryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *encryptData = [self dt_base64Decoding];
    NSData *decryptData = [encryptData dt_AESDecryptedDataUsingKey:key
                                                                iv:iv
                                                             error:error];
    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}

- (NSString *)dt_DESEncryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *sourceData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [sourceData dt_DESEncryptedDataUsingKey:key
                                                               iv:iv
                                                            error:error];
    return [encryptData dt_base64Encoding];
}

- (NSString *)dt_DESDecryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *encryptData = [self dt_base64Decoding];
    NSData *decryptData = [encryptData dt_DESDecryptedDataUsingKey:key
                                                                iv:iv
                                                             error:error];
    return [decryptData dt_base64Encoding];
}



@end
