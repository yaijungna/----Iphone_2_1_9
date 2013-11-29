//
//  UIImageView+UIImageViewCache.h
//  LygImageCache
//
//  Created by lygn128 on 13-11-12.
//  Copyright (c) 2013年 lygn128. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (UIImageViewCache)
-(void)setImageUrl:(NSURL*)aUrl  placeHolerImage:(UIImage *)aImage;
@end
