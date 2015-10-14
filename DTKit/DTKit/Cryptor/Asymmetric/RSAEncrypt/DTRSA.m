//
//  RSAEncrypt.m
//  SkyOne
//
//  Created by Jeffery He on 14-06-23.
//  Copyright (c) 2014年 TravelSky. All rights reserved.
//

#import "DTRSA.h"
#import "NSString+DTKit.h"
#import "NSData+DTKit.h"
#include <openssl/rsa.h>
#include <openssl/pem.h>

typedef enum {
    RSATypePublic,
    RSATypePrivate
}RSAType;

typedef enum {
    RSA_PADDING_TYPE_NONE       = RSA_NO_PADDING,
    RSA_PADDING_TYPE_PKCS1      = RSA_PKCS1_PADDING,
    RSA_PADDING_TYPE_SSLV23     = RSA_SSLV23_PADDING
}RSA_PADDING_TYPE;

@interface DTRSA () {
    RSA *_publicRSAKey;
    RSA *_privateRSAKey;
}
@end

@implementation DTRSA

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithPrivateKey:(NSString *)privateKey
               publicKey:(NSString *)publicKey {
    self = [super init];
    if (self) {
        self.privateKey = privateKey;
        self.publicKey = publicKey;
    }
    return self;
}

- (void)setPrivateKey:(NSString *)privateKey {
    _privateKey= [privateKey copy];
    const char *rsa_key = [privateKey cStringUsingEncoding:NSASCIIStringEncoding];
    BIO *bio = BIO_new_mem_buf((void *)rsa_key, -1);
    _privateRSAKey = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, NULL);
    assert(_privateRSAKey != NULL);
}

- (void)setPublicKey:(NSString *)publicKey {
    _publicKey = [publicKey copy];
    const char *rsa_key = [publicKey cStringUsingEncoding:NSASCIIStringEncoding];
    BIO *bio = BIO_new_mem_buf((void *)rsa_key, -1);
    _publicRSAKey = PEM_read_bio_RSA_PUBKEY(bio, NULL, NULL, NULL);
    assert(_publicRSAKey != NULL);
}

- (NSString *)publicEncryptWithString:(NSString *)plainString {
    NSData *data = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    return [self encryptWithData:data type:RSATypePublic];
}

- (NSString *)publicEncryptWithData:(NSData *)data {
    return [self encryptWithData:data type:RSATypePublic];
}

- (NSString *)privateEncryptWithString:(NSString *)plainString {
    NSData *data = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    return [self encryptWithData:data type:RSATypePrivate];
}

- (NSString *)privateEncryptWithData:(NSData *)data {
    return [self encryptWithData:data type:RSATypePrivate];
}

- (NSData *)publicDecryptWithString:(NSString *)string {
    NSData *data = [string dt_base64Decoding];
    return [self decryptWithData:data type:RSATypePublic];
}

- (NSData *)privateDecryptWithString:(NSString *)string {
    NSData *data = [string dt_base64Decoding];
    return [self decryptWithData:data type:RSATypePrivate];
}

/*!
 @method
 @abstract 分段加密
 @discussion 分段加密
 
 @param plainData 加密的NSData类型
 
 @return base64String
 */
- (NSString *)encryptWithData:(NSData *)plainData type:(RSAType)type{
    NSMutableData *data = [[NSMutableData alloc] init];
    int i;
    for (i = 0;i < (plainData.length / 117); i++) {
        NSData *subData = [plainData subdataWithRange:NSMakeRange(i * 117, 117)];
        NSData *decryptData = [self encrypt:subData type:type];
        [data appendData:decryptData];
    }
    if (plainData.length % 117 != 0) {
        NSData *subData = [plainData subdataWithRange:NSMakeRange(i * 117, plainData.length % 117)];
        NSData *decryptData = [self encrypt:subData type:type];
        [data appendData:decryptData];
    }
    return [data dt_base64Encoding];
}

- (NSData *)decryptWithData:(NSData *)securityData type:(RSAType)type{
    NSMutableData *data = [[NSMutableData alloc] init];
    int i;
    for (i = 0;i < (securityData.length / 128); i++) {
        NSData *subData = [securityData subdataWithRange:NSMakeRange(i * 128, 128)];
        NSData *decryptData = [self decrypt:subData type:type];
        [data appendData:decryptData];
    }
    if (securityData.length % 128 != 0) {
        NSData *subData = [securityData subdataWithRange:NSMakeRange(i * 128, securityData.length % 128)];
        NSData *decryptData = [self decrypt:subData type:type];
        [data appendData:decryptData];
    }
    return data;
}

