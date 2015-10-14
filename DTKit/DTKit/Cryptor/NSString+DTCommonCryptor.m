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

@implementation NSString (DTCommonCryptor)
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
    return [decryptData dt_base64Encoding];
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
