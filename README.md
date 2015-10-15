# DTKit
封装了一些常见工具类，目前主要添加了一些加解密、签名和哈希方法
###DES：
```
//加密
NSString *encryptStr = [@"string" dt_DESEncryptedDataUsingKey:key
                                                           iv:iv
                                                        error:&error];
//解密
NSString *decryptStr = [encryptStr dt_DESDecryptedDataUsingKey:key
                                                            iv:iv
                                                         error:&error];                                                        
```
###AES
```
//加密
NSString *encryptStr = [@"string" dt_AESEncryptedDataUsingKey:key
                                                           iv:iv
                                                        error:&error];
//解密
NSString *decryptStr = [encryptStr dt_AESDecryptedDataUsingKey:key
                                                            iv:iv
                                                         error:&error];   
```
###RSA
```
NSString *publicKey = @"-----BEGIN PUBLIC KEY-----密钥-----END PUBLIC KEY-----";
NSString *privateKey = @"-----BEGIN RSA PRIVATE KEY-----密钥-----END RSA PRIVATE KEY-----";
DTRSA *rsa = [[DTRSA alloc] initWithPrivateKey:privateKey
                                     publicKey:publicKey];
//用公钥加密
NSString *encryptStr = [rsa publicEncryptWithString:plainString];
//用私钥加密
NSSData *decryptData = [rsa privateDecryptWithString:encryptStr];                                     

```
###DSA
```
NSString *publicKey = @"-----BEGIN PUBLIC KEY-----密钥-----END PUBLIC KEY-----";
NSString *privateKey = @"-----BEGIN DSA PRIVATE KEY-----密钥-----END DSA PRIVATE KEY-----";
DTDSA *dsa = [[DTDSA alloc] initWithPrivateKey:privateKey
                                     publicKey:publicKey];
//签名
NSData *signData = [dsa sign:data];
//验签
BOOL verify = [dsa verify:plaindata withSignature:signData];

```

###HASH

```
NSString *md5 = [@"string" dt_md5String];
NSString *sha256String = [@"string" dt_sha256String];
...

```
