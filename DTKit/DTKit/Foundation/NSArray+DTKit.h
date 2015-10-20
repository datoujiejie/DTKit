//
//  NSArray+DTKit.h
//  DTKit
//
//  Created by 文杰 on 15/8/30.
//  Copyright (c) 2015年 datoujiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DTKit)
/**
 Returns the object located at index, or return nil when out of bounds.
 It's similar to `objectAtIndex:`, but it never throw exception.
 
 @param index The object located at index.
 */
- (id)dt_safeObjectAtIndex:(NSUInteger)index;

/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (NSString *)dt_jsonStringEncoded;
@end

@interface NSMutableArray (DTKit)

/**
 *  @brief  It's similar to `insertObject:atIndex:`, but it never throw exception.
 *
 *  @param anObject The object will be inserted.
 *  @param index    The object located at index.
 */
- (void)dt_safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

/**
 *  @brief  It's similar to `addObject:`, but it never throw exception.
 *
 *  @param anObject The object will be inserted.
 */
- (void)dt_safeAddObject:(id)anObject;

/**
 *  @brief It's similar to `removeObjectAtIndex:`, but it never throw exception.
 *
 *  @param index The object located at index.
 */
- (void)dt_safeRemoveObjectAtIndex:(NSUInteger)index;
@end

