//
//  DSASign.h
//  Encrypt
//
//  Created by hwj on 15/9/10.
//  Copyright (c) 2015年 traveksky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DSATypePublic,
    DSATypePrivate
}DSAType;

@interface DTDSASign : NSObject
/*!
 @property
 @abstract 私钥
 */
@property(nonatomic,copy) NSString *privateKey;
/*!
 @property
 @abstract 公钥
 */
@property(nonatomic,copy) NSString *publicKey;

/*!
 @method
 @abstract 传入公钥和私钥
 @discussion 传入公钥和私钥
 
 @param privateKey  -----BEGIN DSA PRIVATE KEY-----密钥-----END DSA PRIVATE KEY-----
 @param publicKey  -----BEGIN PUBLIC KEY-----密钥-----END PUBLIC KEY-----
 
 @return DSASign对象
 */
- (id)initWithPrivateKey:(NSString *)privateKey
               publicKey:(NSString *)publicKey;

/*!
 @method
 @abstract DSA签名
 @discussion DSA签名
 
 @param data 要签名的数据
 
 @return 签名后的数据
 */
- (NSData *)sign:(NSData *)data;

/*!
 @method
 @abstract DSA验签
 @discussion DSA验签
 
 @param data      原数据
 @param signature 签名后的数据
 
 @return 是否成功
 */
- (BOOL)verify:(NSData *)data withSignature:(NSData *)signature;
@end
