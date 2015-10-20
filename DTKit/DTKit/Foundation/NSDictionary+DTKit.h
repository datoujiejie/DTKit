//
//  NSDictionary+DTKit.h
//  CacheTest
//
//  Created by Alex on 15/10/20.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DTKit)
/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (NSString *)dt_jsonStringEncoded;
@end


@interface NSMutableDictionary (DTKit)
- (void)dt_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end