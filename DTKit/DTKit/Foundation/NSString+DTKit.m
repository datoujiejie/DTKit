//
//  NSString+DTKit.m
//  DTKit
//
//  Created by 文杰 on 15/8/30.
//  Copyright (c) 2015年 datoujiejie. All rights reserved.
//

#import "NSString+DTKit.h"
#import "NSData+DTKit.h"
#import "DTKitMacro.h"
#import "NSNumber+DTKit.h"
#import "NSCharacterSet+DTKit.h"

@implementation NSString (DTKit)

- (NSString *)dt_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_md5String];
}

- (NSString *)dt_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_sha1String];
}

- (NSString *)dt_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_sha256String];
}

- (NSString *)dt_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_sha512String];
}

- (NSString *)dt_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_crc32String];
}

- (NSString *)dt_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacMD5StringWithKey:key];
}

- (NSString *)dt_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacSHA1StringWithKey:key];
}

- (NSString *)dt_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacSHA256StringWithKey:key];
}

- (NSString *)dt_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            dt_hmacSHA512StringWithKey:key];
}

- (NSString *)dt_base64Encoding {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] dt_base64Encoding];
}

+ (NSString *)dt_stringWithBase64Encoding:(NSString *)base64Encoding {
    NSData *data = [NSData dt_dataWithBase64Encoding:base64Encoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)dt_stringByURLEncode {
    return [self dt_stringByURLEncode:NSUTF8StringEncoding];
}

- (NSString *)dt_stringByURLDecode {
    return [self dt_stringByURLDecode:NSUTF8StringEncoding];
}

- (NSString *)dt_stringByURLEncode:(NSStringEncoding)encoding {
    NSString *encoded = (__bridge_transfer NSString *)
    CFURLCreateStringByAddingPercentEscapes(
                                            NULL,
                                            (__bridge CFStringRef)self,
                                            NULL,
                                            CFSTR("!#$&'()*+,/:;=?@[]"),
                                            (CFStringEncoding)encoding);
    return encoded;
}

- (NSString *)dt_stringByURLDecode:(NSStringEncoding)encoding {
    CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(encoding);
    NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                        withString:@" "];
    decoded = (__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                            NULL,
                                                            (__bridge CFStringRef)decoded,
                                                            CFSTR(""),
                                                            en);
    return decoded;
}

- (NSString *)dt_stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

- (CGSize)dt_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = @{}.mutableCopy;
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return CGSizeCeil(result);
}

