//
//  FSOpration.h
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 13-1-30.
//
//

#import <Foundation/Foundation.h>
#import "FSNetworkData.h"

@interface FSOpration : NSOperation <FSNetworkDataDelegate>{
    NSString *_urlString;
    NSString *_localFile;
    id _delegate;
}
@property(nonatomic,assign)id delegate;
@property(nonatomic,strong)FSNetworkData * netWorkData;
-(id)initWithURL:(NSString *)URLString withLocalFilePath:(NSString *)localFilePath withDelegate:(id)delegate;



@end
