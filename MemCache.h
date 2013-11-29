//
//  MemCache.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-18.
//
//

#import <Foundation/Foundation.h>

@interface MemCache : NSObject
{
    NSMutableDictionary * _cacheDict;
}
+(MemCache*)sharedMemCache;
-(void)insertUIImage:(UIImage*)aImage forKey:(NSString*)urlString;
-(UIImage*)getImageWithUrl:(NSURL*)aUrl;
@end
