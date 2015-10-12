//
//  NSString+CommonCryptor.m
//  DTKit
//
//  Created by 文杰 on 15/10/11.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import "NSString+CommonCryptor.h"
#import "NSData+CommonCryptor.h"
#import "NSData+DTKit.h"
#import "NSString+DTKit.h"

@implementation NSString (CommonCryptor)
- (NSString *)AESEncryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *sourceData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [sourceData AESEncryptedDataUsingKey:key
                                                            iv:iv
                                                         error:error];
    return [encryptData dt_base64Encoding];
}

- (NSString *)AESDecryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *encryptData = [self dt_base64Decoding];
    NSData *decryptData = [encryptData AESDecryptedDataUsingKey:key
                                                             iv:iv
                                                          error:error];
    return [decryptData dt_base64Encoding];
}

- (NSString *)DESEncryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *sourceData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [sourceData DESEncryptedDataUsingKey:key
                                                            iv:iv
                                                         error:error];
    return [encryptData dt_base64Encoding];
}

- (NSString *)DESDecryptedDataUsingKey:(id)key
                                    iv:(id)iv
                                 error:(NSError **)error {
    NSData *encryptData = [self dt_base64Decoding];
    NSData *decryptData = [encryptData DESDecryptedDataUsingKey:key
                                                             iv:iv
                                                          error:error];
    return [decryptData dt_base64Encoding];
}



@end
