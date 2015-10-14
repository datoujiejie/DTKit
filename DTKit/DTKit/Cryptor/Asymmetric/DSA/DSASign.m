//
//  DSASign.m
//  Encrypt
//
//  Created by hwj on 15/9/10.
//  Copyright (c) 2015年 traveksky. All rights reserved.
//

#import "DSASign.h"
#import <openssl/dsa.h>
#import <openssl/md5.h>
#import <openssl/sha.h>
#import <openssl/pem.h>

@interface DSASign ()
{
    DSA *_publicDSAKey;
    DSA *_privateDSAKey;
}

@end

@implementation DSASign

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
    const char *dsa_key = [privateKey cStringUsingEncoding:NSASCIIStringEncoding];
    BIO *bio = BIO_new_mem_buf((void *)dsa_key, -1);
    _privateDSAKey = PEM_read_bio_DSAPrivateKey(bio, NULL, NULL, NULL);
    assert(_privateDSAKey != NULL);
}

- (void)setPublicKey:(NSString *)publicKey {
    _publicKey = [publicKey copy];
    const char *dsa_key = [publicKey cStringUsingEncoding:NSASCIIStringEncoding];
    BIO *bio = BIO_new_mem_buf((void *)dsa_key, -1);
    _publicDSAKey = PEM_read_bio_DSA_PUBKEY(bio, NULL, NULL, NULL);
    assert(_publicDSAKey != NULL);
}

- (NSData *)sign:(NSData *)data {
    unsigned char *sig = (unsigned char *)calloc(DSA_size(_privateDSAKey), 1);
    unsigned int sig_len;
    
    bzero(sig, DSA_size(_privateDSAKey));
    
    if (DSA_sign(0, (const unsigned char *) data.bytes, (int)data.length, sig, &sig_len, _privateDSAKey) != 1)
    {
        free(sig);
        return nil;
    }
    NSData * res = [NSData dataWithBytes:sig length:sig_len];
    free(sig);
    
    return res;
}

- (BOOL)verify:(NSData *)data withSignature:(NSData *)signature {
    const unsigned char *dgst = (const unsigned char *)[data bytes];
    const unsigned char *sigbuf = (const unsigned char *)[signature bytes];
    BOOL res = DSA_verify(0, dgst, (int)data.length, sigbuf, (int)signature.length, _publicDSAKey) == 1;
    return res;

}
@end
