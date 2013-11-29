//
//  UIImageManger.h
//  LygImageCache
//
//  Created by lygn128 on 13-11-12.
//  Copyright (c) 2013年 lygn128. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageManger : NSObject
@property(atomic,strong)NSMutableArray      * delegates;
@property(atomic,strong)NSMutableArray      * urls;
@property(atomic,strong)NSMutableDictionary * downLoads;
+(UIImageManger*)sharedManger;
-(void)downLoadUrl:(NSURL*)aUrl andDelegate:(id)delegate;
-(void)finishLoad:(NSDictionary*)aDict;
@end
