//
//  NSString+base64.h
//  LygImageCache
//
//  Created by lygn128 on 13-11-12.
//  Copyright (c) 2013年 lygn128. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (base64)
+ (NSString*)encodeBase64String:(NSString*)input;
+ (NSString*)decodeBase64String:(NSString*)input;
+ (NSString*)encodeBase64Data:(NSData*)data;
+ (NSString*)decodeBase64Data:(NSData*)data;
@end
