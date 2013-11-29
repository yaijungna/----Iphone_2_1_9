//
//  UIimageDownloadOperation.m
//  LygImageCache
//
//  Created by lygn128 on 13-11-12.
//  Copyright (c) 2013年 lygn128. All rights reserved.
//

#import "UIimageDownloadOperation.h"
#import "NSString+base64.h"
#import <Foundation/Foundation.h>
//static NSString* getDocumentPath()
//{
//    NSString * string = NSDocumentDirectory
//}

@implementation UIimageDownloadOperation
-(id)initWithUrl:(NSURL*)aUrl scheduInQueue:(NSOperationQueue*)aQueue andImageView:(UIImageView*)aImageView andDelegate:(id)delegate;
{
    if (self = [super init]) {
        self.targetUrl = aUrl;
        _data      = [[NSMutableData alloc]init];
        self.queue = aQueue;
        self.imageView = aImageView;
        self.delegate  = delegate;
    }
    return self;
}
-(void)dealloc
{
    self.imageView = nil;
    [_data release];
    _data = nil;
    [super dealloc];
}
-(void)main
{
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:self.targetUrl];
    _connect = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    [_connect setDelegateQueue:self.queue];
    [_connect start];
    [request release];
}

-(void)cancelConnect
{
    if (_connect) {
        [_connect cancel];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data  appendData:data];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    static NSString * filePrefix = nil;
    
    if (filePrefix == nil) {
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        filePrefix  =[paths    objectAtIndex:0];
        [filePrefix retain];
    }
    NSString * filename = [filePrefix stringByAppendingString:[NSString encodeBase64String:self.targetUrl.absoluteString]];
    
    NSMutableDictionary * usrInfo = [[NSMutableDictionary alloc]init];
    
    [_data writeToFile:filename atomically:NO];
    [usrInfo setValue:_data forKey:@"UIImagedata"];
    [usrInfo setValue:self.targetUrl forKey:@"URL"];
    [usrInfo setValue:self.imageView forKey:@"delegate"];
    
//    NSNotificationQueue * queue =  [NSNotificationQueue defaultQueue];
//    [queue postNotificationName:@"DownLoadOPerartinFinished" object:nil userInfo:usrInfo];
    if ([self.delegate respondsToSelector:@selector(finishLoad:)]) {
        [self.delegate finishLoad:usrInfo];
    }
}

@end
