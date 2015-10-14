//
//  NSData+CommonCryptor.m
//  DTKit
//
//  Created by 文杰 on 15/10/11.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import "NSData+DTCommonCryptor.h"
#import <CommonCrypto/CommonCryptor.h>

NSString *const kDTCommonCryptoErrorDomain = @"CommonCryptoErrorDomain";

@implementation NSData (DTCommonCryptor)

static void DTFixKeyLengths(CCAlgorithm algorithm, NSMutableData *keyData, NSMutableData *ivData)
{
    NSUInteger keyLength = [keyData length];
    
    switch (algorithm)
    {
        case kCCAlgorithmAES128:
        {
            if (keyLength <= 16)
            {
                [keyData setLength:16];
            }
            else if (keyLength <= 24)
            {
                [keyData setLength:24];
            }
            else
            {
                [keyData setLength:32];
            }
            
            break;
        }
            
        case kCCAlgorithmDES:
        {
            [keyData setLength:8];
            break;
        }
            
        case kCCAlgorithm3DES:
        {
            [keyData setLength:24];
            break;
        }
            
        case kCCAlgorithmCAST:
        {
            if (keyLength <= 5)
            {
                [keyData setLength:5];
            }
            else if (keyLength >= 16)
            {
                [keyData setLength:16];
            }
            
            break;
        }
            
        case kCCAlgorithmRC4:
        {
            if (keyLength >= 512)
            {
                [keyData setLength:512];
            }
            
            break;
        }
            
        default:
            break;
    }
    
    [ivData setLength:[keyData length]];
}

#pragma mark AES Cypto
- (NSData *)dt_AESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                                  error:(NSError **)error
{
    CCCryptorStatus status = kCCSuccess;
    
    NSData *result = [self dt_dataEncryptedUsingAlgorithm:kCCAlgorithmAES128
                                                   key:key
                                  initializationVector:iv
                                               options:kCCOptionPKCS7Padding
                                                 error:&status];
    
    if (result != nil)
    {
        return result;
    }
    
    if (error != NULL)
    {
        *error = [self dt_errorWithCCCryptorStatus:status];
    }
    
    return nil;
}

- (NSData *)dt_AESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error
{
    CCCryptorStatus status = kCCSuccess;
    
    NSData *result = [self dt_dataDecryptedUsingAlgorithm:kCCAlgorithmAES128
                                                   key:key
                                  initializationVector:iv
                                               options:kCCOptionPKCS7Padding
                                                 error:&status];
    
    if (result != nil)
    {
        return result;
    }
    
    if (error != NULL)
    {
        *error = [self dt_errorWithCCCryptorStatus:status];
    }
    
    return nil;
}

#pragma mark DES Cypto
- (NSData *)dt_DESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error {
    CCCryptorStatus status = kCCSuccess;
    NSData         *result = [self dt_dataEncryptedUsingAlgorithm:kCCAlgorithm3DES
                                                           key:key
                                          initializationVector:iv
                                                       options:kCCOptionPKCS7Padding
                                                         error:&status];
    
    if (result != nil)
    {
        return result;
    }
    
    if (error != NULL)
    {
        *error = [self dt_errorWithCCCryptorStatus:status];
    }
    
    return nil;
}

- (NSData *)dt_DESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error {
    CCCryptorStatus status = kCCSuccess;
    NSData         *result = [self dt_dataDecryptedUsingAlgorithm:kCCAlgorithm3DES
                                                           key:key
                                          initializationVector:iv
                                                       options:kCCOptionPKCS7Padding
                                                         error:&status];
    
    if (result != nil)
    {
        return result;
    }
    
    if (error != NULL)
    {
        *error = [self dt_errorWithCCCryptorStatus:status];
    }
    
    return nil;
}


- (NSData *)dt_runCryptor:(CCCryptorRef)cryptor result:(CCCryptorStatus *)status
{
    size_t bufsize = CCCryptorGetOutputLength(cryptor, (size_t)[self length], true);
    void  *buf = malloc(bufsize);
    
    size_t bufused = 0;
    size_t bytesTotal = 0;
    
    *status = CCCryptorUpdate(cryptor, [self bytes], (size_t)[self length],
                              buf, bufsize, &bufused);
    
    if (*status != kCCSuccess)
    {
        free(buf);
        return nil;
    }
    
    bytesTotal += bufused;
    
    // From Brent Royal-Gordon (Twitter: architechies):
    //  Need to update buf ptr past used bytes when calling CCCryptorFinal()
    *status = CCCryptorFinal(cryptor, buf + bufused, bufsize - bufused, &bufused);
    
    if (*status != kCCSuccess)
    {
        free(buf);
        return nil;
    }
    
    bytesTotal += bufused;
    
    return [NSData dataWithBytesNoCopy:buf length:bytesTotal];
}