- (CGFloat)dt_widthForFont:(UIFont *)font {
    CGSize size = [self dt_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)dt_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self dt_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (BOOL)dt_matchesRegex:(NSString *)regex {
    NSError *error = nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
    if (error) {
        NSLog(@"NSString+YYAdd create regex error: %@", error);
        return NO;
    }
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

- (void)dt_enumerateRegexMatches:(NSString *)regex
                      usingBlock:(void (^)(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop))block {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSArray *matches = [pattern matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    if (matches.count > 0) {
        [matches enumerateObjectsUsingBlock: ^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {
            block([self substringWithRange:result.range], idx, result.range, stop);
        }];
    }
}

- (NSString *)dt_stringByReplacingRegex:(NSString *)regex withString:(NSString *)replacement {
    NSError *error = nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
    if (error) {
        NSLog(@"NSString+YYAdd create regex error: %@", error);
        return nil;
    }
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

- (BOOL)dt_containsEmoji {
    return [self dt_containsCharacterSet:[NSCharacterSet dt_emojiCharacterSet]];
}

+ (NSString *)dt_allEmoji {
    static NSMutableString *str = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        str = @"".mutableCopy;
        NSArray *keys = @[@"people", @"nature", @"object", @"places", @"symbols"];
        for (NSString *key in keys) {
            [str appendString:[self dt_allEmojiByGroup:key]];
        }
    });
    return str;
}

+ (NSString *)dt_allEmojiByGroup:(NSString *)group {
    static NSDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{
                @"people" : @"😄😃😀😊☺️😉😍😘😚😗😙😜😝😛😳😁😔😌😒😞😣😢😂😭😪😥😰😅😓😩😫😨😱😠😡😤😖😆😋😷😎😴😵😲😟😦😧😈👿😮😬😐😕😯😶😇😏😑👲👳👮👷💂👶👦👧👨👩👴👵👱👼👸😺😸😻😽😼🙀😿😹😾👹👺🙈🙉🙊💀👽💩🔥✨🌟💫💥💢💦💧💤💨👂👀👃👅👄👍👎👌👊✊✌️👋✋👐👆👇👉👈🙌🙏☝️👏💪🚶🏃💃👫👪👬👭💏💑👯🙆🙅💁🙋💆💇💅👰🙎🙍🙇🎩👑👒👟👞👡👠👢👕👔👚👗🎽👖👘👙💼👜👝👛👓🎀🌂💄💛💙💜💚❤️💔💗💓💕💖💞💘💌💋💍💎👤👥💬👣💭",
                @"nature": @"🐶🐺🐱🐭🐹🐰🐸🐯🐨🐻🐷🐽🐮🐗🐵🐒🐴🐑🐘🐼🐧🐦🐤🐥🐣🐔🐍🐢🐛🐝🐜🐞🐌🐙🐚🐠🐟🐬🐳🐋🐄🐏🐀🐃🐅🐇🐉🐎🐐🐓🐕🐖🐁🐂🐲🐡🐊🐫🐪🐆🐈🐩🐾💐🌸🌷🍀🌹🌻🌺🍁🍃🍂🌿🌾🍄🌵🌴🌲🌳🌰🌱🌼🌐🌞🌝🌚🌑🌒🌓🌔🌕🌖🌗🌘🌜🌛🌙🌍🌎🌏🌋🌌🌠⭐️☀️⛅️☁️⚡️☔️❄️⛄️🌀🌁🌈🌊",
                @"object" : @"🎍💝🎎🎒🎓🎏🎆🎇🎐🎑🎃👻🎅🎄🎁🎋🎉🎊🎈🎌🔮🎥📷📹📼💿📀💽💾💻📱☎️📞📟📠📡📺📻🔊🔉🔈🔇🔔🔕📢📣⏳⌛️⏰⌚️🔓🔒🔏🔐🔑🔎💡🔦🔆🔅🔌🔋🔍🛁🛀🚿🚽🔧🔩🔨🚪🚬💣🔫🔪💊💉💰💴💵💷💶💳💸📲📧📥📤✉️📩📨📯📫📪📬📭📮📦📝📄📃📑📊📈📉📜📋📅📆📇📁📂✂️📌📎✒️✏️📏📐📕📗📘📙📓📔📒📚📖🔖📛🔬🔭📰🎨🎬🎤🎧🎼🎵🎶🎹🎻🎺🎷🎸👾🎮🃏🎴🀄️🎲🎯🏈🏀⚽️⚾️🎾🎱🏉🎳⛳️🚵🚴🏁🏇🏆🎿🏂🏊🏄🎣☕️🍵🍶🍼🍺🍻🍸🍹🍷🍴🍕🍔🍟🍗🍖🍝🍛🍤🍱🍣🍥🍙🍘🍚🍜🍲🍢🍡🍳🍞🍩🍮🍦🍨🍧🎂🍰🍪🍫🍬🍭🍯🍎🍏🍊🍋🍒🍇🍉🍓🍑🍈🍌🍐🍍🍠🍆🍅🌽",
                @"places" : @"🏠🏡🏫🏢🏣🏥🏦🏪🏩🏨💒⛪🏬🏤🌇🌆🏯🏰⛺🏭🗼🗾🗻🌄🌅🌃🗽🌉🎠🎡⛲🎢🚢⛵🚤🚣⚓🚀✈💺🚁🚂🚊🚉🚞🚆🚄🚅🚈🚇🚝🚋🚃🚎🚌🚍🚙🚘🚗🚕🚖🚛🚚🚨🚓🚔🚒🚑🚐🚲🚡🚟🚠🚜💈🚏🎫🚦🚥⚠🚧🔰⛽🏮🎰♨🗿🎪🎭📍🚩🇯🇵🇰🇷🇩🇪🇨🇳🇺🇸🇫🇷🇪🇸🇮🇹🇷🇺🇬🇧",
                @"symbols":@"1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣0️⃣🔟🔢🔣⬆⬇⬅➡🔠🔡🔤↗️↖️↘️↙️↔️↕️🔄◀▶🔼🔽↩↪ℹ⏪⏩⏫⏬⤵⤴🆗🔀🔁🔂🆕🆙🆒🆓🆖📶🎦🈁🈯🈳🈵🈴🈲🉐🈹🈺🈶🈚🚻🚹🚺🚼🚾🚰🚮🅿♿🚭🈷🈸🈂Ⓜ🛂🛄🛅🛃🉑㊙㊗🆑🆘🆔🚫🔞📵🚯🚱🚳🚷🚸⛔✳❇❎✅✴💟🆚📳📴🅰🅱🆎🅾💠➿♻♈♉♊♋♌♍♎♏♐♑♒♓⛎🔯🏧💹💲💱©®™❌‼⁉❗❓❕❔⭕🔝🔚🔙🔛🔜🔃🕛🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦✖️➕➖➗♠️♥️♣️♦️💮💯✔️☑️🔘🔗➰〰〽️🔱◼️◻️◾️◽️▪️▫️🔺🔲🔳⚫️⚪️🔴🔵🔻⬜️⬛️🔶🔷🔸🔹"
                };
    });
    return group ? dic[group] : nil;
}

