//
//  NSDictionary+DTKit.m
//  CacheTest
//
//  Created by Alex on 15/10/20.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "NSDictionary+DTKit.h"

@implementation NSDictionary (DTKit)
- (NSString *)dt_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:0
                                                             error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData
                                               encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}
@end

@implementation NSMutableDictionary (DTKit)

- (void)dt_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

@end