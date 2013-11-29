//
//  LygDeepCommentPostDao.h
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "FS_GZF_BasePOSTXMLDAO.h"
@interface LygDeepCommentPostDao : FS_GZF_BasePOSTXMLDAO
{
    NSString  * _deepid;
    NSString  *_content;
    NSString  *_username;
    BOOL       _isSuccessful;
    NSString  *_result;
}
@property(nonatomic,retain)NSString * deepid;
@property(nonatomic,retain)NSString * content;
@property(nonatomic,retain)NSString * username;
@property(nonatomic,assign)BOOL       isSuccessful;
@property(nonatomic,retain)NSString       *result;
@end



/*@interface FS_GZF_NewsCommentPOSTXMLDAO : FS_GZF_BasePOSTXMLDAO{
@protected
    NSString *_newsid;
    NSString *_channelid;
    NSString *_content;
    NSString *_username;
    BOOL _isSuccessful;
    
    NSString *_result;
}


@property (nonatomic,retain)  NSString *newsid;
@property (nonatomic,retain)  NSString *channelid;
@property (nonatomic,retain)  NSString *content;
@property (nonatomic,retain)  NSString *username;

@property (nonatomic,retain)  NSString *result;


@end*/