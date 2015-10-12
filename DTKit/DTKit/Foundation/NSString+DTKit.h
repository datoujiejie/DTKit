//
//  NSString+DTKit.h
//  DTKit
//
//  Created by 文杰 on 15/8/30.
//  Copyright (c) 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DTKit)
#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)dt_md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)dt_sha1String;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)dt_sha256String;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)dt_sha512String;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key The hmac key.
 */
- (NSString *)dt_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)dt_crc32String;


#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns an NSString for base64 encoded.
 */
- (NSString *)dt_base64Encoding;

/**
 Returns an NSData for base64 decoded.
 */
- (NSData *)dt_base64Decoding;

/**
 Returns an NSString from base64 encoded string.
 @param base64Encoding The encoded string.
 */
+ (NSString *)dt_stringWithBase64Encoding:(NSString *)base64Encoding;

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *)dt_stringByURLEncode;

/**
 URL decode a string in utf-8.
 @return the decoded string.
 */
- (NSString *)dt_stringByURLDecode;

/**
 URL encode a string.
 @param encoding  The encoding to use.
 @return URL encoded string
 */
- (NSString *)dt_stringByURLEncode:(NSStringEncoding)encoding;

/**
 URL encode a string.
 @param encoding  The encoding to use.
 @return URL encoded string
 */
- (NSString *)dt_stringByURLDecode:(NSStringEncoding)encoding;

/**
 Escape commmon HTML to Entity.
 Example: "a<b" will be escape to "a&lt;b".
 */
- (NSString *)dt_stringByEscapingHTML;

#pragma mark - Drawing
///=============================================================================
/// @name Drawing
///=============================================================================

/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize)dt_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 Returns the width of the string if it were to be rendered with the specified
 font on a single line.
 
 @param font  The font to use for computing the string width.
 
 @return      The width of the resulting string's bounding box. These values may be
 rounded up to the nearest whole number.
 */
- (CGFloat)dt_widthForFont:(UIFont *)font;

/**
 Returns the height of the string if it were rendered with the specified constraints.
 
 @param font   The font to use for computing the string size.
 
 @param width  The maximum acceptable width for the string. This value is used
 to calculate where line breaks and wrapping would occur.
 
 @return       The height of the resulting string's bounding box. These values
 may be rounded up to the nearest whole number.
 */
- (CGFloat)dt_heightForFont:(UIFont *)font width:(CGFloat)width;


#pragma mark - Regular Expression
///=============================================================================
/// @name Regular Expression
///=============================================================================

/**
 Whether it can match the regular expression
 
 @param regex  The regular expression
 
 @return YES if can match the regex; otherwize, NO.
 */
- (BOOL)dt_matchesRegex:(NSString *)regex;

/**
 Match the regular expression, and executes a given block using each object in the matches.
 
 @param regex The regular expression
 
 @param block The block to apply to elements in the array of matches.
 The block takes four arguments:
 match: The match substring.
 index: The index of the element in matches.
 matchRange: The match range in this string.
 stop: A reference to a Boolean value. The block can set the value
 to YES to stop further processing of the array. The stop
 argument is an out-only argument. You should only ever set
 this Boolean to YES within the Block.
 */
- (void)dt_enumerateRegexMatches:(NSString *)regex
                      usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block;

/**
 Returns a new string containing matching regular expressions replaced with the template string.
 
 @param regex       The regular expression
 
 @param replacement The substitution template used when replacing matching instances.
 
 @return A string with matching regular expressions replaced by the template string.
 */
- (NSString *)dt_stringByReplacingRegex:(NSString *)regex withString:(NSString *)replacement;


#pragma mark - Emoji
///=============================================================================
/// @name Emoji
///=============================================================================

/**
 Whether the receiver contains Apple Emoji (Unicode 6.0 standard 'unified').
 */
- (BOOL)dt_containsEmoji;

/**
 Returns all Apple Emoji combines in a string.
 */
+ (NSString *)dt_allEmoji;

/**
 Returns grouped Apple Emoji combines in a string.
 
 @param group Emoji group, support value: @"people" @"nature" @"object" @"places" @"symbols"
 */
+ (NSString *)dt_allEmojiByGroup:(NSString *)group;

/**
 Returns all Apple Emoji combines in an array.
 */
+ (NSArray *)dt_allEmojiArray;

/**
 Returns grouped Apple Emoji combines in an array.
 
 @param group Emoji group, support value: @"people" @"nature" @"object" @"places" @"symbols"
 */
+ (NSArray *)dt_allEmojiArrayByGroup:(NSString *)group;


#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================

/**
 Returns a new UUID NSString
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
+ (NSString *)dt_stringWithUUID;

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)dt_stringByTrim;

/**
 Add scale modifier to the file name (without path extension),
 From @"name" to @"name@2x".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon.top" </td><td>"icon.top@2x" </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)dt_stringByAppendingNameScale:(CGFloat)scale;

/**
 Add scale modifier to the file path (with path extension),
 From @"name.png" to @"name@2x.png".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon."    </td><td>"icon.@2x"    </td></tr>
 <tr><td>"icon.png" </td><td>"icon@2x.png" </td></tr>
 <tr><td>"icon..png"</td><td>"icon.@2x.png"</td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
- (NSString *)dt_stringByAppendingPathScale:(CGFloat)scale;

/**
 Return the path scale.
 
 e.g.
 <table>
 <tr><th>Path            </th><th>Scale </th></tr>
 <tr><td>"icon.png"      </td><td>1     </td></tr>
 <tr><td>"icon@2x.png"   </td><td>2     </td></tr>
 <tr><td>"icon@2.5x.png" </td><td>2.5   </td></tr>
 <tr><td>"icon@2x"       </td><td>1     </td></tr>
 <tr><td>"icon@2x..png"  </td><td>1     </td></tr>
 <tr><td>"icon@2x.png/"  </td><td>1     </td></tr>
 </table>
 */
- (CGFloat)dt_pathScale;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)dt_isNotBlank;

/**
 Whether the receiver contains the given `string`.
 @param string A string to test the the receiver for
 */
- (BOOL)dt_containsString:(NSString *)string;

/**
 Whether the receiver contains the character in set.
 @param set  A character set to test the the receiver for
 */
- (BOOL)dt_containsCharacterSet:(NSCharacterSet *)set;

/**
 Try to parse this string and Returns an NSNumber.
 These format is valid: @"123" @".12f" @" 0x12FF "
 @return Returns NSNumber if parse success, Returns nil if an error occurs.
 */
- (NSNumber *)dt_numberValue;

/**
 Returns an NSData using UTF-8 encoding.
 */
- (NSData *)dt_dataValue;

/**
 Returns an NSDictionary/NSArray which is decoded from receiver.
 Returns nil if an error occurs.
 
 e.g. NSString: @"{"name":"a","count":2}"  => NSDictionary: @[@"name":@"a",@"count":@2]
 */
- (id)dt_jsonValueDecoded;

@end
