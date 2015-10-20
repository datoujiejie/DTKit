//
//  NSCharacterSet+DTKit.m
//  DTKit
//
//  Created by 文杰 on 15/8/30.
//  Copyright (c) 2015年 datoujiejie. All rights reserved.
//

#import "NSCharacterSet+DTKit.h"
#import "NSString+DTKit.h"

@implementation NSCharacterSet (DTKit)

+ (NSCharacterSet *)dt_emojiCharacterSet {
    static NSCharacterSet *set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [NSCharacterSet characterSetWithCharactersInString:[NSString dt_allEmoji]];
    });
    return set;
}

@end


@implementation NSMutableCharacterSet (DTKit)

+ (NSMutableCharacterSet *)dt_emojiCharacterSet {
    static NSMutableCharacterSet *set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [NSCharacterSet dt_emojiCharacterSet].mutableCopy;
    });
    return set;
}

@end
