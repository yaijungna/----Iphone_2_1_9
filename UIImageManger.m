//
//  UIImageManger.m
//  LygImageCache
//
//  Created by lygn128 on 13-11-12.
//  Copyright (c) 2013年 lygn128. All rights reserved.
//

#import "UIImageManger.h"
#import "UIimageDownloadOperation.h"
#import "ImageDownLoader.h"
static UIImageManger * manger = nil;
@implementation UIImageManger
+(UIImageManger*)sharedManger
{
    if (!manger) {
        @synchronized (self)
        {
            manger = [[UIImageManger alloc]init];
        }
    }
    return  manger;
}
+(id)alloc
{
    if (!manger) {
        @synchronized (self)
        {
            manger = [super alloc];
        }
    }
    return manger;
   
}
-(void)dealloc
{
    [_delegates release];
    [_urls      release];
    [_downLoads release];
    [super      dealloc];
}
-(id)init
{
    if (self = [super init]) {
        _delegates = [[NSMutableArray      alloc] init];
        _urls      = [[NSMutableArray      alloc] init];
        _downLoads = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)cancelDelegate:(id)delegate withUrl:(NSURL*)aUrl
{
    NSUInteger idx;
    while ((idx = [_delegates indexOfObjectIdenticalTo:delegate])!= NSNotFound) {
        @synchronized (self)
        {
            [_delegates removeObjectAtIndex:idx];
            [_urls      removeObjectAtIndex:idx];
        }
    }
    ImageDownLoader * tempdoload = [self.downLoads valueForKey:aUrl.absoluteString];
    if (tempdoload) {
        [tempdoload cancel];
        [self.downLoads removeObjectForKey:aUrl.absoluteString];
    }
}
-(void)finishLoad:(NSDictionary *)aDict
{
    NSURL * url = (NSURL*)[aDict valueForKey:@"URL"];
    //NSArray * arrytemp = [NSArray arrayWithArray:_urls];
    NSMutableArray * arrytemp    = [[NSMutableArray alloc]initWithArray:_urls];
    NSMutableArray * arrytemp2   =   [[NSMutableArray alloc] initWithArray:_delegates];
    NSUInteger idx;
    while ((idx = [arrytemp indexOfObject:url])!= NSNotFound) {
        UIImageView * view = (UIImageView*)[arrytemp2 objectAtIndex:idx];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage * image    = [[UIImage alloc]initWithData:[aDict valueForKey:@"UIImagedata"]];
            view.image         = image;
            [image  release];
            [view setNeedsDisplay];
            
        });
        [arrytemp       removeObjectAtIndex:idx];
        [arrytemp2      removeObjectAtIndex:idx];
        
    }
    [arrytemp  release];
    [arrytemp2 release];
    if ([self.downLoads valueForKey:url.absoluteString]) {
        [self.downLoads removeObjectForKey:url.absoluteString];
    }
}
-(void)downLoadUrl:(NSURL*)aUrl andDelegate:(id)delegate
{
    [self cancelDelegate:delegate withUrl:aUrl];
    @synchronized (self)
    {
        [self.urls      addObject:aUrl];
        [self.delegates addObject:delegate];
    }
    if ([self.downLoads valueForKey:aUrl.absoluteString]) {
        return;
    }
    ImageDownLoader * tempDownload = [[ImageDownLoader alloc]initWithUrl:aUrl andDelegate:self];
    @synchronized (self)
    {
        [self.downLoads setValue:tempDownload forKey:aUrl.absoluteString];
    }
    [tempDownload release];
}
@end
