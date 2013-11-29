//
//
//  UIImageView+UIImageViewCache.m
//  LygImageCache
//
//  Created by lygn128 on 13-11-12.
//  Copyright (c) 2013年 lygn128. All rights reserved.
//

#import "UIImageView+UIImageViewCache.h"
#import "UIImageManger.h"
#import "NSString+base64.h"
#import "MemCache.h"
@implementation UIImageView (UIImageViewCache)


-(void)setImageUrl:(NSURL*)aUrl  placeHolerImage:(UIImage *)aImage
{
    NSLog(@"^^^^^^^^%p %@ ",self,aUrl);
    self.image = aImage;
    UIImageManger * manger = [UIImageManger sharedManger];
    static NSString * filePrefix = nil;
    if (filePrefix == nil) {
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        filePrefix  =[paths    objectAtIndex:0];
        [filePrefix retain];
    }
    NSString * filename = [filePrefix stringByAppendingString:[NSString encodeBase64String:aUrl.absoluteString]];
    MemCache * mem = [MemCache sharedMemCache];
    UIImage * cacheImage = [mem getImageWithUrl:aUrl];
    if (cacheImage) {
        self.image = cacheImage;
        return;
    }
    UIImage * image = [[UIImage alloc]initWithContentsOfFile:filename];
    if (image) {
        NSLog(@"VVVVVVVVVVV%p %@ ",self,aUrl);
        self.image = image;
        [self setNeedsDisplay];
        [image release];
    }else
    {
         [manger downLoadUrl:aUrl andDelegate:self];
    }
}
@end
