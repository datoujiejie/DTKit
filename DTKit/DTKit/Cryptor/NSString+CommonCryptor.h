//
//  NSString+CommonCryptor.h
//  DTKit
//
//  Created by 文杰 on 15/10/11.
//  Copyright © 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CommonCryptor)
- (NSString *)AESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
- (NSString *)AESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
- (NSString *)DESEncryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
- (NSString *)DESDecryptedDataUsingKey:(id)key
                                  iv:(id)iv
                               error:(NSError **)error;
@end