- (NSData *)encrypt:(NSData *)data type:(RSAType)type{
    unsigned char *outbuf;
    int outlen;
    if (type == RSATypePublic) {
        outbuf = (unsigned char *)malloc(RSA_size(_publicRSAKey));
        //公钥加密
        if (!(outlen = RSA_public_encrypt((int)[data length], [data bytes], outbuf, _publicRSAKey, RSA_PKCS1_PADDING))) {
            NSLog(@"RSA encryption failed.");
            return nil;
        }
    }else {
        //私钥加密
        outbuf = (unsigned char *)malloc(RSA_size(_privateRSAKey));
        if (!(outlen = RSA_private_encrypt((int)[data length], [data bytes], outbuf, _privateRSAKey, RSA_PKCS1_PADDING))) {
            NSLog(@"RSA encryption failed.");
            return nil;
        }
    }
    if (outlen < 0) {
        return nil;
    }
    NSData *ret = [NSData dataWithBytes:outbuf length:outlen];
    free(outbuf);
    return ret;
}

- (NSData *)decrypt:(NSData *)data type:(RSAType)type{
    unsigned char *outbuf;
    int outlen;
    if (type == RSATypePublic) {
        outbuf = (unsigned char *)malloc(RSA_size(_publicRSAKey));
        //公钥加密
        if (!(outlen = RSA_public_decrypt((int)[data length], [data bytes], outbuf, _publicRSAKey, RSA_PKCS1_PADDING))) {
            NSLog(@"RSA encryption failed.");
            return nil;
        }
    }else {
        outbuf = (unsigned char *)malloc(RSA_size(_privateRSAKey));
        //私钥加密
        if (!(outlen = RSA_private_decrypt((int)[data length], [data bytes], outbuf, _privateRSAKey, RSA_PKCS1_PADDING))) {
            NSLog(@"RSA encryption failed.");
            return nil;
        }
    }
    if (outlen < 0) {
        return nil;
    }
    NSData *ret = [NSData dataWithBytes:outbuf length:outlen];
    free(outbuf);
    return ret;
}

#pragma mark - Sign
///=============================================================================
/// @name Sign
///=============================================================================
/*!
 @method
 @abstract 公钥加密字符串
 @discussion 公钥加密字符串
 
 @param plainString 要加密的字符串
 
 @return 返回加密后的base64字符串
 */
- (NSString *)signWithString:(NSString *)plainString {
    NSData *data = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    return [self signWithData:data];
}

/*!
 @method
 @abstract 公钥加密NSData
 @discussion 公钥加密NSData
 
 @param plainString 要加密的NSData
 
 @return 返回加密后的base64字符串
 */
- (NSString *)signWithData:(NSData *)data {
    unsigned char *sig = (unsigned char *)calloc(RSA_size(_privateRSAKey), 1);
    unsigned int sig_len;
    
    bzero(sig, RSA_size(_privateRSAKey));
    
    int ret = RSA_sign(0, (const unsigned char *) data.bytes, (int)data.length, sig, &sig_len, _privateRSAKey);
    if (ret != 1)
    {
        free(sig);
        return nil;
    }
    NSData * res = [NSData dataWithBytes:sig length:sig_len];
    free(sig);
    
    return [res dt_base64Encoding];
}


/*!
 @method
 @abstract 私钥加密字符串
 @discussion 私钥加密字符串
 
 @param plainString 源数据
 @param signature  签名后的base64字符串
 
 @return 校验结果
 */
- (BOOL)verifyWithString:(NSString *)plainString
               signature:(NSString *)signature{
    NSData *data = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *signatureData = [signature dt_base64Decoding];
    return [self verifyWithData:data withSignature:signatureData];
}


/*!
 @method
 @abstract 私钥加密字符串
 @discussion 私钥加密字符串
 
 @param data      原数据
 @param signature 签名后的数据
 
 @return 校验结果
 */
- (BOOL)verifyWithData:(NSData *)data withSignature:(NSData *)signature {
    const unsigned char *dgst = (const unsigned char *)[data bytes];
    const unsigned char *sigbuf = (const unsigned char *)[signature bytes];
    BOOL res = RSA_verify(0, dgst, (int)data.length, sigbuf, (int)signature.length, _publicRSAKey) == 1;
    return res;
}



@end
