//
//  NSCharacterSet+DTKit.h
//  DTKit
//
//  Created by 文杰 on 15/8/30.
//  Copyright (c) 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides extensions for `NSCharacterSet`.
 */
@interface NSCharacterSet (DTKit)

/**
 Returns a character set containing all Apple Emoji.
 */
+ (NSCharacterSet *)dt_emojiCharacterSet;

@end



/**
 Provides extensions for `NSMutableCharacterSet`.
 */
@interface NSMutableCharacterSet (DTKit)

/**
 Returns a character set containing all Apple Emoji.
 */
+ (NSMutableCharacterSet *)dt_emojiCharacterSet;

@end