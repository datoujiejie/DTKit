//
//  NSData+CommonCryptor.h
//  DTKit
//
//  Created by 文杰 on 15/10/11.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

//对称加密
@interface NSData (CommonCryptor)
- (NSData *)AESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
- (NSData *)AESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
- (NSData *)DESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
- (NSData *)DESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
@end