+ (NSArray *)dt_allEmojiArray {
    static NSMutableArray *arr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arr = @[].mutableCopy;
        NSString *str = [self dt_allEmoji];
        [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            [arr addObject:substring];
        }];
    });
    return arr;
}

+ (NSArray *)dt_allEmojiArrayByGroup:(NSString *)group {
    static NSMutableDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{}.mutableCopy;
        NSArray *keys = @[@"people", @"nature", @"object", @"places", @"symbols"];
        for (NSString *key in keys) {
            NSMutableArray *arr = @[].mutableCopy;
            NSString *str = [self dt_allEmojiByGroup:key];
            [str enumerateSubstringsInRange:NSMakeRange(0, str.length)
                                    options:NSStringEnumerationByComposedCharacterSequences
                                 usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                [arr addObject:substring];
            }];
            dic[key] = arr;
        }
    });
    return group ? dic[group] : nil;
}

+ (NSString *)dt_stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

- (NSString *)dt_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)dt_stringByAppendingNameScale:(CGFloat)scale {
    if (scale - 1 <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    return [self stringByAppendingFormat:@"@%@x", @(scale)];
}

- (NSString *)dt_stringByAppendingPathScale:(CGFloat)scale {
    if (scale - 1 <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    NSString *ext = self.pathExtension;
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) extRange.location -= 1;
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (CGFloat)dt_pathScale {
    if (self.length == 0 || [self hasSuffix:@"/"]) return 1;
    NSString *name = self.stringByDeletingPathExtension;
    __block CGFloat scale = 1;
    [name dt_enumerateRegexMatches:@"@[0-9]+\\.?[0-9]*x$"
                        usingBlock: ^(NSString *match, NSInteger index, NSRange matchRange, BOOL *stop) {
        scale = [match substringWithRange:NSMakeRange(1, match.length - 2)].doubleValue;
    }];
    return scale;
}

- (BOOL)dt_isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)dt_containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)dt_containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (NSNumber *)dt_numberValue {
    return [NSNumber dt_numberWithString:self];
}

- (NSData *)dt_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)dt_jsonValueDecoded {
    return [[self dt_dataValue] dt_jsonValueDecoded];
}
@end