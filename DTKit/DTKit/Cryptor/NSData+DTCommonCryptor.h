//
//  NSData+CommonCryptor.h
//  DTKit
//
//  Created by 文杰 on 15/10/11.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

//对称加密
@interface NSData (DTCommonCryptor)
/*!
 @method
 @abstract AES加密
 @discussion AES加密
 
 @param key   密钥
 @param iv    初始化向量，非ecb模式必须，长度128bit
 @param error 错误
 
 @return 加密后数据
 */
- (NSData *)dt_AESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
/*!
 @method
 @abstract AES解密
 @discussion AES解密，密文必须为base64编码
 
 @param key   密钥
 @param iv    初始化向量，非ecb模式必须，长度128bit
 @param error 错误
 
 @return 解密后数据
 */
- (NSData *)dt_AESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
/*!
 @method
 @abstract 3DES加密
 @discussion 3DES加密
 
 @param key   密钥，长度为192bit
 @param iv    初始化向量，非ecb模式必须，长度64bit
 @param error 错误
 
 @return 加密后数据
 */
- (NSData *)dt_DESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
/*!
 @method
 @abstract 3DES加密
 @discussion 3DES加密
 
 @param key   密钥
 @param iv    初始化向量，非ecb模式必须，长度64bit
 @param error 错误
 
 @return 加密后数据
 */
- (NSData *)dt_DESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
@end
