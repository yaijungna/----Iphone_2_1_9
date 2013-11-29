//
//  ImageDownLoader.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-15.
//
//

#import "ImageDownLoader.h"
#import "NSString+base64.h"
#import "MemCache.h"
@implementation ImageDownLoader
-(id)initWithUrl:(NSURL *)aUrl  andDelegate:(id)delegate
{
    if (self = [super init]) {
        _delegate = delegate;
        _targetUrl= [aUrl retain];
        _data     = [[NSMutableData alloc]init];
        NSURLRequest * request = [[NSURLRequest alloc]initWithURL:aUrl];
        
        _connect  = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [_connect scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_connect start];
    }
    return self;
}
-(void)cancel
{
    if (_connect) {
        [_connect cancel];
        [_connect release];
        _connect = nil;
    }
}
-(void)dealloc
{
    [_data release];
    [_targetUrl release];
    [_connect release];
    [super dealloc];
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
    NSString * filename = [filePrefix stringByAppendingString:[NSString encodeBase64String:_targetUrl.absoluteString]];
    
    NSMutableDictionary * usrInfo = [[NSMutableDictionary alloc]init];
    
    [_data writeToFile:filename atomically:NO];
    MemCache * mem = [MemCache sharedMemCache];
    [mem insertUIImage:[UIImage imageWithData:_data] forKey:_targetUrl.absoluteString];
    [usrInfo setValue:_data forKey:@"UIImagedata"];
    [usrInfo setValue:_targetUrl forKey:@"URL"];
    NSLog(@">>>>>>>>>>>>>>%@",_targetUrl);
    if ([_delegate respondsToSelector:@selector(finishLoad:)]) {
        [_delegate finishLoad:usrInfo];
    }
}



@end
