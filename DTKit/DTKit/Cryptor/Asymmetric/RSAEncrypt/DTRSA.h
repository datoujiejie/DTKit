/*!
 @header
 @abstract RSA加解密封装类
 @author houwenjie, 15-06-25 14:06:40
 
 @version 1.0
 */
#import <Foundation/Foundation.h>
/*!
 @class
 @abstract RSA加解密、签名封装类
 */
@interface DTRSA : NSObject
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
 
 @param privateKey  -----BEGIN RSA PRIVATE KEY-----密钥-----END RSA PRIVATE KEY-----
 @param publicKey  -----BEGIN PUBLIC KEY-----密钥-----END PUBLIC KEY-----
 
 @return RSAEncrypt对象
 */
- (id)initWithPrivateKey:(NSString *)privateKey
               publicKey:(NSString *)publicKey;

#pragma mark - Encrypt
///=============================================================================
/// @name Encrypt
///=============================================================================
/*!
 @method
 @abstract 公钥加密字符串
 @discussion 公钥加密字符串
 
 @param plainString 要加密的字符串
 
 @return 返回加密后的base64字符串
 */
- (NSString *)publicEncryptWithString:(NSString *)plainString;

/*!
 @method
 @abstract 公钥加密NSData
 @discussion 公钥加密NSData
 
 @param plainString 要加密的NSData
 
 @return 返回加密后的base64字符串
 */
- (NSString *)publicEncryptWithData:(NSData *)data;

/*!
 @method
 @abstract 私钥加密字符串
 @discussion 私钥加密字符串
 
 @param plainString 要加密的字符串
 
 @return 返回加密后的base64字符串
 */
- (NSString *)privateEncryptWithString:(NSString *)plainString;

/*!
 @method
 @abstract 私钥加密字符串
 @discussion 私钥加密字符串
 
 @param plainString 要加密的字符串
 
 @return 返回加密后的base64字符串
 */
- (NSString *)privateEncryptWithData:(NSData *)data;

/*!
 @method
 @abstract 公钥解密
 @discussion 公钥解密
 
 @param string 要解密的base64String
 
 @return NSData对象
 */
- (NSData *)publicDecryptWithString:(NSString *)string;

/*!
 @method
 @abstract 私钥解密
 @discussion 私钥解密
 
 @param string 要解密的base64String
 
 @return NSData对象
 */
- (NSData *)privateDecryptWithString:(NSString *)string;

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
- (NSString *)signWithString:(NSString *)plainString;

/*!
 @method
 @abstract 公钥加密NSData
 @discussion 公钥加密NSData
 
 @param plainString 要加密的NSData
 
 @return 返回加密后的base64字符串
 */
- (NSString *)signWithData:(NSData *)data;

/*!
 @method
 @abstract 私钥加密字符串
 @discussion 私钥加密字符串
 
 @param plainString 源数据
 @param signature  签名后的base64字符串
 
 @return 校验结果
 */
- (BOOL)verifyWithString:(NSString *)plainString
               signature:(NSString *)signature;


/*!
 @method
 @abstract 私钥加密字符串
 @discussion 私钥加密字符串
 
 @param data      原数据
 @param signature 签名后的数据
 
 @return 校验结果
 */
- (BOOL)verifyWithData:(NSData *)data withSignature:(NSData *)signature;
@end