- (NSData *)dt_dataEncryptedUsingAlgorithm:(CCAlgorithm)algorithm
                                       key:(id)key
                      initializationVector:(id)iv
                                   options:(CCOptions)options
                                     error:(CCCryptorStatus *)error
{
    CCCryptorRef    cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    NSParameterAssert([key isKindOfClass:[NSData class]] || [key isKindOfClass:[NSString class]]);
    NSParameterAssert(iv == nil || [iv isKindOfClass:[NSData class]] || [iv isKindOfClass:[NSString class]]);
    
    NSMutableData *keyData, *ivData;
    
    if ([key isKindOfClass:[NSData class]])
    {
        keyData = (NSMutableData *)[key mutableCopy];
    }
    else
    {
        keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    }
    
    if ([iv isKindOfClass:[NSString class]])
    {
        ivData = [[iv dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    }
    else
    {
        ivData = (NSMutableData *)[iv mutableCopy];     // data or nil
    }
    
    // ensure correct lengths for key and iv data, based on algorithms
    DTFixKeyLengths(algorithm, keyData, ivData);
    
    status = CCCryptorCreate(kCCEncrypt, algorithm, options,
                             [keyData bytes], [keyData length], [ivData bytes],
                             &cryptor);
    
    if (status != kCCSuccess)
    {
        if (error != NULL)
        {
            *error = status;
        }
        
        return nil;
    }
    
    NSData *result = [self dt_runCryptor:cryptor result:&status];
    
    if ((result == nil) && (error != NULL))
    {
        *error = status;
    }
    
    CCCryptorRelease(cryptor);
    
    return result;
}

- (NSData *)dt_dataDecryptedUsingAlgorithm:(CCAlgorithm)algorithm
                                       key:(id)key         // data or string
                      initializationVector:(id)iv          // data or string
                                   options:(CCOptions)options
                                     error:(CCCryptorStatus *)error
{
    CCCryptorRef    cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    NSParameterAssert([key isKindOfClass:[NSData class]] || [key isKindOfClass:[NSString class]]);
    NSParameterAssert(iv == nil || [iv isKindOfClass:[NSData class]] || [iv isKindOfClass:[NSString class]]);
    
    NSMutableData *keyData, *ivData;
    
    if ([key isKindOfClass:[NSData class]])
    {
        keyData = (NSMutableData *)[key mutableCopy];
    }
    else
    {
        keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    }
    
    if ([iv isKindOfClass:[NSString class]])
    {
        ivData = [[iv dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    }
    else
    {
        ivData = (NSMutableData *)[iv mutableCopy];     // data or nil
    }
    
    // ensure correct lengths for key and iv data, based on algorithms
    DTFixKeyLengths(algorithm, keyData, ivData);
    
    status = CCCryptorCreate(kCCDecrypt, algorithm, options,
                             [keyData bytes], [keyData length], [ivData bytes],
                             &cryptor);
    
    if (status != kCCSuccess)
    {
        if (error != NULL)
        {
            *error = status;
        }
        
        return nil;
    }
    
    NSData *result = [self dt_runCryptor:cryptor result:&status];
    
    if ((result == nil) && (error != NULL))
    {
        *error = status;
    }
    
    CCCryptorRelease(cryptor);
    
    return result;
}

- (NSError *)dt_errorWithCCCryptorStatus:(CCCryptorStatus)status
{
    NSString *description = nil, *reason = nil;
    
    switch (status)
    {
        case kCCSuccess:
            description = NSLocalizedString(@"Success", @"Error description");
            break;
            
        case kCCParamError:
            description = NSLocalizedString(@"Parameter Error", @"Error description");
            reason = NSLocalizedString(@"Illegal parameter supplied to encryption/decryption algorithm", @"Error reason");
            break;
            
        case kCCBufferTooSmall:
            description = NSLocalizedString(@"Buffer Too Small", @"Error description");
            reason = NSLocalizedString(@"Insufficient buffer provided for specified operation", @"Error reason");
            break;
            
        case kCCMemoryFailure:
            description = NSLocalizedString(@"Memory Failure", @"Error description");
            reason = NSLocalizedString(@"Failed to allocate memory", @"Error reason");
            break;
            
        case kCCAlignmentError:
            description = NSLocalizedString(@"Alignment Error", @"Error description");
            reason = NSLocalizedString(@"Input size to encryption algorithm was not aligned correctly", @"Error reason");
            break;
            
        case kCCDecodeError:
            description = NSLocalizedString(@"Decode Error", @"Error description");
            reason = NSLocalizedString(@"Input data did not decode or decrypt correctly", @"Error reason");
            break;
            
        case kCCUnimplemented:
            description = NSLocalizedString(@"Unimplemented Function", @"Error description");
            reason = NSLocalizedString(@"Function not implemented for the current algorithm", @"Error reason");
            break;
            
        default:
            description = NSLocalizedString(@"Unknown Error", @"Error description");
            break;
    }
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:description forKey:NSLocalizedDescriptionKey];
    
    if (reason != nil)
    {
        [userInfo setObject:reason forKey:NSLocalizedFailureReasonErrorKey];
    }
    
    NSError *result = [NSError errorWithDomain:kDTCommonCryptoErrorDomain
                                          code:status
                                      userInfo:userInfo];
    
    return result;
}
@end
