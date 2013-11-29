//
//  ImageDownLoader.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-15.
//
//

#import <Foundation/Foundation.h>

@interface ImageDownLoader : NSObject<NSURLConnectionDelegate>
{
    id _delegate;
    NSURL           * _targetUrl;
    NSMutableData   * _data;
    NSURLConnection * _connect;
}

-(id)initWithUrl:(NSURL *)aUrl  andDelegate:(id)delegate;
-(void)cancel;
-(void)finishLoad:(NSMutableDictionary*)aDict;
@end
